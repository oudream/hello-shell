[toc]

<center><font size=10>keepalived高可用集群实战项目</font></center>

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190810191537539.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)


需要准备17台虚拟机
- - -


@[TOC](目录)
- - -
# 客户端

1. 网卡配置：仅主机模式1
2. ip配置：
```bash
ip：192.168.88.100/24
gateway：192.168.88.254
dns：172.16.23.211
```

- - - 

# 路由器

1. 网卡配置：仅主机模式1(eth0) + 桥接模式(eth1)
ip配置：
```bash
eth0：192.168.88.254/24
eth1：172.16.23.254/24
```

2. 路由配置
```bash
route add default dev eth1
```
3. SNAT配置
```bash
iptables -t nat -A POSTROUTING -s 192.168.88.0/24 ! –d 192.168.88.0/24 -j SNAT --to-source 172.16.23.254
```
4. ip转发
```bash
echo "net.ipv4.ip_forward = 1" > /etc/sysctl.conf
sysctl -p
```
- - -

#  powerDNS

1. 网卡配置：桥接模式
2. ip配置：
```bash
ip: 172.16.23.211/24
```
3. 安装http + php + mariadb
```sh
yum install -y pdns pdns-backend-mysql httpd  php php-mysql php-mbstring mariadb-server

# 启动服务
systemctl start httpd
systemctl start mariadb

# 配置PowerDNS使用mariadb作为后台数据存储
sed -i '/^launch/s/^.*$/launch=gmysql\ngmysql-host=localhost\ngmysql-port=3306\ngmysql-dbname=powerdns\ngmysql-user=powerdns\ngmysql-password=123/' /etc/pdns/pdns.conf

# 创建数据库和帐号给powerDNS用
mysql

create database powerdns;
grant all privileges on powerdns.* to powerdns@localhost identified by "123";

# 还有powerdns的数据库
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

# 启动服务
systemctl start pdns
systemctl enable pdns

# 安装httpd和php相关包
yum -y install  php-devel php-gd php-mcrypt php-imap php-ldap  php-odbc php-pear php-xml php-xmlrpc php-mcrypt php-mhash gettext

# 启动服务
systemctl restart httpd

# 下载poweradmin程序，
cd /var/www/html
wget http://downloads.sourceforge.net/project/poweradmin/poweradmin-2.1.7.tgz

# 解压缩到相应目录
tar xvf poweradmin-2.1.7.tgz
mv poweradmin-2.1.7 poweradmin

# 设置下权限
setfacl -Rm u:apache:rwx poweradmin
```

4. 访问网页安装向导地址：
http://172.16.23.211/poweradmin/install/
下一步。下一步
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190809164101343.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

- - - 
5. 根据你前面写的帐号密码来
![在这里插入图片描述](https://img-blog.csdnimg.cn/2019080916413422.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)
 - -  -
6. 如图
![在这里插入图片描述](https://img-blog.csdnimg.cn/2019080916424693.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

- - -



7. 按照下面页面说明，在数据库中创建用户并授权，然后再下一步

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190809164335197.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190809164404448.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

- - - 

8. 按下面页面说明，修改config.in.php文件内容,要先把原来的改名
```sh
mv /var/www/html/poweradmin/inc/config-me.inc.php /var/www/html/poweradmin/inc/config.inc.php
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190809164713961.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)



- - -

9. 安装完毕后，删除install目录

```bash
rm -rf /var/www/html/poweradmin/install/
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190809165015270.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)
- - -

10. 登录http://172.16.23.211/poweradmin/
```sh
username：admin
password：123
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190809165043637.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

- - - 

1. 来添加个master zone
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190809165302661.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

- - - 

2. 准备给这个zone添加记录
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190809165338559.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

- -  -

3. 添加A记录，指向172.16.23.200
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190809165529842.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)


4. 用前面的客户端测试下,如果不同就要检查下你的DNS有没有指向172.16.23.211这个powerDNS了
```bash
ping bbs.jibill.com
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190809165630497.png)

- - -

# 防火墙 

1. 网卡配置：仅主机模式2(eth0) + 桥接模式(eth1)
2. ip配置：
仅主机模式2
```bash
#这里注意了，192.168.99.254就是右边所有主机的网关
eth0：192.168.99.254/24
eth1：172.16.23.200/24
```

3. ip转发
```bash
echo "net.ipv4.ip_forward = 1" > /etc/sysctl.conf
sysctl -p
```

