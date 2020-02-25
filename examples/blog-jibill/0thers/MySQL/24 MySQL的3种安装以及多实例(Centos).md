[toc]

# 安装MYSQL的方式

1. 源代码：编译安装
2. 二进制格式的程序包：展开至特定路径，并经过简单配置后即可使用
3. 程序包管理器管理的程序包
    （1）CentOS 安装光盘
    （2）项目官方：https://downloads.mariadb.org/mariadb/repositories/
    （3）国内镜像：https://mirrors.tuna.tsinghua.edu.cn/mariadb/yum/
    （4）国内镜像：https://mirrors.tuna.tsinghua.edu.cn/mysql/yum/



## yum安装
1. 配置yum源
```bash
[root]$ vim /etc/yum.repos.d/mariadb.repo
[mariadb]
baseurl=https://mirrors.tuna.tsinghua.edu.cn/mariadb/yum/10.4/centos7-amd64/
gpgcheck=0
enabled=1

#如果怕其它yum源冲突，可以把其它yum源禁用
```
2. 安装
```bash
[root]$ yum install mariadb-server
```
3. 启动mysql
```bash
[root]$ systemctl start mysql
```
4. 连接数据库
```bash
[root]$ mysql -h 127.0.0.1 -u root -p centos
#-h指定你要连接的mysql服务器，-u指定用户，-p密码
```

5. 服务器监听的两种socket地址：
&emsp;ip socket: 监听在tcp的3306端口，支持远程通信
&emsp;unix sock: 监听在sock文件上，仅支持本机通信
如：/var/lib/mysql/mysql.sock，host为localhost,127.0.0.1时自动使用unix sock
```bash
[101]$ ss -tnl
State      Recv-Q Send-Q Local Address:Port               Peer Address:Port     
...   
LISTEN     0      80          :::3306                    :::*
...
```

6. mysql安全配置脚本
```bash
#执行这个脚本
[root]$ /usr/bin/mysql_secure_installation
#输入root(mysql)的密码。默认没有，直接回车
Enter current password for root (enter for none): 
#是否切换到unix套接字身份验证[Y/n]
Switch to unix_socket authentication [Y/n] n
#是否设置root密码
Change the root password? [Y/n]
#如果选Y，就输入2次密码
New password:
Re-enter new password:
#是否删除匿名用户?(就是空用户)，建议删除
Remove anonymous users? [Y/n]
#是否不允许远程root登录
Disallow root login remotely? [Y/n]
#是否删除test数据库
Remove test database and access to it? [Y/n]
#是否加载权限使之生效
Reload privilege tables now? [Y/n]
```



