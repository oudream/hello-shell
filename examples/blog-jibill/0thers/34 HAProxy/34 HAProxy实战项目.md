[toc]

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190820094546348.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

<table><td bgcolor='orange'> web一期项目 </td></table>

# mysql_master(192.168.99.203)

1. 准备包：mysql-5.6.34-onekey-install.tar.gz
**包含3个文件：**
1、mysql-5.6.34-linux-glibc2.5-x86_64.tar.gz
2、mysql_install.sh(下面有源码)
3、my.cnf(下面有源码)

2. 解压
```bash
tar xf mysql-5.6.34-onekey-install.tar.gz
```

3. 一键安装
```bash
bash mysql_install.sh
```

4. 安装完成后，修改配置
```bash
vim /etc/my.cnf
#[mysqld]在添加2行
log-bin
server-id=203
```
5. 新建wordpress的数据库与帐号
```bash
create database wpdb;
grant all privileges on wpdb.* to wpuser@'192.168.99.%' identified by "123";
```

6. 添加到开机启动
```bash
echo '/etc/init.d/mysqld start' >> /etc/rc.d/rc.local
chmod +x /etc/rc.d/rc.local
```

**mysql_install.sh内容**
```bash
#!/bin/bash
DIR=`pwd`
NAME="mysql-5.6.34-linux-glibc2.5-x86_64.tar.gz"
FULL_NAME=${DIR}/${NAME}
DATA_DIR="/data/mysql"

yum install vim gcc gcc-c++ wget autoconf  net-tools lrzsz iotop lsof iotop bash-completion -y
yum install curl policycoreutils openssh-server openssh-clients postfix libaio -y

if [ -f ${FULL_NAME} ];then
    echo "安装文件存在"
else
    echo "安装文件不存在"
    exit 3
fi
if [ -h /usr/local/mysql ];then
    echo "Mysql 已经安装"
    exit 3 
else
    tar xvf ${FULL_NAME}   -C /usr/local/src
    ln -sv /usr/local/src/mysql-5.6.34-linux-glibc2.5-x86_64  /usr/local/mysql
    if id  mysql;then
        echo "mysql 用户已经存在，跳过创建用户过程"
    fi
        useradd  mysql  -s /sbin/nologin
    if  id  mysql;then
    	chown  -R mysql.mysql  /usr/local/mysql/* -R
        if [ ! -d  /data/mysql ];then
            mkdir -pv /data/mysql && chown  -R mysql.mysql  /data/mysql   -R
            /usr/local/mysql/scripts/mysql_install_db  --user=mysql --datadir=/data/mysql  --basedir=/usr/local/mysql/
	    cp  /usr/local/src/mysql-5.6.34-linux-glibc2.5-x86_64/support-files/mysql.server /etc/init.d/mysqld
	    chmod a+x /etc/init.d/mysqld
 	    cp ${DIR}/my.cnf   /etc/my.cnf
	    ln -sv /usr/local/mysql/bin/mysql  /usr/bin/mysql
	    /etc/init.d/mysqld start
	else
            echo "MySQL数据目录已经存在,"
			exit 3
	fi
    fi
fi
```

`my.cnf`内容
```bash
[mysqld]
socket=/var/lib/mysql/mysql.sock
user=mysql
symbolic-links=0
datadir=/data/mysql
innodb_file_per_table=1

[client]
port=3306
socket=/var/lib/mysql/mysql.sock

[mysqld_safe]
log-error=/var/log/mysqld.log
pid-file=/tmp/mysql.sock
```
- - -

# NFS(192.168.99.204)
1. 安装nfs
```bash
yum -y install nfs-utils
```
2. 准备用户
```bash
useradd nginx -s /sbin/nologin
```
3. 配置nfs
```bash
echo "/data/wordpress 192.168.99.0/24(rw,all_squash,anonuid=`id -u nginx`,anongid=`id -g nginx`)" >> /etc/exports
```
4. 准备目录
```bash
mkdir /data/wordpress
chown -R nginx.nginx /data/wordpress/
```
5. 加载配置
```bash
exportfs -r
```
6. 启动服务
```bash
systemctl start nfs-server
systemctl enable nfs-server
```