4. 配置DNAT
```bash
iptables -t nat -A PREROUTING -d 172.16.23.200/24 -p tcp --dport 80 -j DNAT --to-destination 192.168.0.100
```
5. 配置SNAT
```bash
iptables -t nat -A POSTROUTING -s 192.168.99.0/24 ! –d 192.168.99.0/24 -j SNAT --to-source 172.16.23.200
```
6. 添加VIP路由
```bash
route add -net 192.168.0.100/24 dev eth0
```
7. 保存配置
```bash
iptables-save > /etc/iptables/nat.rules
vim /etc/rc.d/rc.local
    iptables-restore < /etc/iptables/nat.rules

chmod +x /etc/rc.d/rc.local
```

- - - 
# 时间同步服务器 

1. ip配置：
```bash
ip：192.168.99.105
gateway: 192.168.99.254
```

2. 安装与启动chrony
```bash
yum install chrony
systemctl start  chronyd
systemctl enable chronyd
```

3. 配置时间同步源
```bash
cat /etc/chrony.conf

# l国内大学的时间源
 3 server s1a.time.edu.cn iburst
 4 server s1b.time.edu.cn iburst
 5 server s1c.time.edu.cn iburst
...
25 allow 192.168.99.0/24
...
28 local stratum 10
```
4. 重启服务生效
```bash
systemctl restart chronyd
```

5. 显示当前chronyd正在访问的时间源的信息
```bash
chronyc sources -v
```

- - - 

# keepalived + LVS集群实现web服务高可用

0. ip配置
```bash
# ka1配置
ip：192.168.99.106
gateway: 192.168.99.254

# ka2配置
ip：192.168.99.107
gateway: 192.168.99.254
```

1. ka1和ka2配置时间同步
```bash
yum -y install chrony
sed -i -e '1i\server 192.168.99.105 iburst' -e '/^server/d'  /etc/chrony.conf
systemctl restart chronyd
```

1. 在ka1和ka2上都安装ipvsadm
```bash
yum -y install ipvsadm keepalived mailx
```
2. 设置主机名
```bash
# 192.168.99.106设置为ka1
hostnamectl set-hostname "ka1"

# 192.168.99.107设置为ka2
hostnamectl set-hostname "ka2"
```

3. ka1和ka2的邮箱配置
```bash
echo 'set from=417060833@qq.com' >> /etc/mail.rc
echo 'set smtp=smtp.qq.com' >> /etc/mail.rc
echo 'set smtp-auth=login' >> /etc/mail.rc
echo 'set smtp-auth-user=你的QQ邮箱@qq.com' >> /etc/mail.rc
echo 'set smtp-auth-password=你的授权码' >> /etc/mail.rc
```
测试邮箱的配置
```bash
echo "内容" | mail -v -s "标题"  你的邮箱
```

4. 在ka1创建脚本
```bash
[106]$ cat notify.sh
#!/bin/bash
#
#***********************************************************
#Author:                Jibill Chen
#QQ:                    417060833
#Date:                  2019-08-09
#FileName：             notify.sh
#URL:                   http://www.jibiao.work
#Description：          The test script
#**********************************************************
vip="192.168.0.100"
EMAIL="417060833@qq.com"


notify() {
    mailsubject="`hostname` to be $1: $vip floating"
    mailbody="`date '+%F %H:%M:%S'`: vrrp transition, `hostname` changed to be $1"
    echo $mailbody | mail -s "$mailsubject" $EMAIL
}
rs_notify() {
    mailsubject="Real server: $2 to be $1"
    mailbody="`date '+%F %H:%M:%S'`: Real server: $2 changed to be $1"
    echo $mailbody | mail -s "$mailsubject" $EMAIL

}

case "$1" in
    master)
        notify master
        exit 0
            ;;
    backup)
        notify backup
        exit 0
                 ;;
    rsup)
        rs_notify up $2
        exit 0
                ;;
        rsdown)
                rs_notify down $2
                exit 0
                ;;
    *)
        echo 'Usage: `basename $0` {master|backup|fault}'
        exit 1
            ;;
esac
```
5. 设置好权限，传给ka2
```bash
chmod +x /etc/keepalived/notify.sh
scp /etc/keepalived/notify.sh 192.168.99.107:/etc/keepalived/
```

