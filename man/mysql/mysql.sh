#!/usr/bin/env bash


explain SELECT * FROM `admin_country`

mysql -P 3306 -h 127.0.0.1 -u root -p'Aa.123456'

docker run arey/mysql-client -h "172.17.0.1" -P 3306 -u"root" -p'password' -e "SET PASSWORD FOR root@'%' = PASSWORD('new-password');"

docker run -d --restart=always --name mysql1 -v /mnt/sdb1/mysql1/data:/var/lib/mysql -p 3306:3306 -p 33060:33060 -e MYSQL_ROOT_PASSWORD="Aa.123456" -e MYSQL_ROOT_HOST="%" mysql:5.7.28 \
mysqld \
  --log-bin=mysql-bin \
  --binlog-format=ROW \
  --lower_case_table_names=1 \
  --server-id=1

docker run -d --restart=always --name mysql2 -v /userdata/mysql2/data:/var/lib/mysql -p 3308:3306 -p 33068:33060 -e MYSQL_ROOT_PASSWORD="Aa.123456" -e MYSQL_ROOT_HOST="%" mysql:5.7.28 \
mysqld \
  --log-bin=mysql-bin \
  --binlog-format=ROW \
  --lower_case_table_names=1 \
  --server-id=1

#
apt-get install mysql-client

docker run --name mysql1 -v /usr/local/mysql/data:/var/lib/mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD="Aa.123456" mysql:5.7

docker run -d --name mysql-client -e MYSQL_ROOT_PASSWORD="Aa.123456" -e MYSQL_ROOT_HOST="%" mysql:5.7.28
docker exec -it mysql-client bash
mysql -h 192.168.5.110 -u root -p'Aa.123456'

docker run -d -v /usr/local/mysql/data:/var/lib/mysql --name mysql-client -p 3306:3306 -p 33060:33060 -e MYSQL_ROOT_PASSWORD="Aa.123456" -e MYSQL_ROOT_HOST="%" mysql:5.7.28
docker run -d -v /userdata/mysql:/var/lib/mysql --name mysql-client -p 3306:3306 -p 33060:33060 -e MYSQL_ROOT_PASSWORD="Aa.123456" -e MYSQL_ROOT_HOST="%" arm64v8/mariadb:10.5.12

# 性能調試
SHOW FULL PROCESSLIST;

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

### centos
# https://downloads.mysql.com/archives/community/
# https://dev.mysql.com/doc/mysql-repo-excerpt/5.7/en/linux-installation-yum-repo.html
#wget https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
# 先卸载Linux上已安装的mariadb相关的软件包，避免跟待安装的MySQL的rpm包冲突
yum remove mariadb-libs -y
# 安装基础依赖
yum install -y numactl libaio
#
wget https://downloads.mysql.com/archives/get/p/23/file/mysql-community-common-5.7.28-1.el7.x86_64.rpm
wget https://downloads.mysql.com/archives/get/p/23/file/mysql-community-libs-5.7.28-1.el7.x86_64.rpm
wget https://downloads.mysql.com/archives/get/p/23/file/mysql-community-libs-compat-5.7.28-1.el7.x86_64.rpm
wget https://downloads.mysql.com/archives/get/p/23/file/mysql-community-client-5.7.28-1.el7.x86_64.rpm
wget https://downloads.mysql.com/archives/get/p/23/file/mysql-community-server-5.7.28-1.el7.x86_64.rpm
rpm -ivh mysql-community-common-5.7.28-1.el7.x86_64.rpm
rpm -ivh mysql-community-libs-5.7.28-1.el7.x86_64.rpm
rpm -ivh mysql-community-libs-compat-5.7.28-1.el7.x86_64.rpm
rpm -ivh mysql-community-client-5.7.28-1.el7.x86_64.rpm
rpm -ivh mysql-community-server-5.7.28-1.el7.x86_64.rpm
mysql-community-libs-compat-5.7.28-1.el7mysql --version
.x86_64.rpm

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

# 创建用户
# Mysql>
  CREATE USER 'UserTwdata'@'%' IDENTIFIED BY 'xxx';
  GRANT ALL PRIVILEGES ON Twdata.* to 'UserTwdata'@'%';
  GRANT SElECT ON *.* TO 'username'@'%' IDENTIFIED BY "password";
  SET PASSWORD FOR 'root'@'%' = PASSWORD('xxx');