- - -

# nginx + php(192.168.99.205、206)
准备2个主机，nginx_1与nginx_2，执行下面

1. 准备包：php-7.2.21-onekey-install.tar.gz
**包含2个文件：**
1、php-7.2.21.tar.gz
2、php_install.sh(下面有源码)

2. 解压：
```bash
tar xf php-7.2.21-onekey-install.tar.gz
```
3. 一键安装
```bash
cd php-7.2.21-onekey-install
bash php_install.sh
```

4. 安装nginx()
```bash
yum -y install nginx
```

**php_install.sh内容:**
```bash
#!/bin/bash

yum -y install wget vim pcre pcre-devel openssl openssl-devel libicudevel gcc gcc-c++ autoconf libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel libxml2 libxml2-devel zlib zlib-devel glibc glibc-devel glib2 glib2-devel ncurses ncurses-devel curl curl-devel krb5-devel libidn libidn-devel openldap openldap-devel nss_ldap jemalloc-devel cmake boost-devel bison automake libevent libevent-devel gd gd-devel libtool* libmcrypt libmcrypt-devel mcrypt mhash libxslt libxslt-devel readline readline-devel gmp gmp-devel libcurl libcurl-devel openjpegdevel

id nginx || useradd nginx -s /sbin/nologin

tar xf php-7.2.21.tar.gz

cd php-7.2.21

./configure --prefix=/apps/php \
--enable-fpm \
--with-fpmuser=nginx \
--with-fpm-group=nginx \
--with-pear \
--with-curl \
--with-png-dir \
--with-freetype-dir \
--with-iconv \
--with-mhash \
--with-zlib \
--with-xmlrpc \
--with-xsl \
--with-openssl \
--with-mysqli \
--with-pdo-mysql \
--disable-debug \
--enable-zip \
--enable-sockets \
--enable-soap \
--enable-inline-optimization \
--enable-xml \
--enable-ftp \
--enable-exif \
--enable-wddx \
--enable-bcmath \
--enable-calendar \
--enable-shmop \
--enable-dba \
--enable-sysvsem \
--enable-sysvshm \
--enable-sysvmsg

make && make install

cd /apps/php/etc/php-fpm.d/
cp www.conf.default www.conf
cp /root/php-7.2.21/php.ini-production /apps/php/etc/php.ini
cat > www.conf << EOF
[www]
user = nginx
group = nginx
listen = 127.0.0.1:9000
listen.allowed_clients = 127.0.0.1
pm = dynamic
pm.max_children = 50
pm.start_servers = 30
pm.min_spare_servers = 30
pm.max_spare_servers = 35
pm.status_path = /pm_status
ping.path = /ping
ping.response = pong
access.log = log/$pool.access.log
slowlog = log/$pool.log.slow
EOF

mkdir /apps/php/log/
cd /apps/php/etc/
cp php-fpm.conf.default php-fpm.conf
/apps/php/sbin/php-fpm -t && /apps/php/sbin/php-fpm -c /apps/php/etc/php.ini
```

## nginx(192.168.99.205)
准备包：wordpress-5.2.2-zh_CN.zip

1. 安装nfs工具
```bash
yum -y install nginx nfs-utils
```

2. 挂载
```bash
mkdir /data/wordpress
mount 192.168.99.204:/data/wordpress/ /data/wordpress/
unzip wordpress-5.2.2-zh_CN.zip
cp -r wordpress/* /data/wordpress/
```

3. 自动挂载(这步nginx_2也要做)
```bash
vim /etc/fstab
192.168.99.204:/data/wordpress /data/wordpress nfs defaults 0 0
```

4. 删除主配置，我们把配置写到下面这个配置文件里
```bash
sed -i '38,88d' /etc/nginx/nginx.conf
```

