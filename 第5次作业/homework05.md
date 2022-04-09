## 课本p130

1. ```sql
   select SNAME, CITY
   from S
   ```

2. ```sql
   select PNAME, COLOR, WEIGHT
   from P
   ```

3. ```sql
   select JNO
   from SPJ
   where SNO = 'S1'
   ```

4. ```sql
   select PNAME, QTY
   from P inner join SQJ
   on P.PNO = SPJ.PNO
   where JNO = 'J2'
   ```

5. ```sql
   select distinct PNO
   from SPJ
   where SNO in (select SNO
                from S
                where CITY = '上海')
   ```

6. ```sql
   select JNAME
   from J inner join SPJ inner join S
   on J.JNO = SPJ.JNO and SPJ.SNO = S.SNO
   where S.CITY = '上海'
   ```

7. ```sql
   select JNO
   from J
   where not exists(select *
                   from SPJ
                   where SPJ.JNO = J.JNO and SNO in(select SNO
                                                   from S
                                                   where CITY = '天津'))
   ```

<div STYLE="page-break-after: always;"></div>

## SQL测验题

现有关系模式如下： 

学生（学号，姓名，性别，年龄）；

课程（<u>课程号</u>，课程名，教师姓名）；

选课表（课程号，学号，成绩）

1. 检索年龄大于20岁的男生的学号和姓名。

   ```sql
   select 学号, 姓名
   from 学生
   where 年龄 >= 20 and 性别 = '男'
   ```

2. 检索选修了姓刘的老师所教授的课程的女学生的姓名。

   ```sql
   select distinct 姓名
   from 学生 inner join 课程 inner join 选课表
   on 学生.学号 = 选课表.学号 and 课程.课程号 = 选课表.课程号 
   where 性别 = '女' and 教师姓名 like '刘%'
   ```

3. 检索李想同学不学的课程的课程号和课程名。

   ```sql
   select 课程.课程号, 课程名
   from 课程
   where not exists(
     select *
     from 学生 inner join 课程 inner join 选课表
     on 学生.学号 = 选课表.学号 and 课程.课程号 = 选课表.课程号
     where 姓名 = '李想'
   )
   ```

4. 检索至少选修了两门课程的学生的学号。

   ```sql
   select 学号
   from 选课表
   group by 学号
   having count(distinct 课程号) >= 2
   ```

5. 求刘老师所教授课程的每门课的平均成绩。

   ```sql
   select 课程.课程号, avg(成绩)
   from 课程 inner join 选课表
   on 课程.课程号 = 选课表.课程号
   where 教师姓名 like '刘%'
   group by 选课表.课程号
   ```

6. 假设不存在重修的情况，请统计每门课的选修人数(选课人数超过两人的课程才统计)。要求显示课程号和人数，查询结果按人数降序排列，若人数相同，按课程号升序排列。

   ```sql
   select 课程号, count(学号)
   from 选课表
   group by 课程号
   having count(学号) >= 2
   order by count(学号) desc, 课程号
   ```

7. 求年龄大于所有女生年龄的男生的姓名和年龄。

   ```sql
   select 姓名, 年龄
   from 学生
   where 性别 = '男' and 年龄 > all(select 年龄 
                               from 学生 
                               where 性别 = '女')
   ```

8. 假定不存在重修的情况，求选修了所有课程的学生的学号姓名。(可以不用相关子查询做)

   ```sql
   select 学生.学号, 姓名
   from 学生 inner join 选课表
   on 学生.学号 = 选课表.学号
   group by 选课表.学号
   having count(*) = count(select * 
                           from 课程)
   ```

9. 查询重修次数在2次以上的学生学号，课程号，重修次数

   ```sql
   select 学号, 课程号, count(*) - 1
   from 选课表
   group by 学号, 课程号
   having count(*) >= 3
   ```

10. 查询重修学生人数最多的课程号，课程名，教师姓名

    ```sql
    select 课程号, 课程名, 教师姓名
    from 课程
    where 课程号 = (select 课程号 
                 from (select distinct 学号, 课程号 
                       from 选课表 
                       group by 学号, 课程号 
                       having count(*) >= 2)
                 group by 课程号
                 order by count(*) desc limit 1)
    ```

<div STYLE="page-break-after: always;"></div>

学生（<u>学号</u>，姓名，年龄，性别，班级）

课程（<u>课程号</u>，课程名，先修课程号，学分）注意：此表的主键是(课程号)

选课（<u>学号</u>，<u>课程号</u>，教师号，成绩）

教师（<u>教师号</u>，教师名称）

1. 查找李力的所有不及格的课程名称和成绩，按成绩降序排列

   ```sql
   select 课程名, 成绩
   from 学生 inner join 课程 inner join 选课
   on 学生.学号 = 选课.学号 and 课程.课程号 = 选课.课程号
   where 成绩 < 60 and 姓名 = '李力'
   order by 成绩 desc
   ```

2. 列出每门课的学分，选修的学生人数，及学生成绩的平均分

   ```sql
   select 学分, count(distinct 学号), avg(成绩)
   from 课程 inner join 选课
   on 课程.课程号 = 选课.课程号
   group by 选课.课程号
   ```

3. 选出所修课程总学分在10分以下的学生（注：不及格的课程没有学分）。

   ```sql
   select 姓名, 学生.学号
   from 学生 inner join 课程 inner join 选课
   on 学生.学号 = 选课.学号 and 课程.课程号 = 选课.课程号 and 成绩 >= 60
   group by 选课.学号
   having sum(学分) < 10
   ```

4. 选出选课门数最多的学生学号及选课数量

   ```sql
   select 学生.学号, count(distinct *)
   from 学生 inner join 选课
   on 学生.学号 = 选课.学号
   group by 选课.学号
   order by count(distinct *) desc limit 1
   ```

5. 列出每门课的最高分及获得该分数的学生

   ```sql
   select 成绩, 学号
   from 选课
   group by 课程号
   order by 成绩 desc limit 1
   ```

6. 选出物理课得分比所有男学生的物理课平均分高的学生姓名

   ```sql
   select 姓名
   from (学生 inner join 课程 inner join 选课
   on 学生.学号 = 选课.学号 and 课程.课程号 = 选课.课程号 and 课程.课程名 = '物理') as 物理表
   where 成绩 > avg(select 成绩 
                  from 物理表 
                  where 性别 = '男')
   ```

7. 选出修习过物理课的直接先修课的学生

   ```sql
   select distinct 学号
   from 课程 a inner join 课程 b inner join 选课
   on a.课程号 = 选课.课程号 and a.先修课程号 = b.课程号
   where a.课程名 = '物理'
   ```

8. 选出有两门以上先修课的课程（包括直接先修课、间接先修课）(用课程表)

   ```sql
   select distinct a.课程号
   from 课程 a inner join 课程 b inner join 课程 c
   on a.先修课程号 = b.课程号 and b.先修课程号 = c.课程号
   ```
