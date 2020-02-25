@[TOC](目录)


# 实验：实现基于文件验证的vsftpd虚拟用户
**一、创建用户数据库文件**
```sh
#创建帐号密码
[101]$ vim /etc/vsftpd/vusers.txt
wang  #帐号
123   #密码
chen  #帐号
123   #密码

[101]$ cd /etc/vsftpd/
#从这个文件输出成db格式的数据库文件
[101]$ db_load -T -t hash -f vusers.txt vusers.db

#为了安全可以加这句
[101]$ chmod 600 vusers.db
```

**二、创建用户和访问FTP目录**
```sh
#创建用户，指定家目录
[101]$ useradd -d /data/ftproot -s /sbin/nologin test
#给他的家目录权限rw
[101]$ chmod a=rx /data/ftproot/
#创建子目录，用来上传下载
[101]$ mkdir /data/ftproot/upload
#设置有rwx权限给子目录
[101]$ setfacl -m u:test:rwx /data/ftproot/upload
```

**三、创建pam配置文件**
```sh

[101]$ vim /etc/pam.d/vsftpd.db
#写这2行，数据库路径不加后缀
auth required pam_userdb.so db=/etc/vsftpd/vusers
account required pam_userdb.so db=/etc/vsftpd/vusers
```

**四、指定pam配置文件**
```sh
[101]$ vim /etc/vsftpd/vsftpd.conf
#所有的用户都映射成下面那条写的用户
guest_enable=YES
#对，就是我，映射成我
guest_username=test
#数据库文件路径(相对)
pam_service_name=vsftpd.db
```

**五、SELinux设置：**

1. 禁用SELinux 
或者 
2. setsebool -P ftpd_full_access 1


**六、虚拟用户建立独立的配置文件**

1. 创建配置文件存放的路径
```sh
mdkir /etc/vsftpd/vusers.d/ 
```
2. 修改配置
```sh
vim /etc/vsftpd/vsftpd.conf
#添加这句
    user_config_dir=/etc/vsftpd/vusers.d/
```
3. 进入此目录
```sh
cd /etc/vsftpd/vusers.d/ 
```

4. 允许wang用户可读写，其它用户只读
```sh
vim wang 
#创建wang的配置文件   
    anon_upload_enable=YES
    anon_mkdir_write_enable=YES
    anon_other_write_enable=YES

vim chen 
#创建chen的配置文件
    anon_upload_enable=YES
    anon_mkdir_write_enable=YES
    anon_other_write_enable=YES
    local_root=/data/chen  #登录目录改变至指定的目录
```

5. 重启服务
```sh
systemctl restart vsftpd
```

- - - 

# 实验：实现基于MYSQL验证的vsftpd虚拟用户

>说明：本实验在两台CentOS主机上实现，一台做为FTP服务器，一台做数据库服务器

<table><td bgcolor='orange'> MariaDB服务器: 192.168.99.103 </td></table>

**1. 安装所需要包和包组：**

1. 在数据库服务器上安装
```sh
[103]$ yum –y install mariadb-server
[103]$ systemctl start mariadb.service
[103]$ systemctl enable mariadb
```

**2. 在数据库服务器上创建虚拟用户账号**
1.建立存储虚拟用户数据库和连接的数据库用户
```sh
mysql> CREATE DATABASE vsftpd;
mysql> SHOW DATABASES;
```

2. ftp服务和mysql不在同一主机：
```sh
mysql> GRANT SELECT ON vsftpd.* TO vsftpd@'%' IDENTIFIED BY '123';
```

3. ftp服务和mysql在同一主机：
```sh
mysql> GRANT SELECT ON vsftpd.* TO vsftpd@'%' IDENTIFIED BY '123';
mysql> FLUSH PRIVILEGES;
```

4. 准备相关表
```sh
mysql> USE vsftpd;
Mysql> SHOW TABLES;
mysql> CREATE TABLE users (
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
name CHAR(50) BINARY NOT NULL,
password CHAR(48) BINARY NOT NULL
);
mysql> DESC users;
```

5. 测试连接
```sh
[101]$ mysql -uvsftpd -h192.168.99.103 -p123
mysql> SHOW DATABASES;
mysql> quit
```

6. 添加虚拟用户
```sh
[103]$ mysql 
#根据需要添加所需要的用户，为了安全应该使用PASSWORD函数加密其密码后存储
mysql> USE vsftpd;
mysql> DESC users;
mysql> INSERT INTO users(name,password) values('wang',password('123'));
mysql> INSERT INTO users(name,password) values('chen',password('123'));
mysql> SELECT * FROM users;
```

<table><td bgcolor='orange'> vsftp服务器: 192.168.99.101 </td></table>

