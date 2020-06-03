#!/usr/bin/env bash


sudo service mysql start
sudo service mysql restart
mysql -u root -p


# innodb
show engines;

### ---
### 安装 ---》
### ---
sudo apt-get install mysql-server
sudo service mysql start
#报错：
# * Starting MySQL database server mysqld
#No directory, logging in with HOME=/
# 解决方法：
# 停止mysql服务
sudo service mysql stop
# 修改权限
sudo usermod -d /var/lib/mysql/ mysql
# 重启mysql服务
sudo service mysql start
#
mysql -u root -p
# 报错：
# ERROR 1698 (28000): Access denied for user 'root'@'localhost'
sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf
# 进入到这个配置文件，然后在这个配置文件中的[mysqld]这一块的最后加入
skip-grant-tables
# 然后保存退出： ctrl+O，回车，再ctrl+X
# 再重新启动mysql：
service mysql restart
# 报错：
# su: Authentication failure
# 解决方法：
# 先进入到root用户：
su root
mysql -u root -p
# 遇见输入密码的提示直接回车即可，进入mysql后，分别执行下面三句话：
use mysql;   # 回车
update user set authentication_string=password("你的密码") where user="root";  # 回车
flush privileges;  # 回车
# 然后退出mysql：
quit
# 重新进入到mysqld.cnf文件中去把刚开始加的 skip-grant-tables 这条语句给注释掉：
sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf
mysql -u root -p