5. `/etc/nginx/conf.d/test.conf`配置文件
```bash
server {
        listen 80;
        server_name blog.jibill.com;
        #测试用
        location = /test.html {
            root /data;
        }
        location / {
                root /data/wordpress;
                index index.php index.html index.htm;

        }
        location ~ \.php$ {
                root /data/wordpress;
                fastcgi_pass 127.0.0.1:9000;
                fastcgi_index index.php;
                fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
                include fastcgi_params;
        }
        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
}
```

4. 启动
```bash
nginx
echo 111 > /data/test.html
```

4. 把nginx配置复制给nginx_2
```bash
#192.168.99.206是nginx_2的ip
scp /etc/nginx/nginx.conf 192.168.99.206:/etc/nginx
scp /etc/nginx/conf.d/test.conf 192.168.99.206:/etc/nginx/conf.d
```

5. 启动nginx_2（192.168.99.206）
```bash
nginx
echo 222 > /data/test.html
```
---

# haproxy(192.168.99.207、208)
haproxy_1与haproxy_2都这么配置

1. 安装haproxy
```bash
yum -y install haproxy
```

2. 编辑`/etc/haproxy/haproxy.cfg`配置文件
```bash
global
    log         127.0.0.1 local2
    chroot      /var/lib/haproxy
    pidfile     /var/run/haproxy.pid
    maxconn     4000
    user        haproxy
    group       haproxy
    daemon
    stats socket /var/lib/haproxy/stats

defaults
    mode                    http
    log                     global
    option forwardfor
    option http-keep-alive
    retries                 3
    timeout http-request    10s
    timeout queue           1m
    timeout connect         10s
    timeout client          1m
    timeout server          1m
    timeout http-keep-alive 10s
    timeout check           10s
    maxconn      3000

listen nginx_blog
       bind :80
       mode http
       balance roundrobin
       server web1 192.168.99.205:80 weight 1 check inter 3000 fall 2 rise 5
       server web2 192.168.99.206:80 weight 1 check inter 3000 fall 2 rise 5
```

3. 启动
```bash
systemctl start haproxy
systemctl enable haproxy
```

4. HAProxy_1与HAProxy_2都要配置，然后再测试
测试命令
```bash
while :;do curl 192.168.99.207/test.html;sleep 1;done
#和
while :;do curl 192.168.99.208/test.html;sleep 1;done
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190820091748877.png)

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190820091804905.png)


## haproxy + keepalived
1. 在ha_1先来（192.168.99.207）
```bash
yum -y install keepalived
```

2. 配置文件`/etc/keepalived/keepalived.conf`
```bash
! Configuration File for keepalived

global_defs {
   notification_email {
        root@localhost
   }
   notification_email_from root@localhost
   smtp_server 127.0.0.1
   smtp_connect_timeout 30
   router_id HA_1
}
vrrp_script chk_haproxy {
   script "killall -0 haproxy"   
   interval 2
   weight -25
   fall 2
   rise 1
}
vrrp_instance VI_1 {
    state MASTER
    interface eth0
    virtual_router_id 51
    priority 100
    advert_int 1
    unicast_src_ip 192.168.99.207
    unicast_peer {
    192.168.99.208
    }
    track_script { 
       chk_haproxy
    }
    authentication {
        auth_type PASS
        auth_pass 1111
    }
    virtual_ipaddress {
        192.168.99.10 dev eth0 label eth0:1
    }
}
```

3. 启动
```bash
systemctl start keepalived
systemctl enable keepalived
```

4. 查看下vip起来了没
```bash
[ha_1]$ ifconfig eth0:1
eth0:1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.99.10  netmask 255.255.255.255  broadcast 0.0.0.0
        ether 52:54:00:d9:40:34  txqueuelen 1000  (Ethernet)
```

5. ha_2来配置（192.168.99.208）
```bash
yum -y install keepalived
```

6. 配置文件`/etc/keepalived/keepalived.conf`
```bash
! Configuration File for keepalived