6. ka2的keepalived配置
```bash
cat /etc/keepalived/keepalived.conf
#配置如下
! Configuration File for keepalived

global_defs {
   notification_email {
       root@localhost
   }
   notification_email_from root@localhost
   smtp_server 127.0.0.1
   smtp_connect_timeout 30
   router_id ka1
   vrrp_skip_check_adv_addr
#   vrrp_strict
   vrrp_garp_interval 0
   vrrp_gna_interval 0
}

vrrp_instance VI_1 {
    state MASTER
    interface eth0
    virtual_router_id 11
    priority 100
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass 1111
    }
        unicast_src_ip 192.168.99.106  # ka1的ip
        unicast_peer {
        192.168.99.107  # ka2的ip
        }
    virtual_ipaddress {
    192.168.0.100 dev eth0 label eth0:1  # vip
    }
    notify_master "/etc/keepalived/notify.sh master"  #切换为主时脚本
    notify_backup "/etc/keepalived/notify.sh backup"  #切换为backup时脚本
}
virtual_server 192.168.0.100 80 {  # vip + port
        delay_loop 3
        lb_algo wrr
        lb_kind DR
        protocol TCP
        real_server 192.168.99.108 80 {  # web_A
            notify_up "/etc/keepalived/notify.sh rsup web_A"       #RS上线通知脚本
            notify_down "/etc/keepalived/notify.sh rsdown web_A"      #RS下线通知脚本
            weight 1
            TCP_CHECK {
            connect_port 80
                    connect_timeout 4
                    retry 3
                    delay_before_retry 3
            }
        }
        real_server 192.168.99.109 80 {  # web_B
            notify_up "/etc/keepalived/notify.sh rsup web_B"       #RS上线通知脚本
            notify_down "/etc/keepalived/notify.sh rsdown web_B"      #RS下线通知脚本
            weight 1
            TCP_CHECK {
            connect_port 80
            connect_timeout 50
            retry 3
            delay_before_retry 3
            }
        }
}                 
```

5. ka2的配置
```bash
cat /etc/keepalived/keepalived.conf
#配置如下
! Configuration File for keepalived

global_defs {
   notification_email {
       root@localhost
   }
   notification_email_from root@localhost
   smtp_server 127.0.0.1
   smtp_connect_timeout 30
   router_id ka2
   vrrp_skip_check_adv_addr
#   vrrp_strict
   vrrp_garp_interval 0
   vrrp_gna_interval 0
}

vrrp_instance VI_1 {
    state BACKUP
    interface eth0
    virtual_router_id 11
    priority 80
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass 1111
    }
        unicast_src_ip 192.168.99.107  # ka2的ip
        unicast_peer {
        192.168.99.106  # ka1的ip
        }
    virtual_ipaddress {
    192.168.0.100 dev eth0 label eth0:1  # vip
    }
    notify_master "/etc/keepalived/notify.sh master"  
    notify_backup "/etc/keepalived/notify.sh backup"  
}
virtual_server 192.168.0.100 80 {  # vip + port
        delay_loop 3
        lb_algo wrr
        lb_kind DR
        protocol TCP
        real_server 192.168.99.108 80 {  # web_A
            notify_up "/etc/keepalived/notify.sh rsup web_A"
            notify_down "/etc/keepalived/notify.sh rsdown web_A"   
            weight 1
            TCP_CHECK {
            connect_port 80
                    connect_timeout 4
                    retry 3
                    delay_before_retry 3
            }
        }
        real_server 192.168.99.109 80 {  # web_B
            notify_up "/etc/keepalived/notify.sh rsup web_B"
            notify_down "/etc/keepalived/notify.sh rsdown web_B" 
            weight 1
            TCP_CHECK {
            connect_port 80
            connect_timeout 50
            retry 3
            delay_before_retry 3
            }
        }
}                 
```
6. 启动ka1与ka2
```bash
systemctl restart keepalived
```

- - -

# 配置web_A与web_B
0. ip配置
```bash
# web_A: 
ip：192.168.99.108
gateway: 192.168.99.254

#web_B: 
ip：192.168.99.109
gateway: 192.168.99.254
```

1. ka1和ka2配置时间同步
```bash
yum -y install chrony
sed -i -e '1i\server 192.168.99.105 iburst' -e '/^server/d'  /etc/chrony.conf
systemctl restart chronyd
```

2. 在web_A与web_B安装httpd与LAMP环境并启动
```bash
yum -y install httpd mariadb php php-mysql php-mbstring
systemctl restart httpd
```

测试页面
```bash
#web_A
echo "testA" > /var/www/html/a.html

#web_B
echo "testB" > /var/www/html/a.html
```

3. 设置arp
```bash
echo "net.ipv4.conf.lo.arp_ignore = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.arp_ignore = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.lo.arp_announce = 2" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.arp_announce = 2" >> /etc/sysctl.conf
sysctl -p
```
4. 设置vip
```bash
cd /etc/sysconfig/network-scripts/

vim ifcfg-lo:0
#添加下面内容
DEVICE=lo:0
BOOTPROTO=static
BROADCAST=192.168.0.255
NETWORK=192.168.0.0
IPADDR=192.168.0.100  #这个是VIP
NETMASK=255.255.255.255
ONBOOT=yes
TYPE=Ethernet

#重启
systemctl restart network
```

5. 好了，测试下吧。用客户端。如果失败了你就回去检查吧
```bash
[Client]$ curl 172.16.23.200/a.html
testA

[Client]$ curl 172.16.23.200/a.html
testB
```
别忘了web_B也要配置一样的

