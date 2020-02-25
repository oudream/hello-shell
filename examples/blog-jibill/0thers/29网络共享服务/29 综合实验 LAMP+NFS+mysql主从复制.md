@[TOC](目录)

# 综合实验
实验环境：8台虚拟机
1. 192.168.99.108：图形界面的
2. 192.168.99.101：powerDNS
3. 192.168.99.102~3：web布署wordpress
4. 192.168.99.104：NFS服务器
5. 192.168.99.105~7：mysql主从半同步复制


## 106~108:mysql主从半同步复制

<table><td bgcolor='orange'> 主机：192.168.99.106~108 </td></table>

106~108主机上都安装
1. 直接yum安装吧
```sh
yum -y install mariadb-server
```
2. 启动
```sh
systemctl start mariadb
systemctl enable mariadb
```

<table><td bgcolor='orange'> 主服务器：192.168.99.106 </td></table>

1. 修改配置文件
```bash
vim /etc/my.cnf
	[mysqld]
 #加这2条
	server_id=106
	log_bin
```
2. 重启服务
```bash
systemctl restart mariadb
```

3. 创建帐号用于复制
```bash
[105]$ mysql

MariaDB [(none)]> grant replication slave on *.* to repluser@'%' identified by '123';
```

<table><td bgcolor='orange'> 从服务器1：192.168.99.107 </td></table>

1. 修改配置文件
```bash
[107]$ vim /etc/my.cnf
	[mysqld]
	server_id=107
  read_only
```

2. 重启服务
```bash
[107]$ systemctl restart mariadb
```

3. 连接到主服务器
```bash
[107]$ mysql

MariaDB [(none)]> change master to 
master_host='192.168.99.106',
master_user='repluser',
master_password='123',
master_port=3306,
master_log_file='mariadb-bin.000001',
master_log_pos=0;
```

4. 启动slave
```bash
MariaDB [(none)]> start slave ;
```

5. 查看是否连接上
```bash
MariaDB [(none)]> show slave status\G;
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 192.168.99.105
                  Master_User: repluser
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mariadb-bin.000001
          Read_Master_Log_Pos: 386
               Relay_Log_File: mariadb-relay-bin.000002
                Relay_Log_Pos: 672
        Relay_Master_Log_File: mariadb-bin.000001
             Slave_IO_Running: Yes
            Slave_SQL_Running: Yes
              Replicate_Do_DB:
          Replicate_Ignore_DB:
           Replicate_Do_Table:
       Replicate_Ignore_Table:
      Replicate_Wild_Do_Table:
  Replicate_Wild_Ignore_Table:
                   Last_Errno: 0
                   Last_Error:
                 Skip_Counter: 0
          Exec_Master_Log_Pos: 386
              Relay_Log_Space: 968
              Until_Condition: None
               Until_Log_File:
                Until_Log_Pos: 0
           Master_SSL_Allowed: No
           Master_SSL_CA_File:
           Master_SSL_CA_Path:
              Master_SSL_Cert:
            Master_SSL_Cipher:
               Master_SSL_Key:
        Seconds_Behind_Master: 0
Master_SSL_Verify_Server_Cert: No
                Last_IO_Errno: 0
                Last_IO_Error:
               Last_SQL_Errno: 0
               Last_SQL_Error:
  Replicate_Ignore_Server_Ids:
             Master_Server_Id: 1
```


<table><td bgcolor='orange'> 从服务器2：192.168.99.108 </td></table>

1. 修改配置文件
```bash
[108]$ vim /etc/my.cnf
	[mysqld]
	server_id=3
  read_only
```

2. 重启服务
```bash
[108]$ systemctl restart mariadb
```

3. 连接到主服务器
```bash
[108]$ mysql

MariaDB [(none)]> change master to 
master_host='192.168.99.106',
master_user='repluser',
master_password='123',
master_port=3306,
master_log_file='mariadb-bin.000001',
master_log_pos=0;
```

4. 启动slave
```bash
MariaDB [(none)]> start slave ;
```

