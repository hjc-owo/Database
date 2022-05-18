## Task1 逻辑备份

1. 创建一个新的数据库db8，并创建一个表user（uid，name，money），添加两个用户，A用户余额为2000，B用户余额为3000

   ```sql
   create database db8;
   use db8;
   
   create table user(
       id    int primary key auto_increment,
       name  varchar(20),
       money int
   );
   
   insert into user(name, money) value ('A', 2000);
   insert into user(name, money) value ('B', 3000);
   
   select * from user;
   ```

   ![截屏2022-05-18 19.52.14](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205181955458.png)

2. 使用**mysqldump工具**备份数据库
   
   ```shell
   mysqldump -u root -p db8 user > ~/desktop/db8.sql
   ```
   
   ![截屏2022-05-18 20.01.04](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205182001757.png)
   
3. 删除该表

   ```sql
   drop table user;
   ```

   ![截屏2022-05-18 20.04.14](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205182006740.png)

4. 恢复数据库

   ```shell
   mysql -u root -p db8 < ~/desktop/db8.sql
   ```

   ![截屏2022-05-18 20.05.54](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205182007424.png)

## Task2 增量备份

1. 请**先确保开启了日志服务并配置了环境变量（见下页），**并创建一个表user2（uid，name，money），添加两个用户，A用户余额为 2000，B用户余额为3000**（建议重新建表，避免日志未记录）**

   ![截屏2022-05-18 20.10.08](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205182010306.png)

2. 删除A用户

3. 删除B用户

   ![截屏2022-05-18 20.12.24](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205182012573.png)

4. **使用日志**通过位置恢复A用户

   ```sql
   show master status;
   ```

   ![截屏2022-05-18 20.25.47](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205182026448.png)

   ```sql
   show binlog events in 'binlog.000028';
   ```

   找到下面的部分：

   ![截屏2022-05-18 20.24.23](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205182024759.png)

   ```sql
   mysqlbinlog --no-defaults --start-position="6885" --stop-position="7173" --database="db8" "/usr/local/mysql/data/binlog.000028" | mysql -u root -p
   ```

   ![截屏2022-05-18 20.32.52](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205182033867.png)

5. **使用日志**通过时间恢复B用户

   ```shell
   mysqlbinlog -v --base64-output=decode-rows "/usr/local/mysql/data/binlog.000028"
   ```

   ![截屏2022-05-18 20.42.01](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205182045920.png)

   ```shell
   mysqlbinlog --no-defaults --start-datetime="2022-05-18 20:40:41" --stop-datetime="2022-05-18 20:41:21" "/usr/local/mysql/data/binlog.000028" | mysql -u root -p
   ```

   ![截屏2022-05-18 20.43.24](https://raw.githubusercontent.com/hjc-owo/hjc-owo.github.io/img/202205182045003.png)