- - - 

# 实验：MHA

1. 实验环境：
1 台MHA_Manage主机：192.168.99.117
1 台Master主机：192.168.99.114
2 台slave主机：192.168.99.115~116


## Master主机：192.168.99.114
0. 网络配置
```bash
ip: 192.168.99.114
gateway: 192.168.99.254
```
1. 时间同步
```bash
yum -y install chrony
sed -i -e '1i\server 192.168.99.105 iburst' -e '/^server/d'  /etc/chrony.conf
systemctl restart chronyd
```


2. 安装mariadb-server并修改mariadb配置文件
```bash
yum -y install mariadb-server
sed -i '/\[mysqld\]/a\log-bin\nserver_id=114\nskip_name_resolve=1' /etc/my.cnf

#启动
systemctl restart mariadb
```

3.  创建连接需要的帐号
```bash
mysql

#创建复制用帐号
MariaDB [(none)]> grant replication slave on *.* to repluser@'%' identified by '123';

#创建管理用帐号
MariaDB [(none)]> grant all on *.* to mhauser@'192.168.99.%'identified by'123';

#proxySQL监控的帐号
MariaDB [(none)]> grant replication client on *.* to monitor@'192.168.99.%' identified by'123';
#proxySQL访问的帐号
MariaDB [(none)]> grant all on *.* to sqluser@'%' identified by '123';

#discuz帐号和数据库
MariaDB [(none)]> create database dzdb;
MariaDB [(none)]> grant all privileges on dzdb.* to dzuser@'192.168.99.%' identified by "123";
```

- - -

## slave主机：192.168.99.115
0. 网络配置
```bash
ip: 192.168.99.115
gateway: 192.168.99.254
```
1. 时间同步
```bash
yum -y install chrony
sed -i -e '1i\server 192.168.99.105 iburst' -e '/^server/d'  /etc/chrony.conf
systemctl restart chronyd
```

2. 安装修改mariadb配置文件
```bash
yum -y install mariadb-server
sed -i '/\[mysqld\]/a\log-bin\nserver_id=115\nread_only\nskip_name_resolve=1\nrelay_log_purge=0' /etc/my.cnf
#这里：关闭`relay_log_purge`是为了不让mysql自动清除中继日志
#启动
systemctl restart mariadb
```


3. 连接到主服务器
```bash
mysql

MariaDB [(none)]> CHANGE MASTER TO 
MASTER_HOST='192.168.99.114', 
MASTER_PORT=3306,
MASTER_USER='repluser', 
MASTER_PASSWORD='123', 
MASTER_LOG_FILE='mariadb-bin.000001', 
MASTER_LOG_POS=245;

#启动
MariaDB [(none)]> start slave ;
```

- - -

## 另一个slave主机：192.168.99.116
0. 网络配置
```bash
ip: 192.168.99.116
gateway: 192.168.99.254
```
1. 时间同步
```bash
yum -y install chrony
sed -i -e '1i\server 192.168.99.105 iburst' -e '/^server/d'  /etc/chrony.conf
systemctl restart chronyd
```
2. 安装并修改mariadb配置文件
```bash
yum -y install mariadb-server
sed -i '/\[mysqld\]/a\log-bin\nserver_id=116\nread_only\nskip_name_resolve=1\nrelay_log_purge=0' /etc/my.cnf

#启动
systemctl restart mariadb
```

3. 连接到主服务器
```bash
mysql

MariaDB [(none)]> CHANGE MASTER TO 
MASTER_HOST='192.168.99.114', 
MASTER_PORT=3306,
MASTER_USER='repluser', 
MASTER_PASSWORD='123', 
MASTER_LOG_FILE='mariadb-bin.000001', 
MASTER_LOG_POS=245;

#启动
MariaDB [(none)]> start slave ;
```

- - -

## MHA_Manage主机
0. 网络配置
```bash
ip: 192.168.99.117
gateway: 192.168.99.254
```
1. 时间同步
```bash
yum -y install chrony
sed -i -e '1i\server 192.168.99.105 iburst' -e '/^server/d'  /etc/chrony.conf
systemctl restart chronyd
```

2. 准备2个安装包
`mha4mysql-manager` 和 `mha4mysql-node`

>链接：https://pan.baidu.com/s/1lu0HPQDanJRotSZoVoPlHw 
提取码：pvt4 


3. 在Manager主机（192.168.99.101）节点上安装两个包，注意，yum源需要EPEL
```bash
yum -y localinstall mha4mysql-node-0.56-0.el6.noarch.rpm
yum -y localinstall mha4mysql-manager-0.56-0.el6.noarch.rpm
```

4. 在被管理节点(Master与2台slave)安装，注意，yum源需要EPEL
```bash
yum -y localinstall mha4mysql-node-0.56-0.el6.noarch.rpm
```