5. 查看是否启动成功
```bash
MariaDB [(none)]> show slave status\G;
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 192.168.99.101
                  Master_User: repluser
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mariadb-bin.000001
          Read_Master_Log_Pos: 386
               Relay_Log_File: mariadb-relay-bin.000002
                Relay_Log_Pos: 672
        Relay_Master_Log_File: mariadb-bin.000001
             Slave_IO_Running: Yes
            Slave_SQL_Running: Yes
              Replicate_Do_DB:
          Replicate_Ignore_DB:
           Replicate_Do_Table:
       Replicate_Ignore_Table:
      Replicate_Wild_Do_Table:
  Replicate_Wild_Ignore_Table:
                   Last_Errno: 0
                   Last_Error:
                 Skip_Counter: 0
          Exec_Master_Log_Pos: 386
              Relay_Log_Space: 968
              Until_Condition: None
               Until_Log_File:
                Until_Log_Pos: 0
           Master_SSL_Allowed: No
           Master_SSL_CA_File:
           Master_SSL_CA_Path:
              Master_SSL_Cert:
            Master_SSL_Cipher:
               Master_SSL_Key:
        Seconds_Behind_Master: 0
Master_SSL_Verify_Server_Cert: No
                Last_IO_Errno: 0
                Last_IO_Error:
               Last_SQL_Errno: 0
               Last_SQL_Error:
  Replicate_Ignore_Server_Ids:
             Master_Server_Id: 1
```

<table><td bgcolor='orange'> 主服务器：192.168.99.106 </td></table>

1. 在主服务器上安装主服务器的插件
```bash
MariaDB [(none)]> INSTALL PLUGIN rpl_semi_sync_master SONAME 'semisync_master.so';
```

2. 查看安装的插件
```bash
MariaDB [(none)]> show plugins;
...
| rpl_semi_sync_master           | ACTIVE   | REPLICATION        | semisync_master.so | GPL     |
+--------------------------------+----------+--------------------+--------------------+---------+
```

3. 查看下这个插件的状态，并没有启动，enabled为OFF
```bash
MariaDB [(none)]> show global variables like '%semi%';
+------------------------------------+-------+
| Variable_name                      | Value |
+------------------------------------+-------+
| rpl_semi_sync_master_enabled       | OFF   |
| rpl_semi_sync_master_timeout       | 10000 |
| rpl_semi_sync_master_trace_level   | 32    |
| rpl_semi_sync_master_wait_no_slave | ON    |
+------------------------------------+-------+
#其中：timeout这个参数是指同步超时时间
```

4. 启用这个插件
```bash
MariaDB [(none)]> set global rpl_semi_sync_master_enabled=on;
```

5. 查看下，是不是启用了
```bash
MariaDB [(none)]> show global variables like '%semi%';
+------------------------------------+-------+
| Variable_name                      | Value |
+------------------------------------+-------+
| rpl_semi_sync_master_enabled       | ON    |
...
```

<table><td bgcolor='orange'> 从服务器1：192.168.99.107 </td></table>

1. 从服务器安装的插件不太一样，看
```bash
MariaDB [(none)]> INSTALL PLUGIN rpl_semi_sync_slave SONAME 'semisync_slave.so';
```

2. 查看安装的插件
```bash
MariaDB [(none)]> show plugins;
| rpl_semi_sync_slave            | ACTIVE   | REPLICATION        | semisync_slave.so | GPL     |
+--------------------------------+----------+--------------------+-------------------+---------+
```

3. 查看下这个插件的状态，并没有启动，enabled为OFF
```bash
MariaDB [(none)]> show global variables like '%semi%';
+---------------------------------+-------+
| Variable_name                   | Value |
+---------------------------------+-------+
| rpl_semi_sync_slave_enabled     | OFF   |
| rpl_semi_sync_slave_trace_level | 32    |
+---------------------------------+-------+
```

4. 启用它
```bash
MariaDB [(none)]> set global rpl_semi_sync_slave_enabled=on;
```

5. 看，启动了
```bash
MariaDB [(none)]> show global variables like '%semi%';
+---------------------------------+-------+
| Variable_name                   | Value |
+---------------------------------+-------+
| rpl_semi_sync_slave_enabled     | ON    |
| rpl_semi_sync_slave_trace_level | 32    |
+---------------------------------+-------+
```

6. 设置完还得重启线程
```bash
MariaDB [(none)]> stop slave; 

MariaDB [(none)]> start slave; 
```

<table><td bgcolor='orange'> 从服务器2：192.168.99.108 </td></table>

1. 跟107一样
```bash
MariaDB [(none)]> INSTALL PLUGIN rpl_semi_sync_slave SONAME 'semisync_slave.so';
```

2. 查看安装的插件
```bash
MariaDB [(none)]> show plugins;
| rpl_semi_sync_slave            | ACTIVE   | REPLICATION        | semisync_slave.so | GPL     |
+--------------------------------+----------+--------------------+-------------------+---------+
```