## 通用二进制格式安装过程
1. 准备二进制程序
可以在这里下载：[官方下载](https://downloads.mariadb.org/interstitial/mariadb-10.3.16/bintar-linux-x86_64/mariadb-10.3.16-linux-x86_64.tar.gz/from/http%3A//mirrors.accretive-networks.net/mariadb/)
```bash
tar xf mariadb-VERSION-linux-x86_64.tar.gz -C /usr/local
cd /usr/local
#创建软连接
ln -s mariadb-VERSION-linux-x86_64 mysql
#更改权限
chown -R root:mysql /usr/local/mysql/
```

2. 准备用户
```bash
groupadd -r -g 306 mysql
useradd -r -g 306 -u 306 –d /data/mysql -s /sbin/nologin mysql
```

3. 准备数据目录，建议使用逻辑卷
```bash
mkdir -p /data/mysql
chown -R mysql:mysql /data/mysql
```

4. 创建数据库文件
```bash
cd /usr/local/mysql/
yum -y install libaio
./scripts/mysql_install_db --datadir=/data/mysql --user=mysql
```

5. 准备配置文件
```bash
mkdir /etc/mysql/
cp support-files/my-huge.cnf /etc/mysql/my.cnf
[mysqld]#中添加三个选项：
datadir = /data/mysql
innodb_file_per_table = on
skip_name_resolve = on #禁止主机名解析，建议使用
```

6. 准备服务脚本，并启动服务
```bash
cd /usr/local/mysql
cp ./support-files/mysql.server /etc/init.d/mysqld
chkconfig --add mysqld
service mysqld start
```

7. PATH路径
```bash
echo PATH='/user/local/mysql/bin:$PATH' > /etc/profile.d/mysql.sh
```

8. 安全初始化
```bash
/user/local/mysql/bin/mysql_secure_installation
```




## 源码编译安装mariadb
可以在这里下载：[官方下载](https://downloads.mariadb.org/interstitial/mariadb-10.3.16/source/mariadb-10.3.16.tar.gz/from/http%3A//mirrors.accretive-networks.net/mariadb/)
>cmake 编译安装
cmake的重要特性之一是其独立于源码(out-of-source)的编译功能，即编译工作可以在另一个指定的目录中而非源码目录中进行，这可以保证源码目录不受任何一次编译的影响，因此在同一个源码树上可以进行多次不同的编译，如针对于不同平台编译
编译选项:https://dev.mysql.com/doc/refman/5.7/en/source-configuration-options.html

1. 安装包
```bash
yum install bison bison-devel zlib-devel libcurl-devel libarchive-devel boost-devel gcc gcc-c++ cmake ncurses-devel gnutls-devel libxml2-devel openssl-devel libevent-devel libaio-devel  libdb-cxx-devel
```
2. 做准备用户和数据目录
```bash
useradd -r -s /sbin/nologin -d /data/mysql mysql
mkdir /data/mysql
chown mysql.mysql /data/mysql

wget http://192.168.99.1/mysql/mariadb-10.2.25.tar.gz
tar xvf mariadb-10.2.25.tar.gz
```


3. cmake编译
建议内存分配>=2G，核心>=4。
```bash
[root]$ mkdir -p /app/mysql
[root]$ cd mariadb-10.2.25/
```
```bash
[root]$ cmake . \
-DCMAKE_INSTALL_PREFIX=/app/mysql/ \
-DMYSQL_DATADIR=/data/mysql/ \
-DSYSCONFDIR=/etc/ \
-DMYSQL_USER=mysql \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DWITH_ARCHIVE_STORAGE_ENGINE=1 \
-DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
-DWITH_PARTITION_STORAGE_ENGINE=1 \
-DWITHOUT_MROONGA_STORAGE_ENGINE=1 \
-DWITH_DEBUG=0 \
-DWITH_READLINE=1 \
-DWITH_SSL=system \
-DWITH_ZLIB=system \
-DWITH_LIBWRAP=0 \
-DENABLED_LOCAL_INFILE=1 \
-DMYSQL_UNIX_ADDR=/data/mysql/mysql.sock \
-DDEFAULT_CHARSET=utf8 \
-DDEFAULT_COLLATION=utf8_general_ci
```
```bash
[root]$ make -j 4 && make -j 4 install
```
提示：如果出错，需要执行`rm -f CMakeCache.txt`，再重新make

4. 准备环境变量
```bash
echo 'PATH=/app/mysql/bin:$PATH' > /etc/profile.d/mysql.sh
. /etc/profile.d/mysql.sh
```
5. 生成数据库文件
```bash
cd /app/mysql/
scripts/mysql_install_db --datadir=/data/mysql/ --user=mysql
```
6. 准备配置文件
```bash
cp /app/mysql/support-files/my-huge.cnf /etc/my.cnf
```
7. 准备启动脚本
```bash
cp /app/mysql/support-files/mysql.server /etc/init.d/mysqld
```
8. 启动服务
```bash
chkconfig --add mysqld && service mysqld start
```
9. PATH路径
```bash
echo PATH='/user/local/mysql/bin:$PATH' > /etc/profile.d/mysql.sh
```
10. 安全初始化
```bash
/user/local/mysql/bin/mysql_secure_installation
```

# MariaDB多实例实验：
## yum源安装的多实例

1. yum源安装MariaDB(见上面第一个实验)
```bash
yum install MariaDB-server -y
```

2. 创建⽂件夹，将多实例分开。
```bash
[centos]$ mkdir -p /usr/local/mysql/330{6,7,8}/{data,etc,socket,bin,log,pid}

#查看下
[centos]$ tree /usr/local/mysql/
/usr/local/mysql/
├── 3306
│   ├── bin
│   ├── data
│   ├── etc
│   ├── log
│   ├── pid
│   └── socket
├── 3307
│   ├── bin
│   ├── data
│   ├── etc
│   ├── log
│   ├── pid
│   └── socket
└── 3308
    ├── bin
    ├── data
    ├── etc
    ├── log
    ├── pid
    └── socket
```

3. 给创建的文件赋予权限
```bash
[centos]$ chown -R mysql.mysql /usr/local/mysql/
[centos]$ ll /usr/local/mysql/
total 0
drwxr-xr-x 8 mysql mysql 76 Jul  4 09:02 3306
drwxr-xr-x 8 mysql mysql 76 Jul  4 09:02 3307
drwxr-xr-x 8 mysql mysql 76 Jul  4 09:02 3308
```

4. 分别为3个MariaDB实例创建初始化数据
```bash 
[centos]$ mysql_install_db --user=mysql --datadir=/usr/local/mysql/3306/data/
Installing MariaDB/MySQL system tables in '/usr/local/mysql/3306/data/' ...
OK

[centos]$ mysql_install_db --user=mysql --datadir=/usr/local/mysql/3307/data/
Installing MariaDB/MySQL system tables in '/usr/local/mysql/3307/data/' ...
OK

[centos]$ mysql_install_db --user=mysql --datadir=/usr/local/mysql/3308/data/
Installing MariaDB/MySQL system tables in '/usr/local/mysql/3308/data/' ...
OK

```

5. 修改配置文件
```bash
[centos]$ vim /usr/local/mysql/3306/etc/my.cnf
#复制下面的配置
[client]
port = 3306
socket = /usr/local/mysql/3306/socket/mysql.sock
[mysqld]
datadir = /usr/local/mysql/3306/data/
port = 3306
socket = /usr/local/mysql/3306/socket/mysql.sock
log-error = /usr/local/mysql/3306/log/mariadb.log
pid-file = /usr/local/mysql/3306/pid/mariadb.pid
skip-external-locking
key_buffer_size = 384M
max_allowed_packet = 1M
table_open_cache = 512
sort_buffer_size = 2M
read_buffer_size = 2M
read_rnd_buffer_size = 8M
myisam_sort_buffer_size = 64M
thread_cache_size = 8
query_cache_size = 32M
thread_concurrency = 8
log-bin=mysql-bin
server-id = 1
[mysqldump]
quick
max_allowed_packet = 16M
[mysql]
no-auto-rehash
[myisamchk]
key_buffer_size = 256M
sort_buffer_size = 256M
read_buffer = 2M
write_buffer = 2M
[mysqlhotcopy]
interactive-timeout

#
# include all files from the config directory
#
!includedir /etc/my.cnf.d
```

6. 其它2个实例也是一样修改，注意端口号
```bash
[centos]$ cp /usr/local/mysql/3306/etc/my.cnf /usr/local/mysql/3307/etc/my.cnf
[centos]$ cp /usr/local/mysql/3306/etc/my.cnf /usr/local/mysql/3308/etc/my.cnf
[centos]$ sed -i 's/3306/3307/' /usr/local/mysql/3307/etc/my.cnf
[centos]$ sed -i 's/3306/3308/' /usr/local/mysql/3308/etc/my.cnf
```

7. 编写服务启动脚本
```bash
[centos]$ vim /usr/local/mysql/3306/bin/mysqld
#!/bin/bash
#chkconfig: 345 80 2
port=3306
mysql_user="root"
mysql_basedir="/usr/local/mysql"
mysql_sock="${mysql_basedir}/${port}/socket/mysql.sock"
function_start_mysql()
{
if [ ! -e "$mysql_sock" ];then
printf "Starting MySQL...\n"
mysqld_safe --defaults-file=${mysql_basedir}/${port}/etc/my.cnf &> /dev/null &
else
printf "MySQL is running...\n"
exit
fi
}
function_stop_mysql()
{
if [ ! -e "$mysql_sock" ];then
printf "MySQL is stopped...\n"
exit
else
printf "Stoping MySQL...\n"
mysqladmin -u ${mysql_user} -p${mysql_pwd} -S ${mysql_sock} shutdown
fi
}
function_restart_mysql()
{
printf "Restarting MySQL...\n"
function_stop_mysql
sleep 2
function_start_mysql
}
case $1 in
start)
function_start_mysql
;;
stop)
function_stop_mysql
;;
restart)
function_restart_mysql
;;
*)
printf "Usage: ${mysql_basedir}/${port}/bin/mysqld {start|stop|restart}\n"
esac


#给个755权限
[centos]$ chmod 755 /usr/local/mysql/3306/bin/mysqld
```

7. 给其它2个实例也编写服务启动脚本(复制修改下就可以了)
```bash
[centos]$ cp /usr/local/mysql/3306/bin/mysqld /usr/local/mysql/3307/bin/mysqld
[centos]$ cp /usr/local/mysql/3306/bin/mysqld /usr/local/mysql/3308/bin/mysqld

[centos]$ sed -i 's/3306/3307/' /usr/local/mysql/3307/bin/mysqld
[centos]$ sed -i 's/3306/3308/' /usr/local/mysql/3308/bin/mysqld
```

8. 启动服务
```bash
#启动3306端口
[centos]$ /usr/local/mysql/3306/bin/mysqld start
Starting MySQL...
#启动3307端口
[centos]$ /usr/local/mysql/3307/bin/mysqld start
Starting MySQL...
#启动3308端口
[centos]$ /usr/local/mysql/3308/bin/mysqld start
Starting MySQL...
#查看启动的端口
[centos]$ ss -ntl
State    Recv-Q Send-Q   Local Address:Port   Peer Address:Port     
...
LISTEN     0      80          :::3306                    :::*
LISTEN     0      80          :::3307                    :::*
LISTEN     0      80          :::3308                    :::*
...
```


9. 启动Mysql
```bash
#这里要注意了，如果直接用mysql是启动不了的。要加上套接字的路径
#要启动哪个端口的实例就附上那个路径
[root@localhost ~]$ mysql -S /usr/local/mysql/3307/socket/mysql.sock
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190704093050150.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

## 二进制安装的多实例
注意：这里跟二进制安装的时候还是有点区别的，所以这里从头说起：
注意：**下面实验中，/usr/local/mysql目录是二进制安装的目录，/usr/local/mysql_multi是多实例的目录**，请多留意

0. 准备二进制程序
可以在这里下载：[官方下载](https://downloads.mariadb.org/interstitial/mariadb-10.3.16/bintar-linux-x86_64/mariadb-10.3.16-linux-x86_64.tar.gz/from/http%3A//mirrors.accretive-networks.net/mariadb/)

1. 这里还需要一个包
```bash
[centos]$ yum -y install libaio
```

2. 导文件到虚拟机里，解压到`/usr/local`
```bash
[centos]$ tar xf mariadb-10.2.25-linux-x86_64.tar.gz -C /usr/local
[centos]$ cd /usr/local
###创建软连接
[centos]$ ln -s mariadb-10.2.25-linux-x86_64 mysql
```

3. 准备用户
```bash
[centos]$ groupadd -r -g 306 mysql
[centos]$ useradd -r -g 306 -u 306 -d /data/mysql -s /sbin/nologin mysql
```         

4. 更改目录的权限
```bash
[centos]$ chown -R root:mysql /usr/local/mysql/
```

5. 准备数据目录，建议使用逻辑卷
```bash
[centos]$ mkdir -p /data/mysql
[centos]$ chown -R mysql:mysql /data/mysql
```

**下面开始多实例部分了**

6. 创建数据库文件，
```bash
[centos]$ mkdir -p /usr/local/mysql_multi/330{6,7,8}/{data,etc,socket,bin,log,pid}
[centos]$ chown -R mysql.mysql /usr/local/mysql_multi/
[centos]$ cd /usr/local/mysql/
```

7. 分别为3个MariaDB实例创建初始化数据
```bash
[centos]$ scripts/mysql_install_db --user=mysql --datadir=/usr/local/mysql_multi/3306/data/
Installing MariaDB/MySQL system tables in '/usr/local/mysql_multi/3306/data/' ...
OK

[centos]$ scripts/mysql_install_db --user=mysql --datadir=/usr/local/mysql_multi/3307/data/
Installing MariaDB/MySQL system tables in '/usr/local/mysql_multi/3307/data/' ...
OK

[centos]$ scripts/mysql_install_db --user=mysql --datadir=/usr/local/mysql_multi/3308/data/
Installing MariaDB/MySQL system tables in '/usr/local/mysql_multi/3307/data/' ...
OK
```

8. 修改配置文件
```bash
[centos]$ cp /usr/local/mysql/support-files/my-huge.cnf  /usr/local/mysql_multi/3306/etc/my.cnf

[centos]$ vim /usr/local/mysql_multi/3306/etc/my.cnf
#复制下面的配置
[client]
port        = 3306
socket      = /usr/local/mysql_multi/3306/socket/mysql.sock
# The MySQL server
[mysqld]
datadir=/usr/local/mysql_multi/3306/data/
port = 3306
socket = /usr/local/mysql_multi/3306/socket/mysql.sock
log-error = /usr/local/mysql/3306/log/mariadb.log
pid-file = /usr/local/mysql/3306/pid/mariadb.pid
skip-external-locking
key_buffer_size = 384M
max_allowed_packet = 1M
table_open_cache = 512
sort_buffer_size = 2M
read_buffer_size = 2M
read_rnd_buffer_size = 8M
myisam_sort_buffer_size = 64M
thread_cache_size = 8
query_cache_size = 32M
thread_concurrency = 8
log-bin=mysql-bin
server-id = 1
[mysqldump]
quick
max_allowed_packet = 16M
[mysql]
no-auto-rehash
[myisamchk]
key_buffer_size = 256M
sort_buffer_size = 256M
read_buffer = 2M
write_buffer = 2M
[mysqlhotcopy]
interactive-timeout

```

9. 其它2个实例也是一样修改，注意端口号
```bash
[centos]$ cp /usr/local/mysql_multi/3306/etc/my.cnf /usr/local/mysql_multi/3307/etc/my.cnf
[centos]$ cp /usr/local/mysql_multi/3306/etc/my.cnf /usr/local/mysql_multi/3308/etc/my.cnf
[centos]$ sed -i 's/3306/3307/' /usr/local/mysql_multi/3307/etc/my.cnf
[centos]$ sed -i 's/3306/3308/' /usr/local/mysql_multi/3308/etc/my.cnf
```

10. 编写服务启动脚本
```bash
[centos]$ vim /usr/local/mysql_multi/3306/bin/mysqld
#!/bin/bash
#chkconfig: 345 80 2
port=3306
mysql_user="root"
mysql_basedir="/usr/local/mysql_multi"
mysql_sock="${mysql_basedir}/${port}/socket/mysql.sock"
function_start_mysql()
{
if [ ! -e "$mysql_sock" ];then
printf "Starting MySQL...\n"
mysqld_safe --defaults-file=${mysql_basedir}/${port}/etc/my.cnf &> /dev/null &
else
printf "MySQL is running...\n"
exit
fi
}

function_stop_mysql()
{
if [ ! -e "$mysql_sock" ];then
printf "MySQL is stopped...\n"
exit
else
printf "Stoping MySQL...\n"
mysqladmin -u ${mysql_user} -p${mysql_pwd} -S ${mysql_sock} shutdown
fi
}

function_restart_mysql()
{
printf "Restarting MySQL...\n"
function_stop_mysql
sleep 2
function_start_mysql
}

case $1 in
start)
function_start_mysql
;;
stop)
function_stop_mysql
;;
restart)
function_restart_mysql
;;
*)
printf "Usage: ${mysql_basedir}/${port}/bin/mysqld {start|stop|restart}\n"
esac