global_defs {
   notification_email {
        root@localhost
   }
   notification_email_from root@localhost
   smtp_server 127.0.0.1
   smtp_connect_timeout 30
   router_id HA_2
}
vrrp_script chk_haproxy {
   script "killall -0 haproxy"   
   interval 2
   weight -25
   fall 2
   rise 1
}
vrrp_instance VI_1 {
    state BACKUP
    interface eth0
    virtual_router_id 51
    priority 80
    advert_int 1
    unicast_src_ip 192.168.99.208
    unicast_peer {
    192.168.99.207
    }
    authentication {
        auth_type PASS
        auth_pass 1111
    }
    track_script { 
       chk_haproxy
    }
    virtual_ipaddress {
        192.168.99.10 dev eth0 label eth0:1
    }
}
```

7. 启动
```bash
systemctl start keepalived
systemctl enable keepalived
```

8. 抓个包看看，抓vrrp
```bash
[ha_2]$ tcpdump -nn vrrp
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
11:22:51.029751 IP 192.168.99.207 > 192.168.99.208: VRRPv2, Advertisement, vrid 51, prio 100, authtype simple, intvl 1s, length 20
11:22:52.070878 IP 192.168.99.207 > 192.168.99.208: VRRPv2, Advertisement, vrid 51, prio 100, authtype simple, intvl 1s, length 20
11:22:53.107011 IP 192.168.99.207 > 192.168.99.208: VRRPv2, Advertisement, vrid 51, prio 100, authtype simple, intvl 1s, length 20
11:22:54.118445 IP 192.168.99.207 > 192.168.99.208: VRRPv2, Advertisement, vrid 51, prio 100, authtype simple, intvl 1s, length 20
```

**测试**
```bash
[kvm]$ while :; do curl 192.168.99.10/test.html ; sleep 1 ; done
222
111
222
111
```

## 安装wordpress
1. 电脑访问：192.168.99.10
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190819214833695.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

2. 现在就开始，按照你的实际情况填写
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190819214908178.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

3. 继续，安装
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190819215149616.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

4. 自行填写
![在这里插入图片描述](https://img-blog.csdnimg.cn/2019081921522681.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

5. 登录
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190819215316730.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

6. 输入你的帐号密码
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190819215333441.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

7. OK
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190819215400136.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

---

<table><td bgcolor='orange'> web二期项目 </td></table>

# LVS_1配置(192.168.99.209)

1. 安装keepalived和ipvsadm
```bash
yum -y install keepalived ipvsadm
```

2. 编辑`/etc/keepalived/keepalived.conf`配置
```bash
! Configuration File for keepalived

global_defs {
   notification_email {
           root@localhost
   }
   notification_email_from root@localhost
   smtp_server 127.0.0.1
   smtp_connect_timeout 30
   router_id LVS_1    
}

vrrp_instance VI_1 {
    state MASTER    
    interface eth0
    virtual_router_id 51
    priority 100  
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass 1111
    }
    unicast_src_ip 192.168.99.209
    unicast_peer {
        192.168.99.210 
    }
    virtual_ipaddress {
        192.168.99.100 dev eth0 label eth0:1 
    }
}

virtual_server 192.168.99.100 80 {
        delay_loop 3
        lb_algo wrr
        lb_kind DR
        protocol TCP
        real_server 192.168.99.205 80 {
            weight 1
            TCP_CHECK {
                connect_timeout 4
                retry 3
                delay_before_retry 3
            }
        }
        real_server 192.168.99.206 80 {
            weight 1
            TCP_CHECK {
                connect_timeout 4
                retry 3
                delay_before_retry 3
            }
        }
}
```

3. 启动
```bash
systemctl restart keepalived
systemctl enbale keepalived
```

4. 查看LVS的RS
```bash
[lvs_1]$ ipvsadm -Ln
IP Virtual Server version 1.2.1 (size=4096)
Prot LocalAddress:Port Scheduler Flags
  -> RemoteAddress:Port           Forward Weight ActiveConn InActConn
TCP  192.168.99.100:80 wrr
  -> 192.168.99.205:80            Route   1      0          0
  -> 192.168.99.206:80            Route   1      0          0
