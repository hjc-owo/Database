## TASK 1

### init

创建索引：

```sql
alter table A
    modify id int primary key;

alter table B
    modify id int,
    add index (id, number, hashNumber);

alter table C
    modify id int primary key,
    add index (hashNumber);

alter table D
    modify id int;
```

![截屏2022-04-29 19.04.50](https://cdn.jsdelivr.net/gh/hjc-owo/allImgs/img/202204291906605.png)

### Q1

```sql
select *
from A
where id > 2000000;
# 4s 946ms
# A 直接主键 id 作索引，显然最快。

select *
from B
where id > 2000000;
# 5s 519ms

select *
from C
where id > 2000000;
# 5s 537ms

select *
from D
where id > 2000000;
# 6s 314ms
```

![截屏2022-04-29 18.36.38](https://cdn.jsdelivr.net/gh/hjc-owo/allImgs/img/202204291837541.png)

### Q2

```sql
select *
from A
where hashNumber > 5;
# 4s 802ms

select *
from B
where hashNumber > 5;
# 3s 779ms

select *
from C
where hashNumber > 5;
# 4s 70ms

select *
from D
where hashNumber > 5;
# 4s 292ms
```

![截屏2022-04-29 18.42.09](https://cdn.jsdelivr.net/gh/hjc-owo/allImgs/img/202204291843759.png)

### Q3

```sql
select *
from A
where id > 2000000
  and number > 150000
  and hashNumber > 5;
# 2s 626ms

select *
from B
where id > 2000000
  and number > 150000
  and hashNumber > 5;
# 2s 467ms

select *
from C
where id > 2000000
  and number > 150000
  and hashNumber > 5;
# 2s 322ms

select *
from D
where id > 2000000
  and number > 150000
  and hashNumber > 5;
# 2s 727ms
```

![截屏2022-04-29 18.43.46](https://cdn.jsdelivr.net/gh/hjc-owo/allImgs/img/202204291845158.png)

### Q4

以 addA 为例。

```sql
create procedure addA(num int)
begin
    declare i int default 1;
    while i < num
        do
            insert into A(id, number, hashNumber)
            values (i + 4400000, round(rand() * 5000000), round(rand() * 9));
            set i = i + 1;
        end while;
end;

call addA(200000);
```

```sql 
addA() # 17s 120ms
addB() # 17s 371ms
addC() # 17s 188ms
addD() # 16s 257ms
# 由于 D 添加元素的时候不需要设置索引，所以更快。
```

![截屏2022-04-29 18.56.04](https://cdn.jsdelivr.net/gh/hjc-owo/allImgs/img/202204291857519.png)

## TASK 2

### 1 建表

```sql
create table fruits
(
    fid   int          not null auto_increment primary key,
    fname varchar(255) not null,
    price float
);

create table customer
(
    cid   int          not null auto_increment primary key,
    cname varchar(255) not null,
    level varchar(255) not null default 'normal'
);

create table sells
(
    fid      int      not null,
    cid      int      not null,
    sellTime datetime not null,
    quantity int,
    foreign key (fid) references fruits (fid),
    foreign key (cid) references customer (cid)
);
```

![截屏2022-04-29 11.04.45](https://cdn.jsdelivr.net/gh/hjc-owo/allImgs/img/202204291105824.png)

### 2 插入新的购买记录时

```sql
SET GLOBAL log_bin_trust_function_creators = 1;

create function cal(newCid int) returns int
begin
    declare total float default 0;
    select ifnull(sum(distinct price * quantity), 0)
    into total
    from sells
             inner join fruits on sells.fid = fruits.fid
    where sells.cid = newCid;
    return total;
end;

create procedure setLevel(newLevel varchar(255), newCid int)
begin
    update customer set level = newLevel where cid = newCid;
end;

delimiter //
create trigger buyFruits
    after insert
    on sells
    for each row
    if cal(new.cid) > 20000 then
        call setLevel('SVIP', new.cid);
    else
        if cal(new.cid) > 10000 then
            call setLevel('VIP', new.cid);
        end if;
    end if;
delimiter ;
```

### 3 删除购买记录时

```sql
delimiter //
create trigger delFruits
    after delete
    on sells
    for each row
    if cal(old.cid) <= 10000 then
        call setLevel('normal', old.cid);
    else
        if cal(old.cid) <= 20000 then
            call setLevel('VIP', old.cid);
        end if;
    end if;
delimiter ;
```

### 4 验证

```sql
insert into sells(fid, cid, sellTime, quantity)
values(1, 1, now(), 2001);
select * from customer where cid = 1; # VIP

insert into sells(fid, cid, sellTime, quantity)
values(2, 1, now(), 4001);
select * from customer where cid = 1; # SVIP

delete from sells
where fid = 1 and cid = 1;
select * from customer where cid = 1; # VIP

delete from sells
where fid = 2 and cid = 1;
select * from customer where cid = 1; # normal
```

![截屏2022-04-29 13.32.20](https://cdn.jsdelivr.net/gh/hjc-owo/allImgs/img/202204291332720.png)
