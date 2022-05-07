## TASK 1

### 建表

```sql
create table user
(
    id       int          not null auto_increment,
    name     varchar(255) not null unique,
    password varchar(255) not null,
    primary key (id),
    check (password regexp '^[a-zA-Z0-9]{4,10}$')
);

create table book
(
    ISBN   varchar(255) not null,
    name   varchar(255) not null,
    author varchar(255) not null,
    number int,
    primary key (ISBN)
);

create table borrow
(
    id          int          not null auto_increment,
    ISBN        varchar(255) not null,
    username    varchar(255) not null,
    borrow_date date         not null,
    due_date    date,
    return_date date,
    primary key (id),
    foreign key (ISBN) references Library.book (ISBN),
    foreign key (username) references Library.user (name)
);
```

### 1-1

```sql
create function checkPassword(
    checkName varchar(255),
    checkPassword varchar(255),
    newPassword varchar(255),
    op int) returns boolean
begin
    declare exist boolean;
    select exists(select *
                  from user
                  where name = checkName
                    and password = checkPassword)
    into exist;
    if exist then
        if op = 1 then
            return true;
        end if;
        if op = 2 and newPassword regexp '^[a-zA-Z0-9]{4,10}$' then
            update user set password = newPassword where name = checkName;
            return true;
        end if;
    end if;
    return false;
end;

select checkPassword('qwerty', '123456', '654321', 1); # 1
select checkPassword('qwerty', '123456', '654321', 2); # 1
select checkPassword('qwerty', '123456', '654321', 1); # 0
```

![截屏2022-04-22 14.17.54](https://cdn.jsdelivr.net/gh/hjc-owo/hjc-owo.github.io@img/202204221418808.png)

游标：

```sql
create function checkPassword(
    checkName varchar(255),
    checkPassword varchar(255),
    newPassword varchar(255),
    op int) returns boolean
begin
    declare found boolean default false;
    declare curName varchar(255);
    declare curPassword varchar(255);
    declare exist boolean default false;
    declare curUser cursor for select name, password from user;
    declare continue handler for not found set found = true;
    open curUser;
    loop_curUser: loop
        fetch curUser into curName, curPassword;
        if found then
            leave loop_curUser;
        end if;
        if curName = checkName and curPassword = checkPassword then
            set exist = true;
        end if;
    end loop loop_curUser;
    close curUser;
    if exist then
        if op = 1 then
            return true;
        end if;
        if op = 2 and newPassword regexp '^[a-zA-Z0-9]{4,10}$' then
            update user set password = newPassword where name = checkName;
            return true;
        end if;
    end if;
    return false;
end;

select checkPassword('qwerty', '123456', '654321', 1); # 1
select checkPassword('qwerty', '123456', '654321', 2); # 1
select checkPassword('qwerty', '123456', '654321', 1); # 0
```

![截屏2022-04-22 14.19.04](https://cdn.jsdelivr.net/gh/hjc-owo/hjc-owo.github.io@img/202204221419390.png)

### 1-2

```sql
create function borrow(
    userName varchar(255),
    bookISBN varchar(255)
) returns boolean
begin
    declare bookNumber int;
    declare exist boolean;
    select exists(select *
                  from user
                  where name = userName)
    into exist;
    if not exist then
        return false; # 用户名不存在
    end if;

    select number
    from book
    where ISBN = bookISBN
    into bookNumber;
    if bookNumber <= 0 then
        return false; # 书籍不存在或者数量不够
    end if;

    select exists(select *
                  from borrow
                  where username = userName
                    and ISBN = bookISBN)
    into exist;
    if exist then
        return false; # 借了两次
    end if;

    insert into borrow(username, ISBN, borrow_date, due_date)
    values (userName, bookISBN, now(), now() + interval 30 day);
    update book
    set number = number - 1
    where ISBN = bookISBN;

    return true;
end;

select borrow('qwerty', '12345'); # 1
select borrow('qwerty', '12345'); # 0
select borrow('qwertyuiop', '12345'); # 0
select borrow('qwerty', '1234567890'); # 1
select borrow('qwerty', '1234567890'); # 0
```

![截屏2022-04-22 14.17.12](https://cdn.jsdelivr.net/gh/hjc-owo/hjc-owo.github.io@img/202204221417331.png)

### 1-3

```sql
create function returnBook(
    userName varchar(255),
    bookISBN varchar(255)
) returns boolean
begin
    declare exist boolean;
    select exists(select *
                  from borrow
                  where username = userName
                    and ISBN = bookISBN
                    and return_date is null)
    into exist;
    if not exist then
        return false;
    end if;

    update borrow
    set return_date = now()
    where username = userName
      and ISBN = bookISBN
      and return_date is null;

    update book
    set number = number + 1
    where ISBN = bookISBN;

    return true;
end;

select returnBook('qwerty', '12345'); # 1
select returnBook('qwerty', '12345'); # 0
select returnBook('qwertyiop', '12345'); # 0
select returnBook('qwerty', '1234567890'); # 1
select returnBook('qwerty', '1234567890'); # 0
```

![截屏2022-04-22 14.30.36](https://cdn.jsdelivr.net/gh/hjc-owo/hjc-owo.github.io@img/202204221433585.png)

### 1-4

```sql
create procedure searchLog(in userName varchar(255))
begin
    select username, book.name, due_date
    from borrow inner join book on borrow.ISBN = book.ISBN
    where borrow.username = userName;
end;

call searchLog('qwerty');
```

![截屏2022-04-22 14.38.21](https://cdn.jsdelivr.net/gh/hjc-owo/hjc-owo.github.io@img/202204221438384.png)

## TASK 2

### 2-1

```sql
create procedure createLog(num int)
begin
    declare i int default 0;
    while i < num
        do
            insert into log(number, hashNumber)
            values (round(rand() * 5000000), round(rand() * 9));
            set i = i + 1;
        end while;
end;
```

![截屏2022-04-22 14.49.22](https://cdn.jsdelivr.net/gh/hjc-owo/hjc-owo.github.io@img/202204221449950.png)

### 2-2

```sql
create procedure addLog(num int)
begin
    declare i int default 0;
    while i < num
        do
            insert into log(number, hashNumber)
            values (round(rand() * 5000000), round(rand() * 9));
            set i = i + 1;
        end while;
end;

call addLog(4000000);
```

![截屏2022-04-22 14.59.14](https://cdn.jsdelivr.net/gh/hjc-owo/hjc-owo.github.io@img/202204221459023.png)