3. 查看下这个插件的状态，并没有启动，enabled为OFF
```bash
MariaDB [(none)]> show global variables like '%semi%';
+---------------------------------+-------+
| Variable_name                   | Value |
+---------------------------------+-------+
| rpl_semi_sync_slave_enabled     | OFF   |
| rpl_semi_sync_slave_trace_level | 32    |
+---------------------------------+-------+
```

4. 启用它
```bash
MariaDB [(none)]> set global rpl_semi_sync_slave_enabled=on;
```

5. 看，启动了
```bash
MariaDB [(none)]> show global variables like '%semi%';
+---------------------------------+-------+
| Variable_name                   | Value |
+---------------------------------+-------+
| rpl_semi_sync_slave_enabled     | ON    |
| rpl_semi_sync_slave_trace_level | 32    |
+---------------------------------+-------+
```

6. 设置完还得重启线程
```bash
MariaDB [(none)]> stop slave; 

MariaDB [(none)]> start slave; 
```

<table><td bgcolor='orange'> 主服务器：192.168.99.106 </td></table>

1. 回到主服务器上看，已经有2个线程了
```bash
MariaDB [(none)]> SHOW GLOBAL STATUS LIKE '%semi%';
+--------------------------------------------+-------+
| Variable_name                              | Value |
+--------------------------------------------+-------+
| Rpl_semi_sync_master_clients               | 2     |
...
```

2. 给wordpress创建帐号用
```sh
MariaDB [(none)]> create database wpdb;
MariaDB [(none)]> grant all privileges on wpdb.* to wpuser@'192.168.99.%' identified by "123";
```

3. 创建帐号给powerDNS用
```sh
MariaDB [(none)]> create database powerdns;
MariaDB [(none)]> grant all privileges on powerdns.* to powerdns@'192.168.99.%' identified by "123";
```

4. 创建帐号给ProxySQL监控用
```sh
MariaDB [(none)]> grant replication client on *.* to monitor@'192.168.99.%' identified by '123';
```

4. 创建帐号用来ProxySQL访问的(没写错，这里真的还是4)
```bash
MySQL> grant all on *.* to sqluser@'%' identified by '123';
```

5. 创建powerdns数据库中的表，参看下面
```sh
USE powerdns;
CREATE TABLE domains (
  id                    INT AUTO_INCREMENT,
  name                  VARCHAR(255) NOT NULL,
  master                VARCHAR(128) DEFAULT NULL,
  last_check            INT DEFAULT NULL,
  type                  VARCHAR(6) NOT NULL,
  notified_serial       INT DEFAULT NULL,
  account               VARCHAR(40) DEFAULT NULL,
  PRIMARY KEY (id)
) Engine=InnoDB;

CREATE UNIQUE INDEX name_index ON domains(name);


CREATE TABLE records (
  id                    BIGINT AUTO_INCREMENT,
  domain_id             INT DEFAULT NULL,
  name                  VARCHAR(255) DEFAULT NULL,
  type                  VARCHAR(10) DEFAULT NULL,
  content               VARCHAR(64000) DEFAULT NULL,
  ttl                   INT DEFAULT NULL,
  prio                  INT DEFAULT NULL,
  change_date           INT DEFAULT NULL,
  disabled              TINYINT(1) DEFAULT 0,
  ordername             VARCHAR(255) BINARY DEFAULT NULL,
  auth                  TINYINT(1) DEFAULT 1,
  PRIMARY KEY (id)
) Engine=InnoDB;

CREATE INDEX nametype_index ON records(name,type);
CREATE INDEX domain_id ON records(domain_id);
CREATE INDEX recordorder ON records (domain_id, ordername);


CREATE TABLE supermasters (
  ip                    VARCHAR(64) NOT NULL,
  nameserver            VARCHAR(255) NOT NULL,
  account               VARCHAR(40) NOT NULL,
  PRIMARY KEY (ip, nameserver)
) Engine=InnoDB;


CREATE TABLE comments (
  id                    INT AUTO_INCREMENT,
  domain_id             INT NOT NULL,
  name                  VARCHAR(255) NOT NULL,
  type                  VARCHAR(10) NOT NULL,
  modified_at           INT NOT NULL,
  account               VARCHAR(40) NOT NULL,
  comment               VARCHAR(64000) NOT NULL,
  PRIMARY KEY (id)
) Engine=InnoDB;

CREATE INDEX comments_domain_id_idx ON comments (domain_id);
CREATE INDEX comments_name_type_idx ON comments (name, type);
CREATE INDEX comments_order_idx ON comments (domain_id, modified_at);


CREATE TABLE domainmetadata (
  id                    INT AUTO_INCREMENT,
  domain_id             INT NOT NULL,
  kind                  VARCHAR(32),
  content               TEXT,
  PRIMARY KEY (id)
) Engine=InnoDB;

CREATE INDEX domainmetadata_idx ON domainmetadata (domain_id, kind);


CREATE TABLE cryptokeys (
  id                    INT AUTO_INCREMENT,
  domain_id             INT NOT NULL,
  flags                 INT NOT NULL,
  active                BOOL,
  content               TEXT,
  PRIMARY KEY(id)
) Engine=InnoDB;

CREATE INDEX domainidindex ON cryptokeys(domain_id);


CREATE TABLE tsigkeys (
  id                    INT AUTO_INCREMENT,
  name                  VARCHAR(255),
  algorithm             VARCHAR(50),
  secret                VARCHAR(255),
  PRIMARY KEY (id)
) Engine=InnoDB;

CREATE UNIQUE INDEX namealgoindex ON tsigkeys(name, algorithm);
```