5. 在管理节点建立配置文件
```bash
#新建目录，用于存放配置文件
mkdir /etc/mastermha/
#创建mha的工作目录
mkdir -p /data/mastermha/app1

#配置文件可能不存在，直接新建,注意把注释去了
vim /etc/mastermha/app1.cnf

    [server default]
    user=mhauser   #管理帐号
    password=123   #密码
    manager_workdir=/data/mastermha/app1/  #本地工作目录
    manager_log=/data/mastermha/app1/manager.log  #本地的日志
    remote_workdir=/data/mastermha/app1/  #远程工作目录
    ssh_user=root   #SSH帐号
    repl_user=repluser  #复制用帐号
    repl_password=123  #密码
    ping_interval=1  #检测周期

    [server1]  #被管理的节点
    hostname=192.168.8.17   #被管理节点的IP
    candidate_master=1   #可以当主服务器的优先级
    [server2]
    hostname=192.168.8.27
    candidate_master=1
    [server3]
    hostname=192.168.8.37
```

6. 基于key的ssh验证
```bash
#生成密钥
ssh-keygen

#复制给自己 
ssh-copy-id 192.168.99.117

#拷贝给其它服务器
scp -r .ssh 192.168.99.114:/root/
scp -r .ssh 192.168.99.115:/root/
scp -r .ssh 192.168.99.116:/root/
```

7. 检查连接
```bash
masterha_check_ssh --conf=/etc/mastermha/app1.cnf
...
Tue Jul 16 09:54:35 2019 - [debug]   ok.
Tue Jul 16 09:54:36 2019 - [info] All SSH connection tests passed successfully.
```

2. 检查复制
```bash
masterha_check_repl --conf=/etc/mastermha/app1.cnf
...
MySQL Replication Health is OK.
```

3. 启动，开始监控
```bash
masterha_manager --conf=/etc/mastermha/app1.cnf &

Tue Jul 16 09:55:10 2019 - [warning] Global configuration file /etc/masterha_default.cnf not found. Skipping.
Tue Jul 16 09:55:10 2019 - [info] Reading application default configuration from /etc/mastermha/app1.cnf..
Tue Jul 16 09:55:10 2019 - [info] Reading server configuration from /etc/mastermha/app1.cnf..
```
Manager的监控是一次性的，当提升完新的主节点后，就完成了使命，程序就自动退出了。


- - -

# proxySQL高可用方案
## proxySQL_1
0. 网络配置
```bash
ip: 192.168.99.112
gateway: 192.168.99.254
```
1. 时间同步
```bash
yum -y install chrony
sed -i -e '1i\server 192.168.99.105 iburst' -e '/^server/d'  /etc/chrony.conf
systemctl restart chronyd
```

2. 安装前还得配置下官方的yum源
要不就自行下载安装：https://github.com/sysown/proxysql/releases
```bash
vim /etc/yum.repos.d/proxysql.repo

[proxysql_repo]
name= ProxySQL YUM repository
baseurl=http://repo.proxysql.com/ProxySQL/proxysql-1.4.x/centos/\$releasever
gpgcheck=1
gpgkey=http://repo.proxysql.com/ProxySQL/repo_pub_key
```

3. 安装proxySQL
```bash
yum clean all 

yum -y install proxysql mariadb
```

4. 启动proxySQL
```bash
systemctl start proxysql
```

5. 登录到proxysql试试
```bash
mysql -uadmin -padmin -P6032 -h127.0.0.1

#添加你的3台MySQL主机
MySQL > insert into mysql_servers(hostgroup_id,hostname,port) values(10,'192.168.99.114',3306);

MySQL > insert into mysql_servers(hostgroup_id,hostname,port) values(10,'192.168.99.115',3306);

MySQL > insert into mysql_servers(hostgroup_id,hostname,port) values(10,'192.168.99.116',3306);
```

6. 添加上了，可以看看
```bash
MySQL > select * from mysql_servers;
```
7. 当然，这2步少不了。加载并保存到磁盘
```bash
MySQL > load mysql servers to runtime;
MySQL > save mysql servers to disk;
```

8. 添加监控后端节点的用户。后面ProxySQL通过每个节点的read_only值来自动调整它们是属于读组还是写组
```bash
MySQL [(none)]> set mysql-monitor_username='monitor';
MySQL [(none)]> set mysql-monitor_password='123';
```

9. 加载到RUNTIME，并保存到disk
```bash
MySQL [(none)]> load mysql variables to runtime;
MySQL [(none)]> save mysql variables to disk;
```

10. 查看监控连接是否正常的 (对connect指标的监控)：(如果connect_error的结果为NULL则表示正常,看最后几条)
```bash
MySQL [(none)]> select * from mysql_server_connect_log;
```