**一、 安装pam_mysql**
1. 编译安装,先安装环境
```sh
[101]$ yum -y install  gcc gcc-c++ mariadb-devel pam-devel vsftpd
```

2. 下载pam_mysql-0.7RC1.tar.gz
```sh
[101]$ wget ftp://192.168.99.1/Magedu37/files/sources/pam_mysql-0.7RC1.tar.gz
```
3. 解压
```sh
[101]$ tar xf pam_mysql-0.7RC1.tar.gz
```
4. 安装
```sh
[101]$ cd pam_mysql-0.7RC1/
[101]$ ./configure --with-pam-mods-dir=/lib64/security
[101]$ make && make install
```

**二、 在FTP服务器上配置vsftpd服务**
1. 在FTP服务器上建立pam认证所需文件
```sh
[101]$ vi /etc/pam.d/vsftpd.mysql 
#添加如下两行
auth required pam_mysql.so user=vsftpd passwd=123 host=192.168.99.103 db=vsftpd table=users usercolumn=name passwdcolumn=password crypt=2
account required pam_mysql.so user=vsftpd passwd=123 host=192.168.99.103 db=vsftpd table=users usercolumn=name passwdcolumn=password crypt=2
```
注意：参考README文档，选择正确的加密方式
crypt是加密方式，0表示不加密，1表示crypt(3)加密，2表示使用mysql password()函数加密，3表示md5加密，4表示sha1加密

**配置字段** | 说明
- | -
auth |表示认证
account | 验证账号密码正常使用
required | 表示认证要通过
pam_mysql.so |模块是默认的相对路径，是相对/lib64/security/路径而言，也可以写绝对路径；后面为给此模块传递的参数
user=vsftpd |为登录mysql的用户
passwd=magedu | 登录mysql的的密码
host=mysqlserver  |mysql服务器的主机名或ip地址
db=vsftpd  |指定连接msyql的数据库名称
table=users | 指定连接数据库中的表名
usercolumn=name | 当做用户名的字段
passwdcolumn=password | 当做用户名字段的密码
crypt=2 | 密码的加密方式为mysql password()函数加密


2. 建立相应用户和修改vsftpd配置文件，使其适应mysql认证
建立虚拟用户映射的系统用户及对应的目录
```sh
[101]$ useradd -s /sbin/nologin -d /data/ftproot vuser
[101]$ chmod 555 /data/ftproot  #centos7需除去ftp根目录的写权限
[101]$ mkdir /data/ftproot/{upload,pub}
[101]$ setfacl -m u:vuser:rwx /data/ftproot/upload
```

3. 修改配置
```sh
vim /etc/vsftpd/vsftpd.conf
#确保中已经启用了以下选项
anonymous_enable=YES

#添加下面两项
guest_enable=YES
guest_username=vuser

#修改下面一项，大约126行。
pam_service_name=vsftpd.mysql
```

4. 启动vsftpd服务
```sh
systemctl start vsftpd
```
5. 设置开机启动
```sh
chkconfig vsftpd on
systemctl enable vsftpd
```

6. 查看端口开启情况
```sh
netstat -tnlp |grep 21
#或
ss -tnlp | grep 21
```

**三、 Selinux相关设置：在FTP服务器上执行**
没有开启可跳过
```sh
restorecon -R /lib64/security
setsebool -P ftpd_connect_db 1
setsebool -P ftp_home_dir 1
chcon -R -t public_content_rw_t /var/ftproot/
```

**四、 测试：利用FTP客户端工具,以虚拟用户登录验证结果**
1. 在vsftp服务器上
```sh
tail  -f /var/log/secure
```
2. 测试的客户端上
```sh
yum -y install ftp
ftp 192.168.99.101
```
3. 连接上了
```sh
[102]$ ftp 192.168.99.101
Connected to 192.168.99.101 (192.168.99.101).
220 (vsFTPd 3.0.2)
Name (192.168.99.101:root): chen
331 Please specify the password.
Password:
230 Login successful.
Remote system type is UNIX.
Using binary mode to transfer files.
ftp> ls
227 Entering Passive Mode (192,168,99,101,182,64).
150 Here comes the directory listing.
drwxr-xr-x    2 0        0               6 Jul 28 07:49 pub
drwxrwxr-x    2 0        0               6 Jul 28 07:49 upload
226 Directory send OK.
ftp>
```
4. 101主机上(vsftp服务器)也有了日志
```sh
Jul 28 15:54:04 localhost polkitd[5380]: Registered Authentication Agent for unix-process:13770:75587 (system bus name :1.96 [/usr/bin/pkttyagent --notify-fd 5 --fallback], object path /org/freedesktop/PolicyKit1/AuthenticationAgent, locale en_US.UTF-8)
Jul 28 15:54:04 localhost polkitd[5380]: Unregistered Authentication Agent for unix-process:13770:75587 (system bus name :1.96, object path /org/freedesktop/PolicyKit1/AuthenticationAgent, locale en_US.UTF-8) (disconnected from bus)
```

