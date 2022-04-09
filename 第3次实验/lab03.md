## TASK 2

### T1-0 建表

```sql
create table employee
(
    id            int         not null primary key,
    name          varchar(20) not null,
    sex           varchar(20) not null,
    birthdate     date        not null,
    grade         varchar(20) not null,
    salary        int         not null,
    department_id int
);

create table employee_attendance
(
    employee_id     int  not null,
    attendance_date date not null primary key,
    foreign key (employee_id) references employee (id)
);

create table department
(
    id         int         not null primary key,
    name       varchar(20) not null,
    manager_id int,
    foreign key (manager_id) references employee (id)
);

alter table employee
    add foreign key (department_id) references department (id);

create table supervisor
(
    id   int         not null primary key,
    name varchar(20) not null
);

create table project
(
    id       int not null primary key,
    duration int not null,
    budget   int not null
);

create table implementation
(
    project_id    int not null,
    department_id int not null,
    foreign key (project_id) references project (id),
    foreign key (department_id) references department (id)
);

create table supervision
(
    project_id    int not null,
    supervisor_id int not null,
    foreign key (project_id) references project (id),
    foreign key (supervisor_id) references supervisor (id)
);
```

<img src="https://tva1.sinaimg.cn/large/e6c9d24ely1h13t8tydnsj21b60u0n0j.jpg" alt="截屏2022-04-06 18.41.27" style="zoom:50%;" />



<div STYLE="page-break-after: always;"></div>

### T1-1

```sql
select distinct name
from supervisor
where not exists(
        select *
        from implementation
        where department_id = 1
          and not exists(
                select *
                from supervision
                where supervisor.id = supervision.supervisor_id
                  and implementation.project_id = supervision.project_id
            )
    )
```

<img src="https://tva1.sinaimg.cn/large/e6c9d24ely1h13t9uib4hj21b60u0q6k.jpg" alt="截屏2022-04-07 12.46.49" style="zoom:50%;" />

<div STYLE="page-break-after: always;"></div>

### T1-2

```sql
select distinct supervisor.name
from supervisor
         inner join project
         inner join supervision
         inner join implementation
         inner join department
                    on supervisor.id = supervision.project_id and project.id = supervision.supervisor_id and
                       implementation.project_id = project.id and department.id = implementation.department_id
where department.id = 1;
```

<img src="https://tva1.sinaimg.cn/large/e6c9d24ely1h13t8qni9ej21b60u078a.jpg" alt="截屏2022-04-06 20.05.40" style="zoom:50%;" />

<div STYLE="page-break-after: always;"></div>

### T1-3

```sql
select employee.id , manager_id
from employee left join department
on employee.department_id = department.id;
```

<img src="https://tva1.sinaimg.cn/large/e6c9d24ely1h13t8tcuf5j21b60u0dj4.jpg" alt="截屏2022-04-06 19.40.44" style="zoom:50%;" />

<div STYLE="page-break-after: always;"></div>

### T1-4

```sql
select budget
from project
         inner join supervision
         inner join supervisor
                    on project.id = supervision.project_id and supervision.supervisor_id = supervisor.id
where supervisor.name like '张%';
```

<img src="https://tva1.sinaimg.cn/large/e6c9d24ely1h13t9tj1qmj21b60u0427.jpg" alt="截屏2022-04-06 20.15.59" style="zoom:50%;" />

<div STYLE="page-break-after: always;"></div>

### T1-5

```sql
select id
from project
where budget > all (select budget from project where duration > 10);
```

<img src="https://tva1.sinaimg.cn/large/e6c9d24ely1h13t8rfc0xj21b60u041y.jpg" alt="截屏2022-04-06 20.16.18" style="zoom:50%;" />

<div STYLE="page-break-after: always;"></div>

### T1-6

```sql
select employee.id, min(attendance_date)
from employee_attendance
         right join employee
                    on employee_attendance.employee_id = employee.id
group by employee.id
```

<img src="https://tva1.sinaimg.cn/large/e6c9d24ely1h13t8x3tpwj21b60u0ju5.jpg" alt="截屏2022-04-07 10.04.17" style="zoom:50%;" />

<div STYLE="page-break-after: always;"></div>

### T1-7

```sql
select department_id, sum(budget)
from implementation
         inner join project
                    on implementation.project_id = project.id
group by department_id
having sum(budget) > 10000
```