- - -

## 105:布署ProxySQL

<table><tr><td bgcolor=orange> proxySQL：192.168.99.105  </td></tr></table>

1. 安装前还得配置下官方的yum源
要不就自行下载安装：https://github.com/sysown/proxysql/releases
```bash
[101]$ vim /etc/yum.repos.d/proxysql.repo
[proxysql_repo]
name= ProxySQL YUM repository
baseurl=http://repo.proxysql.com/ProxySQL/proxysql-1.4.x/centos/\$releasever
gpgcheck=1
gpgkey=http://repo.proxysql.com/ProxySQL/repo_pub_key
```

1. 安装proxySQL
```bash
yum clean all 

yum install proxysql
```

3. 启动proxySQL
```bash
systemctl start proxysql
```

4. 端口起来了，看看
```bash
ss -tnl
#下面是输出
State      Recv-Q Send-Q Local Address:Port               Peer Address:Port  
LISTEN     0      128          *:6032                     *:*
LISTEN     0      128          *:6033                     *:*
LISTEN     0      128          *:6033                     *:*
LISTEN     0      128          *:6033                     *:*
LISTEN     0      128          *:6033                     *:*
......
```


4. 登录前你还需要
```sh
yum -y install mariadb
```

5. 登录到proxysql试试
```bash
mysql -uadmin -padmin -P6032 -h127.0.0.1
#下面是输出
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MySQL connection id is 1
Server version: 5.5.30 (ProxySQL Admin Module)

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MySQL [(none)]>
```

连接成功，简单看看
```bash
MySQL [(none)]> show databases;
+-----+---------------+-------------------------------------+
| seq | name          | file                                |
+-----+---------------+-------------------------------------+
| 0   | main          |                                     |
| 2   | disk          | /var/lib/proxysql/proxysql.db       |
| 3   | stats         |                                     |
| 4   | monitor       |                                     |
| 5   | stats_history | /var/lib/proxysql/proxysql_stats.db |
+-----+---------------+-------------------------------------+
```

6. 大致来了解下
```bash
#查看表结构
MySQL > select * from sqlite_master where name='mysql_servers'\G

#查看你的SQL服务器有哪些，当然什么都没有，还没有添加
MySQL > select * from mysql_servers;
```

7. 添加你的3台MySQL主机
```bash
MySQL > insert into mysql_servers(hostgroup_id,hostname,port) values(10,'192.168.99.106',3306);

MySQL > insert into mysql_servers(hostgroup_id,hostname,port) values(10,'192.168.99.107',3306);

MySQL > insert into mysql_servers(hostgroup_id,hostname,port) values(10,'192.168.99.108',3306);
```

8. 添加上了，可以看看
```bash
MySQL > select * from mysql_servers;
+--------------+----------------+------+--------+--------+-------------+-----------------+---------------------+---------+----------------+---------+
| hostgroup_id | hostname       | port | status | weight | compression | max_connections | max_replication_lag | use_ssl | max_latency_ms | comment |
+--------------+----------------+------+--------+--------+-------------+-----------------+---------------------+---------+----------------+---------+
| 10           | 192.168.99.106 | 3306 | ONLINE | 1      | 0           | 1000            | 0                   | 0       | 0              |         |
| 20           | 192.168.99.108 | 3306 | ONLINE | 1      | 0           | 1000            | 0                   | 0       | 0              |         |
| 20           | 192.168.99.107 | 3306 | ONLINE | 1      | 0           | 1000            | 0                   | 0       | 0              |         |
+--------------+----------------+------+--------+--------+-------------+-----------------+---------------------+---------+----------------+---------+


```