**设置分组信息**

11. 指定写组的id为10，读组的id为20
```bash
MySQL> insert into mysql_replication_hostgroups values(10,20,"test");
```

1. 加载到RUNTIME生效并保存
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
| 10           | 192.168.99.114 | 3306 | ONLINE | 1      |
| 20           | 192.168.99.115 | 3306 | ONLINE | 1      |
| 20           | 192.168.99.116 | 3306 | ONLINE | 1      |
+--------------+----------------+------+--------+--------+

```


18. 在ProxySQL配置，将用户sqluser添加到mysql_users表中， default_hostgroup默认组设置为写组10，当读写分离的路由规则不符合时，会访问默认组的数据库
```bash
MySQL> insert into mysql_users(username,password,default_hostgroup) values('sqluser','123',10);

MySQL> insert into mysql_users(username,password,default_hostgroup) values('dzuser','123',10);
```

19. 保存生效
```bash
MySQL> load mysql users to runtime;
MySQL> save mysql users to disk;
```

22. 在proxysql上配置路由规则，实现读写分离
```bash
MySQL> insert into mysql_query_rules
(rule_id,active,match_digest,destination_hostgroup,apply)VALUES
(1,1,'^SELECT.*FOR UPDATE$',10,1),(2,1,'^SELECT',20,1);
```

23. 保存生效
```bash
MySQL> load mysql query rules to runtime;
MySQL> save mysql query rules to disk;
```

- - - 

## proxySQL_2
0. 网络配置
```bash
ip: 192.168.99.113
gateway: 192.168.99.254
```
1. 时间同步
```bash
yum -y install chrony
sed -i -e '1i\server 192.168.99.105 iburst' -e '/^server/d'  /etc/chrony.conf
systemctl restart chronyd
```
步骤同上了，不重复了。

- - -

## 实现proxySQL高可用集群
回到原来的ka1与ka2：192.168.99.106与107
1. ka1上追加配置，注意，是追加
```bash
vim /etc/keepalived/keepalived.conf
#配置成双主模式，在后面追加
vrrp_instance VI_2 {
    state BACKUP
    interface eth0
    virtual_router_id 22
    priority 80
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass 456
    }
    unicast_src_ip 192.168.99.106
    unicast_peer {
        192.168.99.107
    }
    virtual_ipaddress {
        192.168.0.200 dev eth0 label eth0:2
    }
}
virtual_server 192.168.0.200 6033 {
        delay_loop 3
        lb_algo wrr
        lb_kind DR
        protocol TCP
        real_server 192.168.99.112 6033 {
                weight 1
                TCP_CHECK {
                connect_port 6033
                        connect_timeout 5
                        retry 3
                        delay_before_retry 3
                }
        }
        real_server 192.168.99.113 6033 {
                weight 1
                TCP_CHECK {
                connect_port 6033
                connect_timeout 5
                retry 3
                delay_before_retry 3
                }
        }
}
```

2. 在ka2上配置，
```bash
vim /etc/keepalived/keepalived.conf
#配置成双主模式，在后面追加
vrrp_instance VI_2 {
    state MASTER
    interface eth0
    virtual_router_id 22
    priority 100
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass 456
    }
    unicast_src_ip 192.168.99.107
    unicast_peer {
        192.168.99.106
    }
    virtual_ipaddress {
        192.168.0.200 dev eth0 label eth0:2
    }
}
virtual_server 192.168.0.200 6033 {
        delay_loop 3
        lb_algo wrr
        lb_kind DR
        protocol TCP
        real_server 192.168.99.112 6033 {
            weight 1
            TCP_CHECK {
            connect_port 6033
                connect_timeout 5
                retry 3
                delay_before_retry 3
            }
        }
        real_server 192.168.99.113 6033 {
            weight 1
            TCP_CHECK {
                connect_port 6033
                connect_timeout 5
                retry 3
                delay_before_retry 3
            }
        }
}
```

**再到proxySQL设置VIP**
proxySQL_1: 192.168.99.112
3. 设置ARP
```bash
echo "net.ipv4.conf.lo.arp_ignore = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.arp_ignore = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.lo.arp_announce = 2" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.arp_announce = 2" >> /etc/sysctl.conf
sysctl -p
```

4. 添加VIP
```bash
cd /etc/sysconfig/network-scripts/

vim ifcfg-lo:0
#添加下面内容
DEVICE=lo:0
BOOTPROTO=static
BROADCAST=192.168.0.255
NETWORK=192.168.0.0
IPADDR=192.168.0.200 
NETMASK=255.255.255.255
ONBOOT=yes
TYPE=Ethernet