# https://www.jianshu.com/p/a152757844c3
# 性能瓶颈定位Show命令
# 我们可以通过show命令查看MySQL状态及变量，找到系统的瓶颈：
# Mysql>
# SHOW CREATE TABLE tbl_name 以SQL语句的形式展示表结构
    help
    help show                    ;  # ——显示show的幫助信息
        SHOW {BINARY | MASTER} LOGS
        SHOW BINLOG EVENTS [IN 'log_name'] [FROM pos] [LIMIT [offset,] row_count]
        SHOW CHARACTER SET [like_or_where]
        SHOW COLLATION [like_or_where]
        SHOW [FULL] COLUMNS FROM tbl_name [FROM db_name] [like_or_where]
        SHOW CREATE DATABASE db_name
        SHOW CREATE EVENT event_name
        SHOW CREATE FUNCTION func_name
        SHOW CREATE PROCEDURE proc_name
        SHOW CREATE TABLE tbl_name
        SHOW CREATE TRIGGER trigger_name
        SHOW CREATE VIEW view_name
        SHOW DATABASES [like_or_where]
        SHOW ENGINE engine_name[innodb] {STATUS | MUTEX}
        SHOW [STORAGE] ENGINES
        SHOW ERRORS [LIMIT [offset,] row_count]
        SHOW EVENTS
        SHOW FUNCTION CODE func_name
        SHOW FUNCTION STATUS [like_or_where]
        SHOW GRANTS FOR user
        SHOW INDEX FROM tbl_name [FROM db_name]
        SHOW MASTER STATUS
        SHOW OPEN TABLES [FROM db_name] [like_or_where]
        SHOW PLUGINS
        SHOW PROCEDURE CODE proc_name
        SHOW PROCEDURE STATUS [like_or_where]
        SHOW PRIVILEGES
        SHOW [FULL] PROCESSLIST
        SHOW PROFILE [types] [FOR QUERY n] [OFFSET n] [LIMIT n]
        SHOW PROFILES
        SHOW RELAYLOG EVENTS [IN 'log_name'] [FROM pos] [LIMIT [offset,] row_count]
        SHOW SLAVE HOSTS
        SHOW SLAVE STATUS [NONBLOCKING]
        SHOW [GLOBAL | SESSION] STATUS [like_or_where]
        SHOW TABLE STATUS [FROM db_name] [like_or_where]
        SHOW [FULL] TABLES [FROM db_name] [like_or_where]
        SHOW TRIGGERS [FROM db_name] [like_or_where]
        SHOW [GLOBAL | SESSION] VARIABLES [like_or_where]
        SHOW WARNINGS [LIMIT [offset,] row_count]
    create database if not exists twdb default charset utf8 collate utf8_general_ci;
    create database if not exists db1 default charset utf8 collate utf8_general_ci;
    use mysqldata;
    show tables;
    show databases;
    create table mytable (name varchar(20), sex char(1));
    describe mytable;               # 显示数据表的结构
    insert into mytable values (”hyq”,”m”);
    load data local infile “d:/mysql.txt” into table mytable; # 用文本方式将数据装入数据库表中（例如d:/mysql.txt）
    use database; mysql>source d:/mysql.sql;
    drop table mytable;
    delete from mytable;
    update mytable set sex=”f” where name=’hyq’;
    show status                  ;  # ——显示状态信息（扩展show status like ‘XXX’）
    show warnings;               ;  # ——显示警告
    show errors;                 ;  # ——显示錯誤
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
    set global max_allowed_packet=1024*1024*128;
    select @@validate_password_policy;
    select @@validate_password_length;
    show variables like 'validate_password%';
    set global validate_password_policy=LOW;
    set global validate_password_mixed_case_count=0;
    set global validate_password_number_count=3;
    set global validate_password_special_char_count=0;
    set global validate_password_length=3;
    SET PASSWORD FOR 'root'@'localhost' = PASSWORD('Aa.123456');
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
# error
# 还有可能是： plugin: auth_socket
# 该插件不关心，也不需要密码
# 运行以下命令：
# mysql>
    ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Aa.123456';
    # ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'testAa.123456;
    SELECT User, Host, HEX(authentication_string) FROM mysql.user;


# backup and restore
mysqldump --all-databases --routines -u root -p > ~/fulldump.sql
sudo apt install pv
pv ~/fulldump.sql | mysql

## restart service
sudo systemctl stop mysql.service
sudo systemctl restart mysql.service
##
systemctl start mariadb
systemctl stop mariadb
systemctl restart mariadb
systemctl enable mariadb
systemctl disable mariadb
# systemd
cat /etc/systemd/system/multi-user.target.wants/mariadb.service
# 增加对mariadb的配置，开启binlog：
# 如果启用了这一行，则会使得binlog更大，但是最安全。
vim /etc/my.cnf.d/server.cnf
# 在[mysqld]一节中增加下列配置：
#  log-bin=mysql-bin
#  max-binlog-size=1G
#  expire_logs_days=180
#  binlog_format=row
#  server-id=1001
#  max_allowed_packet=128M
# 保存后，重启mariadb服务：
systemctl restart mariadb
# 登录mysql后执行：
# 查询 binlog
SHOW VARIABLES LIKE 'log_bin';

# reset password
sudo mysql_secure_installation

