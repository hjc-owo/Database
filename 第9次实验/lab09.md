## Q1

```sql
create table student
(
    id          int primary key auto_increment,
    username    varchar(20),
    password    varchar(20),
    age         int,
    phoneNumber varchar(20),
    city        varchar(20)
);

create table role
(
    rid   int primary key auto_increment,
    rname varchar(20)
);

create table permission
(
    pid   int primary key auto_increment,
    pname varchar(20)
);

create table student_role
(
    id  int primary key auto_increment,
    sid int references student (id),
    rid int references role (rid)
);

create table role_permission
(
    id  int primary key auto_increment,
    rid int references role (rid),
    pid int references permission (pid)
);
```

![截屏2022-05-25 17.38.42](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205251921068.png)

![截屏2022-05-25 18.56.29](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205251922454.png)

![截屏2022-05-25 19.18.27](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205251923656.png)

![截屏2022-05-25 19.18.30](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205251922987.png)

![截屏2022-05-25 19.19.20](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205251922968.png)

![截屏2022-05-25 19.20.36](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205251922005.png)

## Q2

### 增

![截屏2022-05-25 21.45.20](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205252152978.png)

![截屏2022-05-25 21.45.37](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205252152002.png)

### 删

![截屏2022-05-25 21.51.48](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205252153175.png)

![截屏2022-05-25 21.51.54](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205252153195.png)

### 改

![截屏2022-05-25 21.48.27](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205252154355.png)

![截屏2022-05-25 21.50.30](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205252154367.png)

### 查

![截屏2022-05-25 21.38.32](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205252154058.png)

![截屏2022-05-25 21.46.33](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205252154076.png)

### 接口

![截屏2022-05-25 21.54.37](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205252154747.png)