#重启
systemctl restart network
```


proxySQL_2: 192.168.99.113
5. 设置ARP
```bash
echo "net.ipv4.conf.lo.arp_ignore = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.arp_ignore = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.lo.arp_announce = 2" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.arp_announce = 2" >> /etc/sysctl.conf
sysctl -p
```

6. 添加VIP
```bash
cd /etc/sysconfig/network-scripts/

vim ifcfg-lo:0
#添加下面内容
DEVICE=lo:0
BOOTPROTO=static
BROADCAST=192.168.0.255
NETWORK=192.168.0.0
IPADDR=192.168.0.200 
NETMASK=255.255.255.255
ONBOOT=yes
TYPE=Ethernet

#重启
systemctl restart network
```

- - - 

# NFS配置与discuz布署

0. ip配置
```bash
ip: 192.168.99.110
gateway: 192.168.99.254
```
1. 时间同步
```bash
yum -y install chrony
sed -i -e '1i\server 192.168.99.105 iburst' -e '/^server/d'  /etc/chrony.conf
systemctl restart chronyd
```
2. 安装nfs服务
```bash
yum install -y nfs-utils
```
3. 配置一个共享目录
```bash
mkdir /data/bbs

#配置文件
vim /etc/exports
    /data/bbs 192.168.99.0/24(rw,all_squash,anonuid=997,anongid=995)