mysqlslap --concurrency=100 --iterations=1 --create-schema='sunboDataBase' --query='select * from Table1;' --number-of-queries=10 --debug-info -p123456 -uroot


### stop
/usr/local/mysql/bin/mysqladmin -u root -p shutdown
# Or:
sudo mysqld stop
# Or:
sudo /usr/local/mysql/bin/mysqld stop
# Or:
sudo mysql.server stop
# If you install the Launchctl in OSX you can try:
# MacPorts
sudo launchctl unload -w /Library/LaunchDaemons/org.macports.mysql.plist
sudo launchctl load -w /Library/LaunchDaemons/org.macports.mysql.plist
# Note: this is persistent after reboot.
# Homebrew
launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
# Binary installer
sudo /Library/StartupItems/MySQLCOM/MySQLCOM stop
sudo /Library/StartupItems/MySQLCOM/MySQLCOM start
sudo /Library/StartupItems/MySQLCOM/MySQLCOM restart



### 开启日志
set GLOBAL general_log='ON';
# 查询是否开启
SHOW VARIABLES LIKE 'general%';
#  general_log ON
#  general_log_file /var/lib/mysql/507bbf1e71f4.log

### log profile
# https://juejin.im/post/5b7c0aabf265da438415b9eb
# https://github.com/brunoric/docker-percona-toolkit
# https://www.percona.com/downloads/percona-toolkit/3.2.0/binary/debian/bionic/
# 错误日志
show variables like 'log_error';
# or
[mysqld_safe]
log-error=/var/log/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid

# 慢查询日志
mysql> show variables like "%slow%";
mysql> set global slow_query_log='ON';
# or
[mysqld]
slow_query_log=1
# 设置阈值 （ 0.05秒）
mysql> show variables like 'long_query_time';
mysql> set global long_query_time=0.05;
# 查询日志
mysql> show variables like "general_log%";
mysql> set global general_log='ON';
# 参数log_queries_not_using_indexes
# 另一个和慢查询日志有关的参数是 log_queries_not_using_indexes,
# 如果运行的SQL语句没有使用索引，则MySQL数据库同样会将这条SQL语句记录到慢查询日志文件。首先确认打开了log_queries_not_using_indexes;
mysql> show variables like 'log_queries_not_using_indexes';
# 例子，没有用到索引进行查询：
mysql> explain select * from vote_record_memory where vote_id = 323;

### binlog 开启
# 通过配置参数 log-bin[=name] 可以启动二进制日志。如果不指定name,则默认二进制日志文件名为主机名，后缀名为二进制日志的序列号
[mysqld]
log-bin=mysql-bin
binlog-format=ROW
server-id=1
# mysqld-bin.000001即为二进制日志文件，而mysqld-bin.index为二进制的索引文件，为了管理所有的binlog文件，MySQL额外创建了一个index文件，它按顺序记录了MySQL使用的所有binlog文件。如果你想自定义index文件的名称，可以设置 log_bin_index=file参数。
# 查看二进制日志文件
# 对于二进制日志文件来说，不像错误日志文件，慢查询日志文件那样用cat，head, tail等命令可以查看，它需要通过 MySQL 提供的工具 mysqlbinlog
mysqlbinlog mysqld-bin.000001



### 慢查询查看和设置命令
# 1、数据库CPU负载高。一般是查询语句中有很多计算逻辑，导致数据库cpu负载。
# 2、IO负载高导致服务器卡住。这个一般和全表查询没索引有关系。
# 3、查询语句正常，索引正常但是还是慢。如果表面上索引正常，但是查询慢，需要看看是否索引没有生效。
# 2.1、查询mysql的操作信息
# show status -- 显示全部mysql操作信息
show status like "com_insert%"; -- 获得mysql的插入次数;
show status like "com_delete%"; -- 获得mysql的删除次数;
show status like "com_select%"; -- 获得mysql的查询次数;
show status like "uptime"; -- 获得mysql服务器运行时间
show status like 'connections'; -- 获得mysql连接次数
show [session|global] status like .... 如果你不写 [session|global] 默认是session 会话，只取出当前窗口的执行，如果你想看所有(从mysql 启动到现在，则应该 global)
# 通过查询mysql的读写比例,可以做相应的配置优化;
show variables like "%slow%";-- 是否开启慢查询;
show variables like "%binlog%";-- 是否开启慢查询;
show status like "%slow%"; -- 查询慢查询SQL状况;
show variables like "long_query_time"; -- 慢查询时间



### 忘记密码
# 在/etc/my.cnf [mysqld] 配置部分添加"skip-grant-tables"
# 重启mysql服务
service mysqld restart
# 登入mysql
mysql -uroot -p mysql
  update mysql.user set password=PASSWORD('root')where user='root';
  flush privileges;