<img src="https://tva1.sinaimg.cn/large/e6c9d24ely1h13t8w6ol3j21b60u041i.jpg" alt="截屏2022-04-06 20.43.23" style="zoom:50%;" />

<div STYLE="page-break-after: always;"></div>

### T1-8

```sql
select supervisor.name
from supervisor
         inner join supervision on supervisor.id = supervision.supervisor_id
group by supervision.supervisor_id
having count(project_id) >= 3;
```

<img src="https://tva1.sinaimg.cn/large/e6c9d24ely1h13t9w69baj21b60u0q62.jpg" alt="截屏2022-04-07 10.18.18" style="zoom:50%;" />

<div STYLE="page-break-after: always;"></div>

### T2-0 建表

```sql
create table student
(
    id    int primary key,
    name  varchar(20) not null,
    age   int         not null,
    sex   varchar(20) not null,
    class varchar(20) not null
);

create table course
(
    id     int primary key,
    name   varchar(20) not null,
    credit int         not null
);

create table teacher
(
    id   int primary key,
    name varchar(20) not null
);

create table choose
(
    student_id int not null,
    course_id  int not null,
    teacher_id int not null,
    grade      int not null,
    foreign key (student_id) references student (id),
    foreign key (course_id) references course (id),
    foreign key (teacher_id) references teacher (id)
);
```

<img src="https://tva1.sinaimg.cn/large/e6c9d24ely1h13t8xlcjij21b60u0n0l.jpg" alt="截屏2022-04-06 20.25.38" style="zoom:50%;" />

<div STYLE="page-break-after: always;"></div>

### T2-1

```sql
select student.name
from student
         inner join course
         inner join choose
                    on student.id = choose.student_id and course.id = choose.course_id
where course.name = '物理'
```

<img src="https://tva1.sinaimg.cn/large/e6c9d24ely1h13t9tu4iij21b60u0tc4.jpg" alt="截屏2022-04-06 20.34.28" style="zoom:50%;" />

<div STYLE="page-break-after: always;"></div>

### T2-2

```sql
select name
from student
where name like '诸%' and name not like '诸葛%';
```

<img src="https://tva1.sinaimg.cn/large/e6c9d24ely1h13t8yfqlgj21b60u00vq.jpg" alt="截屏2022-04-06 21.13.57" style="zoom:50%;" />

<div STYLE="page-break-after: always;"></div>

### T2-3

```sql
select teacher.id
from teacher
         inner join choose
                    on teacher.id = choose.teacher_id
group by choose.teacher_id
having min(grade) >= 60;
```

<img src="https://tva1.sinaimg.cn/large/e6c9d24ely1h13t9vgyv1j21b60u077j.jpg" alt="截屏2022-04-06 21.22.12" style="zoom:50%;" />

<div STYLE="page-break-after: always;"></div>

### T2-4

```sql
select student_id, count(distinct course_id)
from choose
group by student_id
```

<img src="https://tva1.sinaimg.cn/large/e6c9d24ely1h13t8urhvkj21b60u0ad8.jpg" alt="截屏2022-04-06 21.29.22" style="zoom:50%;" />

<div STYLE="page-break-after: always;"></div>

### T2-5

```sql
select course.name, grade
from student
         inner join course
         inner join choose
                    on student.id = choose.student_id and course.id = choose.course_id
where student.name = '李力'
  and grade < 60;
```

<img src="https://tva1.sinaimg.cn/large/e6c9d24ely1h13t8v9p8bj21b60u0tc0.jpg" alt="截屏2022-04-06 21.33.02" style="zoom:50%;" />

<div STYLE="page-break-after: always;"></div>

### T2-6

```sql
select credit, count(student_id), avg(grade)
from choose
         inner join course
                    on choose.course_id = course.id
group by course_id;
```

<img src="https://tva1.sinaimg.cn/large/e6c9d24ely1h13t8rywzej21b60u0n0k.jpg" alt="截屏2022-04-06 21.37.53" style="zoom:50%;" />

<div STYLE="page-break-after: always;"></div>

### T2-7

```sql
select student.name, student.id
from student
         left join choose on student.id = choose.student_id
         left join course on choose.course_id = course.id
group by student.id
having sum(if(grade < 60 or grade is null, 0, credit)) < 10;
```

<img src="https://tva1.sinaimg.cn/large/e6c9d24ely1h13t8shorqj21b60u0wht.jpg" alt="截屏2022-04-08 15.51.56" style="zoom:50%;" />