9. 当然，这2步少不了。加载并保存到磁盘
```bash
MySQL > load mysql servers to runtime;

MySQL > save mysql servers to disk;
```
添加监控后端节点的用户。ProxySQL通过每个节点的read_only值来自动调整它们是属于读组还是写组


10. 添加监控后端节点的用户。后面ProxySQL通过每个节点的read_only值来自动调整它们是属于读组还是写组
```bash
MySQL [(none)]> set mysql-monitor_username='monitor';
MySQL [(none)]> set mysql-monitor_password='123';
```

11. 加载到RUNTIME，并保存到disk
```bash
MySQL [(none)]> load mysql variables to runtime;
MySQL [(none)]> save mysql variables to disk;
```

12. 查看监控连接是否正常的 (对connect指标的监控)：(如果connect_error的结果为NULL则表示正常,看最后2条)
```bash
MySQL [(none)]> select * from mysql_server_connect_log;
+----------------+------+------------------+-------------------------+-------------------------------------------------------------------------+
| hostname       | port | time_start_us    | connect_success_time_us | connect_error                                                           |
+----------------+------+------------------+-------------------------+-------------------------------------------------------------------------+
...
| 192.168.99.108 | 3306 | 1564319563111306 | 2242                    | NULL                                                                    |
| 192.168.99.107 | 3306 | 1564319563558118 | 2541                    | NULL                                                                    |
| 192.168.99.106 | 3306 | 1564319564004888 | 2178                    | NULL                                                                    |
| 192.168.99.108 | 3306 | 1564319623112139 | 3408                    | NULL                                                                    |
| 192.168.99.106 | 3306 | 1564319623596123 | 3384                    | NULL                                                                    |
| 192.168.99.107 | 3306 | 1564319624080684 | 2681                    | NULL                                                                    |
| 192.168.99.106 | 3306 | 1564319683112439 | 3277                    | NULL                                                                    |
| 192.168.99.108 | 3306 | 1564319683641071 | 3359                    | NULL                                                                    |
| 192.168.99.107 | 3306 | 1564319684169766 | 1197                    | NULL                                                                    |
+----------------+------+------------------+-------------------------+-------------------------------------------------------------------------+


```

13. 也可以查看监控心跳信息 (对ping指标的监控)(如果ping_error的结果为NULL则表示正常)
```bash
MySQL> select * from mysql_server_ping_log;
```

14. 还有其它的，查看read_only和replication_lag的监控日志
```bash
MySQL> select * from mysql_server_read_only_log;
MySQL> select * from mysql_server_replication_lag_log;
```

**设置分组信息**

15. 需要修改的是main库中的`mysql_replication_hostgroups`表，该表有3个字段：`writer_hostgroup`写组，`reader_hostgroup`读组，`comment`备注, 指定写组的id为10，读组的id为20
```bash
MySQL> insert into mysql_replication_hostgroups values(10,20,"test");
```

16. 加载到RUNTIME生效并保存
```bash
MySQL> load mysql servers to runtime;
MySQL> save mysql servers to disk;
```

17. Monitor模块监控后端的read_only值，按照read_only的值将节点自动移动到读/写组
```bash
MySQL> select hostgroup_id,hostname,port,status,weight from mysql_servers;
+--------------+----------------+------+--------+--------+
| hostgroup_id | hostname       | port | status | weight |
+--------------+----------------+------+--------+--------+
| 10           | 192.168.99.106 | 3306 | ONLINE | 1      |
| 20           | 192.168.99.108 | 3306 | ONLINE | 1      |
| 20           | 192.168.99.107 | 3306 | ONLINE | 1      |
+--------------+----------------+------+--------+--------+

```


18. 在ProxySQL配置，将用户sqluser添加到mysql_users表中， default_hostgroup默认组设置为写组10，当读写分离的路由规则不符合时，会访问默认组的数据库
```bash
MySQL> insert into mysql_users(username,password,default_hostgroup) values('sqluser','123',10);

MySQL> insert into mysql_users(username,password,default_hostgroup) values('wpuser','123',10);

MySQL> insert into mysql_users(username,password,default_hostgroup) values('powerdns','123',10);
```

19. 保存生效
```bash
MySQL> load mysql users to runtime;
MySQL> save mysql users to disk;
```


