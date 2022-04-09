## Q1

```sql
create table department
(
    id    int primary key not null,
    name  varchar(255)    not null,
    floor int
);

create table employee
(
    id            int primary key not null,
    name          varchar(255)    not null check (name regexp '^[A-Za-z ]+$'),
    salary        int check (salary >= 2000),
    absent_day    int default 0,
    birthday      date,
    marriage      boolean,
    department_id int,
    foreign key (department_id) references department (id)
);
```

<div STYLE="page-break-after: always;"></div>

## Q2

1. ```sql
   insert into department (id, name, floor)
   values (21, 'software', 10),
          (6, 'computer_science', 11),
          (2, 'electronic', 12);
   
   insert into employee (id, name, salary, absent_day, birthday, marriage, department_id)
   values (101, 'songyou', 3000, 23, '1980-01-01', true, 21),
          (102, 'huangjian', 2500, 14, '1981-01-01', true, 21),
          (103, 'liweiguo', 5000, 16, '1950-01-01', true, 21),
          (104, 'haoaimin', 4500, 21, '1973-01-01', true, 6),
          (105, 'hujunlin', 2200, 20, '1996-01-01', true, 21),
          (106, 'leixiaomiao', 2000, 25, '1996-01-01', true, 2),
          (107, 'yuancangzhou', 2300, 23, '1973-01-01', true, 21),
          (108, 'sunhailong', 3000, 12, '1980-01-01', true, 6),
          (109, 'miaomiaomiao', 6000, 6, '2000-01-01', false, 21),
          (110, 'hujuncheng', 10000, 0, '2002-07-20', false, 21);
   ```

   <img src="https://tva1.sinaimg.cn/large/e6c9d24ely1h13tqc15c7j21b60u0tap.jpg" alt="截屏2022-03-30 20.04.41" style="zoom: 50%;" />

   <img src="https://tva1.sinaimg.cn/large/e6c9d24ely1h13tq53k1pj21b60u0779.jpg" alt="截屏2022-03-30 20.04.46" style="zoom: 50%;" />

2. ```sql
   insert into employee (id, name, salary, absent_day, birthday, marriage, department_id)
   values (121, 'error', 1500, 40, '1111-01-01', true, 34);
   ```

   <img src="https://tva1.sinaimg.cn/large/e6c9d24ely1h13tq97nmcj21b60u0q63.jpg" alt="截屏2022-03-30 20.01.15" style="zoom: 50%;" />

   原因：由于`salary`中设置了`check (salary >= 2000)`，所以当插入的数据不满足要求的时候，就不能插入这行数据。

3. ```sql
   delete from department where id = 6;
   ```

   <img src="https://tva1.sinaimg.cn/large/e6c9d24ely1h13tq9u56ij21b60u0q6b.jpg" alt="截屏2022-03-30 20.09.11" style="zoom: 50%;" />

   原因：设置了外键约束，有外键约束的数据不能删除。

<div STYLE="page-break-after: always;"></div>

## Q3

```sql
select salary, absent_day
from employee;
```

<img src="https://tva1.sinaimg.cn/large/e6c9d24ely1h13tqde7a0j21b60u0775.jpg" alt="截屏2022-03-30 20.15.10" style="zoom: 50%;" />

<div STYLE="page-break-after: always;"></div>

## Q4

```sql
select count(*)
from employee;
```

<img src="https://tva1.sinaimg.cn/large/e6c9d24ely1h13tq5wr6kj21b60u0wgz.jpg" alt="截屏2022-03-30 20.17.16" style="zoom: 50%;" />

<div STYLE="page-break-after: always;"></div>

## Q5

```sql
select avg(salary)
from employee;
```

<img src="https://tva1.sinaimg.cn/large/e6c9d24ely1h13tq8c49hj21b60u0wh2.jpg" alt="截屏2022-03-30 20.18.08" style="zoom: 50%;" />

<div STYLE="page-break-after: always;"></div>

## Q6

```sql
select max(salary), min(salary)
from employee
where department_id = 21;
```

<img src="https://tva1.sinaimg.cn/large/e6c9d24ely1h13tq6tzf0j21b60u0q5n.jpg" alt="截屏2022-03-30 20.21.42" style="zoom: 50%;" />

<div STYLE="page-break-after: always;"></div>

## Q7

```sql
select name
from employee
where absent_day > 3;
```

<img src="https://tva1.sinaimg.cn/large/e6c9d24ely1h13tqatdvaj21b60u0acw.jpg" alt="截屏2022-03-30 20.22.39" style="zoom: 50%;" />

<div STYLE="page-break-after: always;"></div>

## Q8

```sql
select name, floor
from department
where id = (
    select department_id
    from employee
    group by department_id
    having avg(salary) >= all (select avg(salary) from employee group by department_id)
)
```



<img src="https://tva1.sinaimg.cn/large/e6c9d24ely1h13tq6kekgj21b60u0mzz.jpg" alt="截屏2022-03-30 21.11.36" style="zoom: 50%;" />

<div STYLE="page-break-after: always;"></div>

或者：

```sql
select department.name, floor
from department inner join employee
on department.id = department_id
group by department.id
order by avg(salary) desc limit 1;
```

<img src="https://tva1.sinaimg.cn/large/e6c9d24ely1h13tqbk0dcj21b60u0whc.jpg" alt="截屏2022-03-31 08.40.55" style="zoom: 50%;" />

<div STYLE="page-break-after: always;"></div>

## Q9

```sql
select ucase(name)
from employee;
```

<img src="https://tva1.sinaimg.cn/large/e6c9d24ely1h13tq7w748j21b60u0ju9.jpg" alt="截屏2022-03-30 20.37.43" style="zoom: 50%;" />

<div STYLE="page-break-after: always;"></div>

## Q10

```sql
select date_format(birthday, '%Y/%m/%d'), date_format(birthday, '%Y%m%d')
from employee;
```

<img src="https://tva1.sinaimg.cn/large/e6c9d24ely1h13tqch4bvj21b60u0tc2.jpg" alt="截屏2022-03-30 20.42.00" style="zoom: 50%;" />

<div STYLE="page-break-after: always;"></div>

## Q11

```sql
select mid(name, 1, 4), mid(name, 5)
from employee
where id = 101;
```

<img src="https://tva1.sinaimg.cn/large/e6c9d24ely1h13tqcxo0fj21b60u0dij.jpg" alt="截屏2022-03-30 20.45.15" style="zoom: 50%;" />

<div STYLE="page-break-after: always;"></div>

## Q12

```sql
select datediff(a.birthday, b.birthday)
from employee a,
     employee b
where a.id = 101 and b.id = 102;
```

<img src="https://tva1.sinaimg.cn/large/e6c9d24ely1h13tqdtm42j21b60u0773.jpg" alt="截屏2022-03-30 20.50.45" style="zoom: 50%;" />

<div STYLE="page-break-after: always;"></div>

## Q13

```sql
select *
from employee
where birthday > '2000-01-01';
```

<img src="https://tva1.sinaimg.cn/large/e6c9d24ely1h13tq7bde1j21b60u041e.jpg" alt="截屏2022-03-30 20.53.05" style="zoom: 50%;" />

<div STYLE="page-break-after: always;"></div>

或者：

```sql
select *
from employee
where to_days(birthday) > to_days('2000-01-01');
```

<img src="https://tva1.sinaimg.cn/large/e6c9d24ely1h13tqecbgqj21b60u0acy.jpg" alt="截屏2022-03-30 20.56.25" style="zoom: 50%;" />