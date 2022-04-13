## TASK 1 导入数据 / 复习DQL

### Q1

查询与CID=1的顾客同一个城市的所有顾客ID

```sql
select CID
from Customer
where city = (select city from Customer where CID = 1);
```

![截屏2022-04-13 15.49.28](https://s2.loli.net/2022/04/13/S4n7lWRJNQrVDkt.png)

<div STYLE="page-break-after: always;"></div>

### Q2

查询购买过所有省份（Food表中出现过的City）的食物的顾客ID

即，不存在这样的顾客，Food表中存在的City，顾客没买过。

```sql
select CID
from Customer
where not exists(
        select *
        from Food
        where not exists(
                select *
                from Orders
                where Orders.CID = Customer.CID
                  and Orders.FID = Food.FID
            )
    );
```

![截屏2022-04-13 16.03.12](https://s2.loli.net/2022/04/13/cDdhzxOvAftpFoB.png)

<div STYLE="page-break-after: always;"></div>

### Q3

查询至少购买过ID为4的顾客买过的全部食物的顾客ID

即，不存在这样的食物，ID为4的顾客买过，而顾客没买过。

```sql
select distinct CID
from Orders O1
where not exists(
        select *
        from Orders O2
        where O2.CID = 4
          and not exists(
                select *
                from Orders O3
                where O3.FID = O2.FID
                  and O3.CID = O1.CID
            )
    )
```

![截屏2022-04-13 16.12.08](https://s2.loli.net/2022/04/13/uCWFKMLs9QtpDi4.png)

<div STYLE="page-break-after: always;"></div>

## TASK 2 DDL DML

### Q1

创建一个新表Sales，字段为：Food ID（主键） 数字型，食物名（非空）字符型 长度20，总销量 数字型。

查询每种食物的总销量，将结果插入表中。（两条SQL语句，一条为create语句，一条为insert语句）。

```sql
create table Sales
(
    FID      int primary key,
    FName    varchar(20),
    Quantity int
);

insert into Sales(FID, FName, Quantity)
select Food.FID, Name, allQuantity
from (select Food.FID, sum(Orders.Quantity) as allQuantity
      from Food
               inner join Orders
                          on Food.FID = Orders.FID
      group by Food.FID) as calc
         inner join Food on calc.FID = Food.FID;
```

![截屏2022-04-13 16.23.51](https://s2.loli.net/2022/04/13/yobYVQv3js24CaK.png)

<div STYLE="page-break-after: always;"></div>

### Q2

向Order表添加一条交易记录，内容自定义，并更新对应食物的总销量字段（两条SQL语句）

```sql
insert into Orders(OID, CID, FID, Quantity)
values (23, 1, 1, 1);

update Sales
set Quantity =
            (select sum(Quantity) from Orders where Sales.FID = Orders.FID)
```

![截屏2022-04-13 16.26.47](https://s2.loli.net/2022/04/13/k6IVmJDclxTGuOv.png)

![截屏2022-04-13 16.32.16](https://s2.loli.net/2022/04/13/1eBd86hVLHKCSab.png)

<div STYLE="page-break-after: always;"></div>

### Q3

为新表添加一个评分字段（数字型），要求分数范围限定为0-10，并设置默认值6

```sql
alter table Sales
    add Score int default 6
        check (Score >= 0 and Score <= 10);
```

![截屏2022-04-13 16.37.22](https://s2.loli.net/2022/04/13/RjateDuzlxGTY2s.png)

<div STYLE="page-break-after: always;"></div>

## TASK 3 视图

### Q1

建立购买过重庆或四川食物的顾客视图Shu-view（包含Customer中CID，City）

```sql
create view Shu_view as
select distinct Customer.CID, Customer.City
from Customer
         inner join Food
         inner join Orders
                    on Customer.CID = Orders.CID and Food.FID = Orders.FID
where Food.City in ('重庆', '四川');
```

![截屏2022-04-13 16.44.16](https://s2.loli.net/2022/04/13/Z3GROwynvbgHefa.png)

<div STYLE="page-break-after: always;"></div>

### Q2

查询购买过重庆或四川食物的顾客中订单总消费最高的顾客CID（使用视图Shu-view，思考使用视图的好处）

```sql
select shu_view.CID
from shu_view
         inner join Orders
         inner join Food
                    on shu_view.CID = Orders.CID and Orders.FID = Food.FID
group by shu_view.CID
order by sum(Quantity * Price) desc
limit 1;
```

![截屏2022-04-13 16.50.17](https://s2.loli.net/2022/04/13/LpGsEJMO4xKC6vb.png)

好处：视图能够简化用户的操作。

<div STYLE="page-break-after: always;"></div>

### Q3

向视图Shu-view加入表项（16，湖南），能成功吗，为什么？

![截屏2022-04-13 16.53.40](https://s2.loli.net/2022/04/13/hP8dzLaKOjM4wrJ.png)

 不能成功，因为使用了distinct语句，是不可更新视图。

<div STYLE="page-break-after: always;"></div>

### Q4

建立男性顾客的视图Male-view（包含Customer中CID，City）,并要求对该视图进行的更新操作只涉及男性顾客。（**WITH CHECK OPTION**）

```sql
create view Male_view as
select CID, City
from Customer
where Gender = '男'
with check option;
```

![截屏2022-04-13 17.01.00](https://s2.loli.net/2022/04/13/HRNjVf8Qz5G6DUu.png)

<div STYLE="page-break-after: always;"></div>

### Q5

向视图Male-view加入表项（17，湖南），能成功吗，为什么？

![截屏2022-04-13 17.03.55](https://s2.loli.net/2022/04/13/JlvjNCqbcGgY7hM.png)

不能成功，因为我们加入了with check option语句，加入的视图不涉及Gender，check不通过，不能加入。