20. 使用sqluser用户测试是否能路由到默认的10写组实现读、写数据。是的，我的写组就是主服务器，也就是server_id=2的主机。
```bash
[105]$ mysql -usqluser -p123 -P6033 -h127.0.0.1 -e 'select @@server_id'
+-------------+
| @@server_id |
+-------------+
|         106 |
+-------------+
```

21. 创建个数据库，看看能不能行
```bash
[101]$ mysql -usqluser -p123 -P6033 -h127.0.0.1 -e 'create database testdb'
#然后去主从服务器上看看，有没有这个数据库
#这里还创建了个表，也去看看有没有
[101]$ mysql -usqluser -p123 testdb -P6033 -h127.0.0.1 -e 'create table t(id int)'
```

在proxysql上配置路由规则，实现读写分离
>与规则有关的表：mysql_query_rules和mysql_query_rules_fast_routing，后者是前者的扩展表，1.4.7之后支持
>插入路由规则：将select语句分离到20的读组，select语句中有一个特殊语句SELECT...FOR UPDATE它会申请写锁，应路由到10的写组

22. 具体可以这样写
```bash
#先进入
[105]$ mysql -uadmin -padmin -P6032 -h127.0.0.1

MySQL> insert into mysql_query_rules
(rule_id,active,match_digest,destination_hostgroup,apply)VALUES
(1,1,'^SELECT.*FOR UPDATE$',10,1),(2,1,'^SELECT',20,1);
```

23. 保存生效
```bash
MySQL> load mysql query rules to runtime;
MySQL> save mysql query rules to disk;
```
注意：因ProxySQL根据rule_id顺序进行规则匹配，select ... for update规则的rule_id必须要小于普通的select规则的rule_id


24. 看下生效了没，已经有了2条记录了
```bash
MySQL [(none)]> select rule_id,active,match_digest,destination_hostgroup,apply from mysql_query_rules;
+---------+--------+----------------------+-----------------------+-------+
| rule_id | active | match_digest         | destination_hostgroup | apply |
+---------+--------+----------------------+-----------------------+-------+
| 1       | 1      | ^SELECT.*FOR UPDATE$ | 10                    | 1     |
| 2       | 1      | ^SELECT              | 20                    | 1     |
+---------+--------+----------------------+-----------------------+-------+
```

**到这里就可以实现读写分离了**

25. 那就来测试下吧，以事务和非事务的方式进行测试
```bash
[105]$ mysql -usqluser -p123 -P6033 -h127.0.0.1 -e 'start transaction;select @@server_id;commit;select @@server_id'
+-------------+
| @@server_id |
+-------------+
|         106 |
+-------------+
+-------------+
| @@server_id |
+-------------+
|         107 |
+-------------+

#那为什么会一个是106，一个是107呢。 
#这是因为我们配置的时候，只有SELECT开头的才到从服务器访问，
#事务是以BEGIN或者START TRANSACTION开头的，所以会支访问主服务器。
```

26. 再执行一次
```sh
[105]$ mysql -usqluser -p123 -P6033 -h127.0.0.1 -e 'start transaction;select @@server_id;commit;select @@server_id'
+-------------+
| @@server_id |
+-------------+
|         106 |
+-------------+
+-------------+
| @@server_id |
+-------------+
|         108 |
+-------------+
#看到没，108了
```

27. 创建个表，插入的内容来查查看看吧。
```bash
#前面已经把testdb这个数据库创建了
[101]$ mysql -usqluser -p123 -P6033 -h127.0.0.1 -e 'use testdb;create table t(id int);'
[101]$ mysql -usqluser -p123 -P6033 -h127.0.0.1 -e 'insert testdb.t values (1)'
[101]$ mysql -usqluser -p123 -P6033 -h127.0.0.1 -e 'select id from testdb.t'
+------+
| id   |
+------+
|    1 |
+------+
```
**在这里强调下：**
(1)进入proxySQL管理界面是：`mysql -uadmin -padmin -P6032 -h127.0.0.1`，端口号是：6032，默认的帐号密码是admin和admin。
(2)如果使用`mysql -usqluser -p123 -P6033 -h127.0.0.1`则访问的是主服务器上的数据库了。

**搞定了，接着看**

- - -

## 101:布署powerDNS
<table><td bgcolor='orange'> 主机：192.168.99.101 </td></table>

1. 这是在主机101上
安装包：基于EPEL源
```sh
yum install -y pdns pdns-backend-mysql
```

2. 安装http + php
```sh
yum -y install httpd  php php-mysql php-mbstring
```

3. 启动服务
```sh
systemctl start httpd
```

4. 没有4