#给个755权限
[centos]$ chmod 755 /usr/local/mysql_multi/3306/bin/mysqld
```

11. 给其它2个实例也编写服务启动脚本(复制修改下就可以了)
```bash
[centos]$ cp /usr/local/mysql_multi/3306/bin/mysqld /usr/local/mysql_multi/3307/bin/mysqld
[centos]$ cp /usr/local/mysql_multi/3306/bin/mysqld /usr/local/mysql_multi/3308/bin/mysqld

[centos]$ sed -i 's/3306/3307/' /usr/local/mysql_multi/3307/bin/mysqld
[centos]$ sed -i 's/3306/3308/' /usr/local/mysql_multi/3308/bin/mysqld
```

12. 添加环境变量
```bash
[centos]$ echo PATH='/usr/local/mysql/bin:$PATH' >> /etc/profile.d/mysql.sh
[centos]$ source /etc/profile.d/mysql.sh
```

13. 启动服务
```bash
#启动3306端口
[centos]$ /usr/local/mysql_multi/3306/bin/mysqld start
Starting MySQL...
#启动3307端口
[centos]$ /usr/local/mysql_multi/3307/bin/mysqld start
Starting MySQL...
#启动3308端口
[centos]$ /usr/local/mysql_multi/3308/bin/mysqld start
Starting MySQL...
#查看启动的端口
[centos]$ ss -ntl
State    Recv-Q Send-Q   Local Address:Port   Peer Address:Port     
...
LISTEN     0      80          :::3306                    :::*
LISTEN     0      80          :::3307                    :::*
LISTEN     0      80          :::3308                    :::*
...
```


14. 启动Mysql
```bash
#这里要注意了，如果直接用mysql是启动不了的。要加上套接字的路径
#要启动哪个端口的实例就附上那个路径
[root@localhost ~]$ mysql -S /usr/local/mysql_multi/3307/socket/mysql.sock
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190704104911733.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)