# 删除/etc/my.cnf [mysqld] 配置部分的"skip-grant-tables"
# 重启mysql服务


### 需要在防火墙配置将3306端口开放。
# （--permanent永久生效，没有此参数重启后失效）
firewall-cmd --zone=public --add-port=3306/tcp --permanent
# 重新载入
firewall-cmd --reload
# 查看
firewall-cmd --zone=public --query-port=3306/tcp

yum-config-manager --disable   mysql80-community
yum-config-manager --enable   mysql57-community


### emoji
# mysql/Java服务端对emoji的支持 https://segmentfault.com/a/1190000000616820


### 版本
select VERSION()

# 5.7 才有的全文檢索插件
ALTER TABLE `hr_post`
ADD FULLTEXT INDEX `post_keyword_index`(`post_keyword`) WITH PARSER `ngram`;
# 5.7 才支持原生 json
CREATE TABLE `t1` (
  `f1` int(11) DEFAULT NULL,
  `f2` json DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


### binlog
#是否启用了日志
show variables like 'log_bin';
#怎样知道当前的日志
show master status;
#查看mysql binlog模式
show variables like 'binlog_format';
#获取binlog文件列表
show binary logs;
## 获取binlog_row_image文件列表
## binlog_row_image建议尽量使用FULL
# https://segmentfault.com/a/1190000016008847
# binlog_row_image参数可以设置三个合法值: FULL、MINIMAL、NOBLOB
show variables like 'binlog_row_image';
#查看当前正在写入的binlog文件
show master status\G
#查看指定binlog文件的内容
show binlog events in 'mysql-bin.000007';
show binlog events in 'mysql-bin.000019' limit 10;
show binlog events in 'mysql-bin.000019' from 280502;
SHOW BINLOG EVENTS [IN 'log_name'] [FROM pos] [LIMIT [offset,] row_count]
show binlog events in 'mysql-bin.000067' from 241544;
show binlog events in 'mysql-bin.000007' from 773715;
show binlog events in 'mysql-bin.000001' from 245;

show variables like "%time_zone%";

SELECT OCTET_LENGTH(content) FROM store_navigation WHERE `id`=17

### error
# mysql错误类似：Incorrect date value: '0000-00-00' for column 'xxxx' at row 1
# 2.修改mysql.int

# 在[mysqld]添加一项：sql_mode=NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO，支持特殊的语法，这样就可以导入了，导入完毕后，移除兼容项即可。此方法简单，建议使用此方法。

### error 1418
# 1418 (HY000) at line 10185: This function has none of DETERMINISTIC, NO SQL, or READS SQL DATA in its declaration and binary logging is enabled (you *might* want to use the less safe log_bin_trust_function_creators variable)
# https://stackoverflow.com/questions/26015160/deterministic-no-sql-or-reads-sql-data-in-its-declaration-and-binary-logging-i
SET GLOBAL log_bin_trust_function_creators = 1;
# Add the following to the mysql.ini configuration file:
log_bin_trust_function_creators = 1

### 索引
#  /* Alter table in target */
#  ALTER TABLE `stat_setting`
#    ADD UNIQUE KEY `idx_title`(`title`) ;
#  /*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;


### aarch64 arm64
- https://blog.csdn.net/qq_24585103/article/details/110187699
- https://dev.mysql.com/downloads/mysql/5.5.html?os=31&version=5.1
wget https://cdn.mysql.com//Downloads/MySQL-8.0/mysql-8.0.27-1.el8.aarch64.rpm-bundle.tar
tar mysql-8.0.27-1.el8.aarch64.rpm-bundle.tar
# 安装顺序：
#common
#libs
#libs-compat
#client
#server
#test（可选装，测试数据库使用）
#devel（可选装，嵌入式数据库函数）
#embedded-compat（可选装，兼容式数据库函数）

rpm -ivh mysql-community-common-8.0.27-1.el8.aarch64.rpm --nodeps --force
rpm -ivh mysql-community-libs-8.0.27-1.el8.aarch64.rpm --nodeps --force
rpm -ivh mysql-community-libs-compat-8.0.27-1.el8.aarch64.rpm --nodeps --force
rpm -ivh mysql-community-client-8.0.27-1.el8.aarch64.rpm --nodeps --force
rpm -ivh mysql-community-client-plugins-8.0.27-1.el8.aarch64.rpm --nodeps --force
rpm -ivh mysql-community-server-8.0.27-1.el8.aarch64.rpm --nodeps --force
rpm -ivh mysql-community-devel-8.0.27-1.el8.aarch64.rpm --nodeps --force
rpm -ivh mysql-community-embedded-compat-8.0.27-1.el8.aarch64.rpm --nodeps --force


### api
- https://dev.mysql.com/doc/c-api/8.0/en/c-api-building-clients.html
- https://textsegment.com/mysql-c-api/
