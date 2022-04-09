## `where` & `having`

对于`where`语句和`having`语句的使用。

> 不要错误的认为`having`和`group by`必须配合使用。

使用第 3 次实验的 T2 的表为例进行说明：

### `where`和`having`都可以使用的场景

例：查询`student_id`的值是 2 的学生的选课信息。

```sql
select student_id, course_id, teacher_id
from choose
where student_id = 2;
```

```sql
select student_id, course_id, teacher_id
from choose
having student_id = 2;
```

上面的`having`可以用的前提是，已经筛选出了`student_id`字段，在这种情况下和`where`的效果是等效的。

不过在`having`语句中不使用集函数可能导致效率低下，往往考虑使用`where`代替。

### 只可以用`where`，不可以用`having`的情况

例：查询`student_id`的值是 2 的学生的选课信息。

```sql
select course_id, teacher_id
from choose
where student_id = 2;
```

```sql
select course_id, teacher_id
from choose
having student_id = 2; /* 会报错 */
```

没有`select student_id`就会报错。因为`having`是从前筛选的字段再筛选，而`where`是从数据表中的字段直接进行的筛选的。

### 只可以用`having`，不可以用`where`情况

例：选出所修课程总学分在 10 分以下的学生。

```sql
select student.name, student.id
from student
         inner join course
         inner join choose
                    on student.id = choose.student_id and course.id = choose.course_id and grade >= 60
group by student.id
where sum(credit) < 10; /* 会报错 */
```

```sql
select student.name, student.id
from student
         inner join course
         inner join choose
                    on student.id = choose.student_id and course.id = choose.course_id and grade >= 60
group by student.id
having sum(credit) < 10;
```

`	group by`语句后不能跟`where`。