```

---

# LVS_2配置(192.168.99.210)

1. LVS_2配置
```bash
yum -y install keepalived ipvsadm
```

2. 编辑`/etc/keepalived/keepalived.conf`配置
```bash
! Configuration File for keepalived

global_defs {
   notification_email {
           root@localhost
   }
   notification_email_from root@localhost
   smtp_server 127.0.0.1
   smtp_connect_timeout 30
   router_id LVS_2
}

vrrp_instance VI_1 {
    state BACKUP
    interface eth0
    virtual_router_id 51
    priority 80
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass 1111
    }
    unicast_src_ip 192.168.99.210  
    unicast_peer {
        192.168.99.209
    }
    virtual_ipaddress {
        192.168.99.100 dev eth0 label eth0:1
    }
}

virtual_server 192.168.99.100 80 {
        delay_loop 3
        lb_algo wrr
        lb_kind DR
        protocol TCP
        real_server 192.168.99.205 80 {
            weight 1
            TCP_CHECK {
                    connect_timeout 4
                    retry 3
                    delay_before_retry 3
            }
        }
        real_server 192.168.99.206 80 {
            weight 1
            TCP_CHECK {
                connect_timeout 4
                retry 3
                delay_before_retry 3
            }
        }
}
```

3. 启动
```bash
systemctl restart keepalived
systemctl enable keepalived
```

4. 查看LVS的RS
```bash
[lvs_2]$ ipvsadm -Ln
IP Virtual Server version 1.2.1 (size=4096)
Prot LocalAddress:Port Scheduler Flags
  -> RemoteAddress:Port           Forward Weight ActiveConn InActConn
TCP  192.168.99.100:80 wrr
  -> 192.168.99.205:80            Route   1      0          0
  -> 192.168.99.206:80            Route   1      0          0
```

## 配置nginx

**nginx_1(192.168.99.205)**

1. 配置arp广播忽略
```bash
echo "net.ipv4.conf.lo.arp_ignore = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.arp_ignore = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.lo.arp_announce = 2" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.arp_announce = 2" >> /etc/sysctl.conf
sysctl -p
```

2. 在lo上配置vip
```bash
vim /etc/sysconfig/network-scripts/ifcfg-lo:0
#添加下面内容
DEVICE=lo:0
BOOTPROTO=static
BROADCAST=192.168.99.255
NETWORK=192.168.99.0
IPADDR=192.168.99.100  #这个是VIP
NETMASK=255.255.255.255
ONBOOT=yes
TYPE=Ethernet
```

3. 重启网卡
```bash
systemctl restart network
```

**nginx_2(192.168.99.206)**
同样的配置
1. 配置arp广播忽略
```bash
echo "net.ipv4.conf.lo.arp_ignore = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.arp_ignore = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.lo.arp_announce = 2" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.arp_announce = 2" >> /etc/sysctl.conf
sysctl -p
```

2. 在lo上配置vip
```bash
vim /etc/sysconfig/network-scripts/ifcfg-lo:0
#添加下面内容
DEVICE=lo:0
BOOTPROTO=static
BROADCAST=192.168.99.255
NETWORK=192.168.99.0
IPADDR=192.168.99.100  #这个是VIP
NETMASK=255.255.255.255
ONBOOT=yes
TYPE=Ethernet
```

3. 重启网卡
```bash
systemctl restart network
```

**测试**
```bash
[kvm]$ while :; do curl 192.168.99.100/test.html ; sleep 1 ; done
222
111
222
111
...
```

---

# mysql主从配置
## mysql_master（192.168.99.203）
安装等配置已经在最前面配置好了。
修改配置
```bash

