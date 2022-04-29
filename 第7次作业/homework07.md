## 课本 p173

1. 数据库的完整性是指数据的正确性和相容性。

2. <null>

3. 完整性约束条件是指数据库中的数据应该满足的语义约束条件。

4. DBMS 的完整性控制应具有的功能

   1. 定义功能：提供定义完整性约束条件的机制。
   2. 检查功能：即检查用户发出的操作请求是否违背了完整性约束条件。
   3. 违约处理机制：如果发现了用户操作请求是数据违背了完整性约束条件，则采取一定的动作来保证数据的完整性。

5. RBDMS 在实现参照完整性的时候需要考虑可能破坏参照完整性的各种可能情况，以及用户违约后的处理策略。

6. ```sql
   create table Dept
   (
       Dno     int not null primary key,
       Dname   varchar(40),
       Manager varchar(20),
       Phone   varchar(20)
   );
   
   create table employees
   (
       Eid    int not null primary key,
       Ename  varchar(20),
       Age    int,
       Job    varchar(20),
       Salary int,
       Dno    int,
       foreign key (Dno) references Dept (Dno),
       check (Age <= 60)
   );
   ```

7. 违约反应

   1. 违反实体完整性规则和用户定义的完整性规则的操作一般是拒绝执行。
   2. 违反参照完整性的操作的违约反应：
      1. 可以拒绝执行；
      2. 也可以接受这个操作，同时执行一些附加的操作，以保证数据库的状态正确。

8. ```sql
   create table male
   (
       id int primary key auto_increment
   );
   
   create table female
   (
       id int primary key auto_increment
   );
   
   create trigger cal_num_male
       before insert
       on male
       for each row
       if (select count(*)
           from male) +
          (select count(*)
           from female) < 50 then
           insert into male values ();
       else
           signal sqlstate '45000' set message_text = 'more than 50!';
       end if;
   
   create trigger cal_num_female
       before insert
       on female
       for each row
       if (select count(*)
           from male) +
          (select count(*)
           from female) < 50 then
           insert into female values ();
       else
           signal sqlstate '45000' set message_text = 'more than 50!';
       end if;
   ```