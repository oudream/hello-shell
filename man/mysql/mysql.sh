#!/usr/bin/env bash


explain SELECT * FROM `admin_country`


# doc en
open https://dev.mysql.com/doc/refman/8.0/en/mysql-commands.html
# doc cn
open https://www.docs4dev.com/docs/zh/mysql/5.7/reference/show-engines.html
open https://dev.mysql.com/doc/refman/8.0/en/show-engines.html

# sudo apt-get install mysql-server
#    The following additional packages will be installed:
#      mysql-client-5.7 mysql-client-core-5.7 mysql-common mysql-server-5.7 mysql-server-core-5.7
#    Suggested packages:
#      mailx tinyca
#    The following NEW packages will be installed:
#      mysql-client-5.7 mysql-client-core-5.7 mysql-common mysql-server mysql-server-5.7 mysql-server-core-5.7


# 1.导出整个数据库
# mysqldump -u 用户名 -p 数据库名 > 导出的文件名
mysqldump -u root -p db1 > db1.sql

# 2.导出一个表
# mysqldump -u 用户名 -p 数据库名 表名> 导出的文件名
mysqldump -u dbuser -p db1 table1> db1_table1.sql

# 3.导出一个数据库结构
mysqldump -u dbuser -p -d --add-drop-table db1 > /opt/tmp/db1.sql
# -d 没有数据
# --add-drop-table 在每个create语句之前增加一个drop table

# 4.导入数据库
# 常用source 命令
# 进入mysql数据库控制台，如
mysql -u root -p
mysql>use db1
# 然后使用source命令，后面参数为脚本文件(如这里用到的.sql)
mysql>source /opt/tmp/db1.sql


# https://www.jianshu.com/p/a152757844c3
# 性能瓶颈定位Show命令
# 我们可以通过show命令查看MySQL状态及变量，找到系统的瓶颈：
# Mysql>
    help
    create database if not exists db1 default charset utf8 collate utf8_general_ci;
    use mysqldata;
    show tables;
    show databases;
    create table mytable (name varchar(20), sex char(1));
    describe mytable;
    insert into mytable values (”hyq”,”m”);
    load data local infile “d:/mysql.txt” into table mytable; # 用文本方式将数据装入数据库表中（例如d:/mysql.txt）
    use database; mysql>source d:/mysql.sql;
    drop table mytable;
    delete from mytable;
    update mytable set sex=”f” where name=’hyq’;
    show status                  ;  # ——显示状态信息（扩展show status like ‘XXX’）
    show variables               ;  # ——显示系统变量（扩展show variables like ‘XXX’）
    show innodb status           ;  # ——显示InnoDB存储引擎的状态
    show processlist             ;  # ——查看当前SQL执行，包括执行状态、是否锁表等
    show variables like "slow%"  ;  # 检测MySQL是否开启慢日志功能
    set global slow_query_log=ON ;  # 开启慢日志
# Shell>
    mysqladmin variables -u username -p password        # ——显示系统变量
    mysqladmin extended-status -u username -p password  # ——显示状态信息

UPDATE user SET authentication_string='Aa.123456' WHERE user='root@localhost';
update user set authentication_string=password("Aa.123456") where user="root";

# explain分析查询
# 使用 EXPLAIN 关键字可以模拟优化器执行SQL查询语句，从而知道MySQL是如何处理你的SQL语句的。
# 这可以帮你分析你的查询语句或是表结构的性能瓶颈。通过explain命令可以得到:
#    表的读取顺序
#    数据读取操作的操作类型
#    哪些索引可以使用
#    哪些索引被实际使用
#    表之间的引用
#    每张表有多少行被优化器查询
# Mysql>
    explain select * from Table1


### docker
# Backup
docker exec CONTAINER /usr/bin/mysqldump -u root --password=root DATABASE > backup.sql
# Restore
cat backup.sql | docker exec -i CONTAINER /usr/bin/mysql -u root --password=root DATABASE


# install
# https://help.ubuntu.com/lts/serverguide/mysql.html
sudo apt update
sudo apt install mysql-server
sudo netstat -tap | grep mysql

# You can edit the /etc/mysql/my.cnf file to configure the basic settings -- log file,
# port number, etc. For example, to configure MySQL to listen for connections from network hosts,
# change the bind-address directive to the server's IP address:
vim /etc/mysql/my.cnf
[mysqld]
bind-address            = 0.0.0.0

# Now backup the original my.cnf file and replace with the new one:
sudo cp /etc/mysql/my.cnf /etc/mysql/my.cnf.backup
sudo cp /path/to/new/my.cnf /etc/mysql/my.cnf
# Then delete and re-initialise the database space and make sure ownership is correct
# before restarting MySQL:
sudo rm -rf /var/lib/mysql/*
sudo mysql_install_db
sudo chown -R mysql: /var/lib/mysql
sudo systemctl start mysql.service


# https://dev.mysql.com/doc/refman/8.0/en/set-variable.html
# https://mysqlserverteam.com/mysql-8-0-persisting-configuration-variables/
# https://bugs.mysql.com/bug.php?id=93959
# 远程访问 remote connect
# mysql>
    select @@validate_password_policy;
    select @@validate_password_length;
    show variables like 'validate_password%';
    set global validate_password_policy=LOW;
    set global validate_password_mixed_case_count=0;
    set global validate_password_number_count=3;
    set global validate_password_special_char_count=0;
    set global validate_password_length=3;
    set password for 'root'@'%' = password('Aa.123456');
    grant all on *.* to root@'%' identified by 'Aa.123456';
    flush privileges;
# 或者
vim /etc/mysql/my.cnf
[mysqld]
validate_password_policy=LOW
validate_password_mixed_case_count=0;
validate_password_number_count=3;
validate_password_special_char_count=0;
validate_password_length=3;
# 或者 https://stackoverflow.com/questions/36301100/how-do-i-turn-off-the-mysql-password-validation
mysql -h localhost -u root -p
# mysql>
    uninstall plugin validate_password;
sudo /etc/init.d/mysql restart


# backup and restore
mysqldump --all-databases --routines -u root -p > ~/fulldump.sql
sudo apt install pv
pv ~/fulldump.sql | mysql

# restart service
sudo systemctl stop mysql.service
sudo systemctl restart mysql.service

# reset password
sudo mysql_secure_installation

mysqlslap --concurrency=100 --iterations=1 --create-schema='sunboDataBase' --query='select * from Table1;' --number-of-queries=10 --debug-info -p123456 -uroot


ssh root@35.232.133.92