```
4. 加载服务
```bash
exportfs -r
#重启服务
systemctl restart nfs-server
```
5. 新建用户
```bash
groupadd -g 995 apache
useradd -r -u 997 -g 995 -s /sbin/nologin apache
```
6. 下载discuz
```bash
wget http://download.comsenz.com/DiscuzX/3.3/Discuz_X3.3_SC_UTF8.zip
```
7. 解压&设置权限
```bash
#如果没有unzip工具：yum -y install unzip
unzip Discuz_X3.3_SC_UTF8.zip
mv upload/* /data/bbs/
chown -R apache.apache /data/bbs
```

- - - 

# rsync + inotify实时同步
**在NFS同步服务器上配置：192.168.99.111**
0. ip配置
```bash
ip: 192.168.99.111
gateway: 192.168.99.254
```
1. 时间同步
```bash
yum -y install chrony
sed -i -e '1i\server 192.168.99.105 iburst' -e '/^server/d'  /etc/chrony.conf
systemctl restart chronyd
```

2. 先安装：
```bash
yum -y install rsync
```

3. 改配置
```sh
vim /etc/rsyncd.conf

    uid = root
    gid = root
    use chroot = no
    max connections = 0
    ignore errors
    exclude = lost+found/
    log file = /var/log/rsyncd.log
    pid file = /var/run/rsyncd.pid
    lock file = /var/run/rsyncd.lock
    reverse lookup = no
    hosts allow = 192.168.99.0/24
[backup]
    path = /data/
    comment = backup
    read only = no
    auth users = rsyncuser
    secrets file = /etc/rsync.pass
```

4. 服务器端生成验证文件
```sh
echo "rsyncuser:123" > /etc/rsync.pass
chmod 600 /etc/rsync.pass
```

5. 服务器端启动rsync服务
```sh
rsync --daemon
systemctl start rsyncd 
```

6. 部署NFS服务，下载nfs-utils
```bash
yum -y install nfs-utils
```

7. 准备备份的NFS服务，这样利用rsync+inotify实时同步，让本机做为NFS的备份服务器，当主NFS挂掉之后，起用本机。要实现还需要在web服务器上加一个监控脚本，脚本在后续。
```bash
mkdir /data/bbs

# 新建用户
groupadd -g 995 apache
useradd -r -u 997 -g 995 -s /sbin/nologin apache

# 给目录权限
setfacl -R -m u:apache:rwx /data/bbs

#配置文件
vim /etc/exports
    /data/bbs 192.168.99.0/24(rw,all_squash,anonuid=997,anongid=995)

# 加载服务
exportfs -r

# 重启服务
systemctl restart nfs-server
```

- - - 

**NFS配置：192.168.99.110**


1. 密码文件
```sh
echo "123" > /etc/rsync.pass
chmod 600 /etc/rsync.pass
```

2. 客户端测试同步数据
```sh
yum -y install rsync inotify-tools
rsync -avz --password-file=/etc/rsync.pass /data/ rsyncuser@192.168.99.111::backup
```

3. 客户端创建NFS_rsync.sh脚本，用来实时同步
```sh
#!/bin/bash
SRC='/data/'
DEST='rsyncuser@192.168.99.111::backup'

inotifywait -mrq --timefmt '%Y-%m-%d %H:%M' --format '%T %w %f' -e create,delete,moved_to,close_write,attrib ${SRC} |while read DATE TIME DIR FILE;do

FILEPATH=${DIR}${FILE}

rsync -az --delete --password-file=/etc/rsync.pass $SRC $DEST && echo "At ${TIME} on ${DATE}, file $FILEPATH was backuped up via rsync" >> /var/log/changelist.log

done
```

4. 后台运行
```bash
chmod +x NFS_rsync.sh
./NFS_rsync.sh &
```

- - - 

## keepalived实现NFS高可用
VIP为192.168.99.99

1. 在NFS：192.168.99.110
```bash
#安装keepalived
yum -y install keepalived
```
2. 配置文件
```bash
vim /etc/keepalived/keepalived.conf

! Configuration File for keepalived

global_defs {
   notification_email {
       root@localhost
   }
   notification_email_from root@localhost
   smtp_server 127.0.0.1
   smtp_connect_timeout 30
   router_id NFS1
   vrrp_skip_check_adv_addr
#   vrrp_strict
   vrrp_garp_interval 0
   vrrp_gna_interval 0
}

vrrp_instance VI_1 {
    state MASTER
    interface eth0
    virtual_router_id 33
    priority 100
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass 789
    }
    unicast_src_ip 192.168.99.110
    unicast_peer {
        192.168.99.111
    }
    virtual_ipaddress {
        192.168.99.99 dev eth0 label eth0:1
    }
}
```
3. 启动
```bash
systemctl restart keepalived
```

4. 在NFS同步服务器上：192.168.99.111
```bash
#安装keepalived
yum -y install keepalived
```
5. 配置文件
```bash
vim /etc/keepalived/keepalived.conf

! Configuration File for keepalived

global_defs {
   notification_email {
       root@localhost
   }
   notification_email_from root@localhost
   smtp_server 127.0.0.1
   smtp_connect_timeout 30
   router_id NFS2
   vrrp_skip_check_adv_addr
#   vrrp_strict
   vrrp_garp_interval 0
   vrrp_gna_interval 0
}

vrrp_instance VI_1 {
    state BACKUP
    interface eth0
    virtual_router_id 33
    priority 80
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass 789
    }
    unicast_src_ip 192.168.99.111
    unicast_peer {
        192.168.99.110
    }
    virtual_ipaddress {
        192.168.99.99 dev eth0 label eth0:1
    }
}
```
6. 启动
```bash
systemctl restart keepalived
```

- - -

# NFS的自动挂载
回到web_A: 192.168.99.108(web_B也要这么配置)

1. 安装nfs工具
```bash
yum -y install nfs-utils
```

2. 挂载nfs
```bash
mkdir /data/bbs
mount 192.168.99.99:/data/bbs /data/bbs
```

到这里，我们就成功的把web服务的文件存放在NFS服务器上，但NFS服务器存在单点故障问题，所以在上面我们利用keepalived可以实现高可用，当主NFS服务器故障时，可实现VIP漂移，但这样会有个问题，主备切换后，web服务器需要重新挂载，无法到达双机热备的效果。

所以还需要写个脚本来实现自动重载，auto_nfs.sh脚本如下：
```bash
#!/bin/bash
#
#***********************************************************
#Author:                Jibill Chen
#QQ:                    417060833
#Date:                  2019-08-10
#FileName：             auto_nfs.sh
#URL:                   https://thson.blog.csdn.net/
#Description：          The test script
#**********************************************************
vip_dir="192.168.99.99:/data/bbs"
nfs_dir="/data/bbs"

n=0
while :
do
    stat $nfs_dir &> /dev/null
    [ $? -ne 0 ] && let n+=1
    if [ $n -gt 3 ] ;then
        umount $nfs_dir
        sleep 1
        mount $vip_dir $nfs_dir
        break
    fi
    sleep 3
done
```

3. 后台运行
```bash
bash auto_nfs.sh &
```

4. 传给web_B：192.168.99.109
```bash
scp auto_nfs.sh 192.168.99.109:/root
```
5. 在web_B上也配置NFS
```bash
#安装nfs工具
yum -y install nfs-utils

#挂载nfs
mkdir /data/bbs
mount 192.168.99.99:/data/bbs /data/bbs

#后台运行脚本
scp auto_nfs.sh 192.168.99.109:/root
```

6. 还有discuz的虚拟主机还没有完成。修改下配置文件
web_A与web_B都要配置
```bash
vim /etc/httpd/conf.d/discuz.conf

<virtualhost *:80>
    documentroot /data/bbs
    servername bbs.jibill.com
    <directory /data/bbs>
        require all granted
    </directory>
</virtualhost>
```
重启服务
```bash
systemctl restart httpd
```

- - - 
到此，我们完成了整个keepalived高可用集群的配置，现在来配置个discuz来验证proxySQL的高可用。

注意：安装discuz的过程中，先把web_A或者web_B关了一台。否则在安装的过程的会因为LVS调度而出现问题
