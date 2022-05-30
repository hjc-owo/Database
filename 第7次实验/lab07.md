## TASK 1

### Q1

按照表格顺序执行，给出语句 2、语句 4 和语句 5 的输出结果，并分析结果

- 语句 2 和语句 4

  ![截屏2022-05-11 22.39.56](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205112242445.png)

- 语句 5

  ![截屏2022-05-11 22.41.52](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205112242697.png)

当两个事务 A、B 同时进行时，即使 A 事务没有提交，所做的修改也会对 B 事务内的查询产生影响。

事务 A 修改某一数据，并将其写回磁盘（`money = money + 1000`）。事务 B 读取同一数据后，事务 A 由于某种原因被撤消（session1 的 `rollback` 和 `commit` 部分），这时事务 A 已修改过的数据恢复原值，事务 B 读到的数据就与数据库中的数据不一致，是不正确的数据，又称为“脏”数据（语句 4）。再读就是原数据（语句 5）。

### Q2

1. read committed

   - 语句 2 和语句 4

     ![截屏2022-05-11 23.42.00](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205112342575.png)

   - 语句 5

     ![截屏2022-05-11 23.46.15](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205112346286.png)

   只有在事务提交后，才会对另一个事务产生影响。所以此处语句 4 读到的还是 1000

2. repeatable read

   - 语句 2 和语句 4

     ![截屏2022-05-12 00.01.07](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205120002421.png)

   - 语句 5

     ![截屏2022-05-12 00.01.25](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205120002056.png)

   当两个事务同时进行时，其中一个事务修改数据对另一个事务不会造成影响，即使修改的事务已经提交也不会对另一个事务造成影响。

3. serializable

   - 语句 2 和语句 4

     ![截屏2022-05-12 00.10.20](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205120013528.png)

   - 语句 5

     ![截屏2022-05-12 00.12.22](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205120013660.png)

   两个事务同时进行时，一个事务读取的数据也会被锁定，不能被别的事务修改。此处表现为语句 4 不能被执行。

### Q3

按照表格顺序执行，给出语句 2 和语句 4 的输出结果，并分析结果

- 语句 2

  ![截屏2022-05-12 09.27.05](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205120931610.png)

- 语句 4

  ![截屏2022-05-12 09.27.20](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205120928006.png)

只有在事务提交后，才会对另一个事务产生影响。所以此处语句 4 读到的就变成 session2 修改过的 1000

### Q4

1. repeatable read

   - 语句 2

     ![截屏2022-05-12 09.42.01](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205120942784.png)

   - 语句 4

     ![截屏2022-05-12 09.42.13](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205120942945.png)

   当两个事务同时进行时，其中一个事务修改数据对另一个事务不会造成影响，即使修改的事务已经提交也不会对另一个事务造成影响。

   此处表现为 session2 对数据库进行修改并提交，但是 session1 前后查询的结果完全一致，不受 session2 提交修改的影响。

2. serializable

   - 语句 2

     ![截屏2022-05-12 09.47.43](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205120948130.png)

   - 语句 4

     ![截屏2022-05-12 09.47.54](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205120948387.png)

   两个事务同时进行时，一个事务读取的数据也会被锁定，不能被别的事务修改。此处表现为语句 3 不能被执行。

### Q5

- T2 语句 2

  ![截屏2022-05-12 10.08.12](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205121010949.png)

- T4 语句 2

  ![截屏2022-05-12 10.10.09](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205121010861.png)

可以看到 T2 时刻语句 2 不能执行，T4 时刻可以，innoDB 对一般的 select 仅作快照读，但是由于没有提交修改，所以不会对数据库中的数据产生影响。

### Q6

- 语句 2

  ![截屏2022-05-12 10.18.09](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205121026189.png)

- 语句 4

  ![截屏2022-05-12 10.32.09](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205121034243.png)

可以看到，语句 6 的 select 语句出现了语句 5 新加入的行，但是其后的语句 4 的 select 语句得到的结果并没有出现该行。原因是 MySQL 已经在 repeatable read 隔离级别下解决了幻读的问题。

### Q7

![截屏2022-05-12 17.34.35](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205121736480.png)

两个事务同时进行时，一个事务读取的数据也会被锁定，不能被别的事务修改。此处表现为语句 5 不能被执行。

### Q8

1. repeatable read

   ![截屏2022-05-12 20.47.01](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205122048326.png)

2. serializable

   ![截屏2022-05-12 20.50.24](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205122051655.png)

都不能执行。

分析原因应该是，session1 中的语句 2 都加了 S 锁，不能再加 X 锁。但是 innoDB 对 insert/update/delete 语句会加 X 锁，所以 session2 的语句 5 想要 insert 需要加 X 锁。所以语句 5 不能执行。

### Q9

- 语句 2

  ![截屏2022-05-12 21.02.24](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205122104712.png)

- 语句 4

  ![截屏2022-05-12 21.02.54](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205122104100.png)

分析原因应该是，session1 中的语句 1 都加了 X 锁，不能再加锁。但是 innoDB 对 insert/update/delete 语句会加 X 锁，所以 session2 的语句 2 想要 delete 需要加 X 锁。所以语句 2 不能执行。但是 session1 commit 之后，session2 的语句 3 就可以执行。

## TASK 2

### Q10

- 出现死锁

  ![截屏2022-05-12 21.20.41](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205122121798.png)

- 手动杀死

  ![截屏2022-05-12 21.21.03](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205122122633.png)

- session1 先 `update tableA` 给 tableA 加 X 锁。
- session2 再 `update tableB` 给 tableB 加 X 锁。
- session1 再 `update tableB` 给 tableB 加 X 锁。

- session2 试图 `update tableA` 就发生了死锁。

产生死锁的原因是两个或多个事务都已封锁了一些数据对象，然后又都请求对已为其他事务封锁的数据对象加锁，从而出现死等待。

## 微信群老师新增一题

```sql
关于 repeatable read 隔离级别下的幻读现象，我补充一个实验，大家做一下:
T1:
set session transaction isolation level repeatable read;
Begin;
select *
from tableA
where id = 8;
(tableA 里没有id = 8的记录，查到的是空集)
T2:
begin;
insert into tableA (id, value)
values (8, 'ddd');
Commit;
# 也可以不要begin、commit，直接执行insert
T1:
insert into tableA (id, value)
values (8, 'aaa');
这时候大家看看运行结果，并解释现象
同样的实验，把隔离级别改成 serializable，再看
```

1. repeatable read

   ![截屏2022-05-12 21.40.44](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205122142214.png)

2. serializable

   ![截屏2022-05-12 21.43.16](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205122143910.png)

- 首先在 T1 中查到没有 id = 8 的数据。
- 然后在 T2 中插入一行 id = 8 的数据。
  - 对于 repeatable read 这一步可以执行。
  - 对于 serializable 这一步不能执行。
- 在 T1 中插入一行 id = 8 的数据，发现主键冲突，发生了幻读。