**五、 在FTP服务器上配置虚拟用户具有不同的访问权限**
这个就跟实现基于文件验证的vsftpd虚拟用户一样了，

1. 配置vsftpd为虚拟用户使用配置文件目录
```sh
[101]$ vim /etc/vsftpd/vsftpd.conf
#在最后添加如下选项
user_config_dir=/etc/vsftpd/vsftpd.d
```

2. 创建所需要目录，并为虚拟用户提供配置文件
```sh
[101]$ mkdir /etc/vsftpd/vsftpd.d
[101]$ cd /etc/vsftpd/vsftpd.d
[101]$ touch wang chen
```

3. 配置虚拟用户的访问权限
虚拟用户对vsftpd服务的访问权限是通过匿名用户的相关指令进行的。如要让用户wang具有上传文件的权限，可修改/etc/vsftpd/vusers_config/wang文件，在里面添加如下选项并设置为YES即可,只读则设为NO
注意：需确保对应的映射用户对于文件系统有写权限
```sh
[101]$ vim /etc/vsftpd/vusers_config/wang
    anon_upload_enable=YES
    anon_mkdir_write_enable=YES
    anon_other_write_enable=YES
```

4. 给另一个用户给配置下
```sh
[101]$ vim /etc/vsftpd/vusers_config/chen
anon_upload_enable=YES
anon_mkdir_write_enable=YES
anon_other_write_enable=YES
local_root=/data/ftproot2   #登录目录改变至指定的目录
```

5. 给他创建个upload目录用来上传
```sh
mkdir -p /data/ftproot2/upload
setfacl -m u:vuser:rwx /data/ftproot2/upload
```


<table><td bgcolor='orange'> 客户端：192.168.99.110 </td></table>
测试成功
```sh
[110]$ ftp 192.168.99.101
Connected to 192.168.99.101 (192.168.99.101).
220 (vsFTPd 3.0.2)
Name (192.168.99.101:root): chen
331 Please specify the password.
Password:
230 Login successful.
Remote system type is UNIX.
Using binary mode to transfer files.
ftp> ls
227 Entering Passive Mode (192,168,99,101,60,128).
150 Here comes the directory listing.
-rw-r--r--    1 0        0               0 Jul 28 08:09 111111
drwxr-xr-x    2 0        0               6 Jul 28 07:49 pub
drwxrwxr-x    2 0        0               6 Jul 28 07:49 upload
226 Directory send OK.
ftp> quit
221 Goodbye.
```

```sh
[110]$ ftp 192.168.99.101
Connected to 192.168.99.101 (192.168.99.101).
220 (vsFTPd 3.0.2)
Name (192.168.99.101:root): chen
331 Please specify the password.
Password:
230 Login successful.
Remote system type is UNIX.
Using binary mode to transfer files.
ftp> ls
227 Entering Passive Mode (192,168,99,101,82,253).
150 Here comes the directory listing.
-rw-r--r--    1 0        0               0 Jul 28 08:09 222222
drwxrwxr-x    2 0        0               6 Jul 28 08:07 upload
226 Directory send OK.
ftp> quit
221 Goodbye.
```

- - - 

# 实验：实现NFS服务

<table><td bgcolor='orange'> NFS服务：192.168.99.101 </td></table>

1. 安装NFS
```sh
yum -y install nfs-utils
```
2. 启动服务
```sh
systemctl start nfs-server
systemctl enable nfs-server
```
3. 创建用来提供服务的目录
```sh
mkdir /nfsshare
```
4. 给权限
```sh
chown nfsnobody /nfsshare
```
5. 修改NFS配置
```sh
[101]$ vim /etc/exports
    /nfsshare desktopX(rw)
```
6. 加载配置
```sh
exporfs –r
```

<table><td bgcolor='orange'> 客户端：192.168.99.102 </td></table>

1. 创建目录，一会来挂载
```sh
mkdir /mnt/nfsshare
```
2. 挂载
```sh
mount serverX:/nfsshare /mnt/nfsshare
```

**下面是开机自动挂载**
3. 修改
```sh
[101]$ vim /etc/fstab
    nfsserver:/nfsshare /mnt/nfsshare nfs defaults 0 0
```
4. 自动读取配置挂载
```sh
mount -a
```