5. 配置PowerDNS使用mariadb作为后台数据存储
```sh
#查找到包含launch= 的行，修改并添加下面的内容
[102]$ vim /etc/pdns/pdns.conf
#大概在250行
launch=gmysql   
gmysql-host=192.168.99.105   #ProxySQL的ip
gmysql-port=6033   #端口
gmysql-dbname=powerdns  #数据库名
gmysql-user=powerdns    #用户
gmysql-password=123  #密码
```

6. 启动服务
```sh
systemctl start pdns
systemctl enable pdns
```

7. 安装httpd和php相关包
```bash
yum -y install  php-devel php-gd php-mcrypt php-imap php-ldap  php-odbc php-pear php-xml php-xmlrpc php-mcrypt php-mhash gettext
```

8. 启动服务
```sh
systemctl restart httpd
```

9. 下载poweradmin程序，
```sh
cd /var/www/html
wget http://downloads.sourceforge.net/project/poweradmin/poweradmin-2.1.7.tgz
```

10. 解压缩到相应目录
```sh
tar xvf poweradmin-2.1.7.tgz
mv poweradmin-2.1.7 poweradmin
```
设置下权限
```sh
setfacl -Rm u:apache:rwx poweradmin
```

11. 访问下面地址，启动PowerAdmin的网页安装向导：
http://192.168.99.101/poweradmin/install/
选英语，下一步。下一步
<img src="https://img-blog.csdnimg.cn/20190724214320422.png" width="100%">

- - - 

**提供先前配置的数据库详情，同时为Poweradmin设置管理员密码**

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190728214619215.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)
 
 - -  -
12. 为Poweradmin创建一个受限用户

标题| 说明
- | -
Username|PowerAdmin用户名
Password|上述用户的密码
Hostmaster|创建SOA记录指定默认主机管理员
Primary nameserver|主域名服务器
Secondary namesever|辅域名服务器

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190727200859706.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

- - -

<img src="https://img-blog.csdnimg.cn/20190727201034572.png" width="80%">

13. 按照下面页面说明，在数据库中创建用户并授权，然后再下一步
注意啊，这里是 ==106主机==， 是数据库的主服务器。
```sh
[106]$ mysql

MariaDB [(none)]> GRANT SELECT, INSERT, UPDATE, DELETE ON powerdns.* TO 'poweradmin'@'localhost' IDENTIFIED BY '123';
```

- - - 

<img src="https://img-blog.csdnimg.cn/2019072720110182.png" width="80%">

14. 按下面页面说明，修改config.in.php文件内容,注意==不要复制我的，不要复制我的，看你自己的==
```sh
[101]$ mv poweradmin/inc/config-me.inc.php poweradmin/inc/config.inc.php

[101]$ vim /var/www/html/poweradmin/inc/config.inc.php
 18 $db_host = '192.168.99.105';
 19 $db_port = '6033';
 20 $db_user = 'powerdns';
 21 $db_pass = '123';
 22 $db_name = 'powerdns';
 23 $db_type = 'mysql';
...
 26 $db_layer       = 'PDO';    # or MDB2
...
 30 $session_key = 'gKB$t5Qx%l!%$d+M~T$Hv+lABp$nNKKRe{7v}W3SMO0=kN';
...
 34 $iface_lang = 'en_EN';
...
 43 $dns_hostmaster = 'powerserver';
 44 $dns_ns1 = '192.168.99.101';
 45 $dns_ns2 = '192.168.99.101';
```

- - -

<img src="https://img-blog.csdnimg.cn/20190724214352436.png" width="80%">

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190727201307457.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

15. 安装完毕后，删除install目录
```sh
[101]$ rm -rf /var/www/html/poweradmin/install/
```
<img src="https://img-blog.csdnimg.cn/20190724214359487.png" width="80%">

- - -

16. 登录http://powerdns服务器IP/poweradmin/
```sh
username：admin
password：123
```
这里登录不了提示：`Error: You have to install PHP mcrypt extension`
解决：
```sh
vim /etc/httpd/conf.modules.d/10-php.conf
...
  5 <IfModule prefork.c>
  6   LoadModule php5_module modules/libphp5.so
  7   LoadModule php5_module modules/mcrypt.so
  8 </IfModule>

```
<img src="https://img-blog.csdnimg.cn/20190724214406828.png" width="80%">

- - - 

1. 来添加个zone
<img src="https://img-blog.csdnimg.cn/20190727201931306.png" width="80%">

- - - 