```
创建个复制帐号
```bash
grant replication slave on *.* to repluser@'192.168.99.%' identified by '123';
```

## mysql_slave配置（192.168.99.211）

1. 准备包：mysql-5.6.34-onekey-install.tar.gz
**包含3个文件：**
1、mysql-5.6.34-linux-glibc2.5-x86_64.tar.gz
2、mysql_install.sh（源码都在最上面有）
3、my.cnf（源码都在最上面有）

2. 解压
```bash
tar xf mysql-5.6.34-onekey-install.tar.gz
```

3. 一键安装
```bash
bash mysql_install.sh
```

4. 修改配置
```bash
#在[mysqld]添加2行
server-id=211
read-only
```

4. 安装完成后，进入mysql，连接mysql_master
```bash
CHANGE MASTER TO 
MASTER_HOST='192.168.99.203', 
MASTER_PORT=3306,
MASTER_USER='repluser', 
MASTER_PASSWORD='123', 
MASTER_LOG_FILE='mysql-bin.000001', 
MASTER_LOG_POS=120;
```
5. 启动
```bash
start slave;
```
6. 添加到开机启动
```bash
echo '/etc/init.d/mysqld start' >> /etc/rc.d/rc.local
chmod +x /etc/rc.d/rc.local
```

---

# NFS_backup（192.168.99.212）

1. 安装rsync
```bash
yum -y install rsync
```
2. 修改配置文件
```bash
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
3. 配置帐号
```bash
echo "rsyncuser:123" > /etc/rsync.pass
chmod 600 /etc/rsync.pass
```

4. 启动
```bash
rsync --daemon
systemctl start rsyncd
systemctl enable rsyncd
```

## NFS的配置（192.168.99.204）
1. 配置密码文件
```bash
echo "123" > /etc/rsync.pass
chmod 600 /etc/rsync.pass
```

2. 安装rsync+inotify
```bash
yum -y install rsync inotify-tools
```

3. 测试数据是否同步，同步的话再来写个脚本
```bash
#创建个文件
touch /data/test_rsync.txt

#测试是否同步
rsync -avz --password-file=/etc/rsync.pass /data/test_rsync.txt rsyncuser@192.168.99.212::backup
```

4. 可以同步，那写个脚本`/etc/init.d/NFS_rsync.sh`
```bash
#!/bin/bash
SRC='/data/'
DEST='rsyncuser@192.168.99.212::backup'

inotifywait -mrq --timefmt '%Y-%m-%d %H:%M' --format '%T %w %f' -e create,delete,moved_to,close_write,attrib ${SRC} |while read DATE TIME DIR FILE;do

FILEPATH=${DIR}${FILE}

rsync -az --delete --password-file=/etc/rsync.pass $SRC $DEST && echo "At ${TIME} on ${DATE}, file $FILEPATH was backuped up via rsync" >> /var/log/changelist.log

done
```

5. 运行
```bash
chmod +x /etc/init.d/NFS_rsync.sh
/etc/init.d/NFS_rsync.sh &
```

6. 开机运行
```bash
echo '/etc/init.d/NFS_rsync.sh &' >> /etc/rc.d/rc.local
chmod +x /etc/rc.d/rc.local
```

7. 注意：脚本写完后，如果想看是否同步，可以
```bash
touch /data/wordpress/index.php
```

# 重新安装wordpress

**nginx_1(192.168.99.205)**
1. 删除wordpress
```bash
rm -rf /data/wordpress/*
```
2. 重新解压wordpress
```bash
unzip wordpress-5.2.2-zh_CN.zip
cp -r wordpress/* /data/wordpress/
```

**mysql_master(192.168.99.203)**
3. 重建数据库
```bash
drop database wpdb;
create database wpdb;
```

4. 访问192.168.99.100安装wordpress
安装完成
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190820113922817.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

5. 写个文章（过程略）

6. 挂掉LVS_1(master)

---

# 总结：
**二期项目相对一期项目的优势：**
1、LVS工作在网络4层，没有流量的产生，这个特点也决定了它在负载均衡软件里的性能最强的，对内存和cpu资源消耗比较低。性能稳定，因为其本身抗负载能力很强，自身有完整的双机热备方案，如LVS+Keepalived，所以我们在项目实施中用的架构是LVS(DR)+Keepalived。

2、使用keepalived解决了单点故障：通过VRRP技术，当其中一台LVS挂掉之后，vip漂移到另一台LVS上，继续提供调度功能，业务不中断。

3、mysql主从复制与NFS的备份确保了冗余性。保证了数据安全。