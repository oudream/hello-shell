  
[toc]

<img src="https://img-blog.csdnimg.cn/20190701172826339.png" width="60%">

其实MySQL和MariaDB是同一个人开发的，所以在功能和用法和，几乎一致。自从MySQL被ORICAL收购后,开源的MySQL就成为了商业化的产品，以后的趋势是去IOE,这个概念是由阿里巴巴 2008 年提出,所谓的“IOE”,指的是以 IBM 、Oracle、EMC 为代表的小型机、 集中式数据库和高端存储所组成的 IT 技术架构。
所以下面所讲的MySQL其实就是MariaDB，实际使用的软件是MariaDB。


>数据库的发展史
1. 萌芽阶段：文件系统
使用磁盘文件来存储数据
2. 初级阶段：第一代数据库
出现了网状模型、层次模型的数据库
3. 中级阶段：第二代数据库
关系型数据库和结构化查询语言
4. 高级阶段：新一代数据库
“关系-对象”型数据库


# 数据库管理系统

>数据库是数据的汇集，它以一定的组织形式存于存储介质上。**DBMS**是管理数据库的系统软件，它实现数据库系统的各种功能。是数据库系统的核心。**DBA**负责数据库的规划、设计、协调、维护和管理等工作

**数据库管理系统的优点**
1. 相互关联的数据的集合
2. 较少的数据冗余
3. 程序与数据相互独立
4. 保证数据的安全、可靠
5. 最中大限度地保证数据的正确性
6. 数据可以并发使用并能同时保证一致性 

**文件管理系统的缺点**
1. 编写应用程序不方便
2. 数据冗余不可避免
3. 应用程序依赖性
4. 不支持对文件的并发访问
5. 数据间联系弱
6. 难以按用户视图表示数据
7. 无安全控制功能

**数据库系统的架构**
1. 单机架构
2. 大型主机/终端架构
3. 主从式架构（C/S）
4. 分布式架构


## 关系型数据库
**关系** ：关系就是二维表，其中：表中的行、列次序并不重要
**行row**：表中的每一行，又称为一条记录
**列column**：表中的每一列，称为属性，字段
**主键Primary key**：用于惟一确定一个记录的字段
**域domain**：属性的取值范围，如，性别只能是‘男’和‘女’两个值

+  **关系型数据库管理系统 RDBMS（Relational Database Management System）**
    1. MySQL: MySQL, MariaDB, Percona Server
    2. PostgreSQL: 简称为pgsql，EnterpriseDB
    3. Oracle
    4. MSSQL
    5. DB2