2. list zone，准备给这个zone添加记录
<img src="https://img-blog.csdnimg.cn/20190727201953797.png" width="80%">

- -  -

3. 添加A记录，指向192.168.99.102

<img src="https://img-blog.csdnimg.cn/20190727202112249.png" width="80%">


- - - 

4. 再添加一条，指向192.168.99.103

<img src="https://img-blog.csdnimg.cn/20190727202404351.png" width="80%">

 - - -
5. 查看，直接search就可以

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190727202549285.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

 - - - 

6. 看，这就有2条记录了。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190727202605232.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)
- - -




## 104:NFS配置

<table><td bgcolor='orange'> 主机：192.168.99.104 </td></table>

1. 安装
```sh
[104]$ yum install -y nfs-utils
```
2. 配置
```sh
[104]$ vim /etc/exports
/data/wordpress 192.168.99.0/24(rw,all_squash,anonuid=997,anongid=995)

#加载
[104]$ exportfs -r
```
3. 启动服务
```sh
[104]$ systemctl restart nfs-server
```

4. 创建用户
```sh
[104]$ groupadd -g 995 apache
[104]$ useradd -r -u 997 -g 995 -s /sbin/nologin apache
```

- - -

## 104:布署wordpress

<table><td bgcolor='orange'> 192.168.99.104 </td></table>
这是在104，NFS服务器
1. 下载
```sh
[104]$ cd
[104]$ wget ftp://192.168.99.1/Magedu37/files/lamp/wordpress-5.0.3-zh_CN.tar.gz
```
2. 解压
```sh
[104]$ tar xf wordpress-5.0.3-zh_CN.tar.gz -C /data/
```

3. 删除包
```sh
[104]$ rm -f wordpress-5.0.3-zh_CN.tar.gz
[104]$ chown -R apache.apache /data/wordpress/
```

- - -

## 102:安装apache+php

<table><td bgcolor='orange'> 主机：192.168.99.102 </td></table>

1. 在主机102上安装php和httpd
```sh
[102]$ yum -y install php httpd php-mysql php-mbstring
```

2. 修改配置文件
```sh
[102]$ vim /etc/httpd/conf.d/test.conf

<virtualhost *:80>
    documentroot /data/wordpress
    servername blog.jibill.com
    <directory /data/wordpress>
        require all granted
    </directory>
</virtualhost>
```


3. 重启服务
```sh
[102]$ systemctl restart httpd24
```

4. 安装nfs-utils准备挂载nfs
```sh
[102]$ yum -y install nfs-utils
[102]$ mkdir /data/wordpress 
[102]$ mount 192.168.99.104:/data/wordpress /data/wordpress
```


7. 来测试下。注意下方多图预警
因为还没配主机103，所以先用192.168.99.102测试,
可以修改hosts文件
```sh
vim hosts
  192.168.99.102 blog.jibill.com
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190727202737904.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

- - -

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190727202756864.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)




- - -

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190728215934724.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

- - -

![在这里插入图片描述](https://img-blog.csdnimg.cn/2019072720334359.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

- - -

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190727203408909.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

- - -

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190727203422967.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

- - -

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190727203431685.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

- - -

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190727203442755.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)


下面配置103，实现web服务器的负载均衡

- - - 


## 103:安装apache+php

<table><td bgcolor='orange'> 主机：192.168.99.103 </td></table>

1. 在主机103上安装php和httpd
```sh
[102]$ yum -y install php httpd php-mysql php-mbstring
```

2. 修改配置文件
```sh
[102]$ vim /etc/httpd/conf.d/test.conf

<virtualhost *:80>
    documentroot /data/wordpress
    servername blog.jibill.com
    <directory /data/wordpress>
        require all granted
    </directory>
</virtualhost>
```


3. 重启服务
```sh
[102]$ systemctl restart httpd24
```

4. 安装nfs-utils准备挂载nfs
```sh
[102]$ yum -y install nfs-utils
[102]$ mkdir /data/wordpress 
[102]$ mount 192.168.99.104:/data/wordpress /data/wordpress
```


- - -

<table><td bgcolor='orange'> 192.168.99.108 </td></table>

1. 测试下，先修改DNS，然后重启网卡，==记得把你的hosts文件清空，别忘了刚才添加的那条==

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190727211222986.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

```sh
[108]$ systemctl restart network
```

1. 访问`blog.jibill.com/`成功

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190728122326152.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)


**这样还能实现web服务器的负载均衡**

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190728221156400.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

![在这里插入图片描述](https://img-blog.csdnimg.cn/2019072822264423.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)