+ 数据库排名：
https://db-engines.com/en/ranking
![在这里插入图片描述](https://img-blog.csdnimg.cn/201907011748212.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)


## 简易数据规划流程
1. **第一阶段**：收集数据，得到字段
收集必要且完整的数据项
转换成数据表的字段
2. **第二阶段**：把字段分类，归入表，建立表的关联
关联：表和表间的关系
分割数据表并建立关联的优点
节省空间
减少输入错误
方便数据修改
3. **第三阶段**：
规范化数据库

## 数据库的正规化分析

>数据库规范化，又称数据库或资料库的正规化、标准化，是数据库设计中的一系列原理和技术，以减少数据库中数据冗余，增进数据的一致性。关系模型的发明者埃德加·科德最早提出这一概念，并于1970年代初定义了第一范式、第二范式和第三范式的概念

**RDMBS设计范式基础概念**
1. 设计关系数据库时，遵从不同的规范要求，设计出合理的关系型数据库，不同的规范要求被称为不同范式，各种范式呈递次规范，越高的范式数据库冗余越小
2. 目前关系数据库有六种范式：第一范式（1NF）、第二范式（2NF）、第三范式（3NF）、巴德斯科范式（BCNF）、第四范式(4NF）和第五范式（5NF，又称完美范式）。满足最低要求的范式是第一范式（1NF）。在第一范式的基础上进一步满足更多规范要求的称为第二范式（2NF），其余范式以次类推。一般数据库只需满足第三范式(3NF）即可

**范式**
1. 1NF：无重复的列，每一列都是不可分割的基本数据项，同一列中不能有多个值，即实体中的某个属性不能有多个值或者不能有重复的属性，确保每一列的原子性。除去同类型的字段，就是无重复的列
说明：第一范式（1NF）是对关系模式的基本要求，不满足第一范式（1NF）的数据库就不是关系数据库
2. 2NF：属性完全依赖于主键，第二范式必须先满足第一范式，要求表中的每个行必须可以被唯一地区分。通常为表加上一个列，以存储各个实例的唯一标识PK，非PK的字段需要与整个PK有直接相关性
3. 3NF：属性不依赖于其它非主属性，满足第三范式必须先满足第二范式。第三范式要求一个数据库表中不包含已在其它表中已包含的非主关键字信息，非PK的字段间不能有从属关系
4. ...

# MySQL基本概念
+ 约束：constraint，表中的数据要遵守的限制
    1. 主键(primary key)：一个或多个字段的组合，填入的数据必须能在本表中唯一标识本行；必须提供数据，即NOT NULL，一个表只能有一个
    2. 惟一键(uniqe key)：一个或多个字段的组合，填入的数据必须能在本表中唯一标识本行；允许为NULL，一个表可以存在多个.
    3. 外键：一个表中的某字段可填入的数据取决于另一个表的主键或唯一键已有的数据
    4. 检查：字段值在一定范围内
+ 索引：将表中的一个或多个字段中的数据复制一份另存，并且按特定次序排序存储
+ 关系运算：
    1. 选择：挑选出符合条件的`行`
    2. 投影：挑选出需要的`字段`
    3. 连接：表间字段的关联


## 数据模型
+ 数据抽象：
    &emsp;物理层：数据存储格式，即RDBMS在磁盘上如何组织文件
    &emsp;逻辑层：DBA角度，描述存储什么数据，以及数据间存在什么样的关系
    &emsp;视图层：用户角度，描述DB中的部分数据
+ 关系模型的分类：
    &emsp;关系模型
    &emsp;基于对象的关系模型
    &emsp;半结构化的关系模型：XML数据




# MariaDB初识
**MariaDB的安装**：[安装MariaDB的3种方式]()


**一、相关程序**
1. 客户端程序：
    `mysql`: 交互式的CLI工具
    `mysqldump`：备份工具，基于mysql协议向mysqld发起查询请求，并将查得的所有数据转换成insert等写操作语句保存文本文件中
    `mysqladmin`：基于mysql协议管理mysqld
    `mysqlimport`：数据导入工具
2. MyISAM存储引擎的管理工具：
    `myisamchk`：检查MyISAM库
    `myisampack`：打包MyISAM表，只读
3. 服务器端程序
    `mysqld_safe`
    `mysqld`
    `mysqld_multi` 多实例

**二、用户帐号**

1.  mysql用户账号由两部分组成：
    `'USERNAME'@'HOST'`
    + 说明：HOST限制此用户可通过哪些远程主机连接mysql服务器
    + 支持使用通配符：
        `%` 匹配任意长度的任意字符
        `172.16.0.0/255.255.0.0` 或 `172.16.%.%`
        `_` 匹配任意单个字符
    + 默认帐号：root (无密码)


**三、交互模式**

1. mysql使用交互式模式：
可运行命令有两类：
    +  客户端命令：
    每个命令都完整形式和简写格式
        `\h`或`help`
        `\u`或`use`
        `\s`或`status`
        `\!`或`system`
    + 服务器端命令：
        SQL语句，需要语句结束符`；`
        示例：SELECT VERSION();
2. 脚本模式：
```bash
#1
    [centos]$ mysql –uUSERNAME -pPASSWORD < /path/somefile.sql
#2
    mysql> source /path/from/somefile.sql
```

**四、mysql命令**

选项| 意义 
-|-
-A|禁止补全
-u 用户名|默认为root
-h 服务器主机|默认为localhost
-p用户密码|建议使用-p,默认为空密码
-P 端口 |服务器端口
-S socket文件路径| 指定连接socket文件路径
-D 数据库| 指定默认数据库
-C|启用压缩
-e "SQL" |执行SQL命令
-V|显示版本
-v|显示详细信息
--print-defaults |获取程序默认使用的配置



**五、修改命令提示符**
```bash
#进入mysql并修改命令提示符
[centos]$ mysql -uroot -pcentos --prompt=\u@[\D \r:\m] 
#临时配置
[mysql]> prompt \u@[\D \r:\m]   

#永久配置
[centos]$ vim /etc/my.cnf.d/mysql-clients.cnf
    [mysql]
    prompt = \u@[\D \r:\m]
```

**六、显示默认配置**
```bash
[centos]$ mysql --print-defaults
```


**七、执行命令示例**
注意：`[centos]$`表示bash，`nysql>`表示mysql命令
```bash
#root是帐号，centos是密码
[centos]$ mysql -u root -p centos 
#使用mysql这个数据库
mysql>use mysql;    
#查看当前用户
mysql>select user();  
#查看表内容
mysql>SELECT User,Host,Password FROM user;  
#查看表的字段
mysql>dsec user;  
#直接执行mysql命令：
[centos]$ mysql -e "show databases;"
#脚本模式
[centos]$ mysql –uUSERNAME -pPASSWORD < /path/somefile.sql
```

**八、mysqladmin命令**

```bash
mysqladmin –help    #查看帮助
mysqladmin -uroot -pcentos ping #查看mysql服务是否正常，如果正常提示mysqld is alive
mysqladmin -uroot –pcentos create testdb    #创建数据库testdb
mysqladmin -uroot -pcentos drop testdb  #删除数据库testdb
mysqladmin -uroot -pcentos flush-logs   #日志滚动,生成新文件/var/lib/mysql/ mariadb-bin.00000N
```


**九、修改root密码**

```bash
mysqladmin –uroot –pcentos password 'magedu'
```

**十、关闭mysql服务**
```bash
#但mysqladmin命令无法开启
mysqladmin –uroot –pcentos shutdown
```

**十一、配置文件：**
后面覆盖前面的配置文件，顺序如下：
```bash
#格式：parameter = value
#说明1：'_'和'-'相同
#说明2：ON，TRUE意义相同， 
#说明3：0，OFF，FALSE意义相同
/etc/my.cnf          #Global选项
/etc/mysql/my.cnf    #Global选项
SYSCONFDIR/my.cnf    #Global选项
$MYSQL_HOME/my.cnf Server-specific   #选项
--defaults-extra-file=path
~/.my.cnf User-specific     #选项
```

**十二、关闭网络连接，只侦听本地客户端**
```bash
[centos]$ vim /etc/my.cnf
[mysqld]
skip-networking=1
#所有和服务器的交互都通过一个socket实现，socket的配置存放在/var/lib/mysql/mysql.sock） 可在/etc/my.cnf修改
```


- - - 

**其它章节**
[MySQL数据库(一)_基础概念](https://thson.blog.csdn.net/article/details/95064077)
[MySQL数据库(二)_SQL基础与数据类型](https://thson.blog.csdn.net/article/details/95064154)
[MySQL数据库(三)_SQL语句之DDL](https://thson.blog.csdn.net/article/details/95064571)
[MySQL数据库(四)_SQL语句之DML](https://thson.blog.csdn.net/article/details/95064642)
[MySQL数据库(五)_SQL语句之DQL](https://thson.blog.csdn.net/article/details/95064697)
[MySQL数据库(六)_SQL语句之JOIN](https://thson.blog.csdn.net/article/details/95064767)
[MySQL数据库(七)_视图、函数、储存过程及触发器](https://thson.blog.csdn.net/article/details/95064827)
[MySQL数据库(八)_用户管理](https://thson.blog.csdn.net/article/details/95064890)
[MySQL数据库(九)_存储引擎](https://thson.blog.csdn.net/article/details/95064948)
[MySQL数据库(十)_服务器配置](https://thson.blog.csdn.net/article/details/95065005)
[MySQL数据库(十一)_查询缓存](https://thson.blog.csdn.net/article/details/95065076)
[MySQL数据库(十二)_索引](https://thson.blog.csdn.net/article/details/95065152)
[MySQL数据库(十三)_事务与锁](https://thson.blog.csdn.net/article/details/95065242)
[MySQL数据库(十四)_日志](https://thson.blog.csdn.net/article/details/95444764)
[MySQL数据库(十五)_备份与恢复](https://thson.blog.csdn.net/article/details/95445112)
[MySQL数据库(十六)_备份工具：xtrabackup](https://thson.blog.csdn.net/article/details/95445182)
[MySQL数据库(十七)_MySQL复制](https://thson.blog.csdn.net/article/details/95750833)
[MySQL数据库(十八)_ProxySQL](https://thson.blog.csdn.net/article/details/95750972)
[MySQL数据库(十九)_MHA高可用集群]()
[MySQL数据库(二十)_压力测试]()

