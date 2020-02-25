[toc]

# HAProxy2.0.4编译安装
## LUA脚本语言：
1. 下载
```bash
curl -R -O http://www.lua.org/ftp/lua-5.3.5.tar.gz
```
2. 安装环境
```bash
yum -y install libtermcap-devel ncurses-devel libevent-devel readline-devel gcc gcc-c++
```
3. 安装
```bash
cd /usr/local/src
tar xvf ~/lua-5.3.5.tar.gz
cd lua-5.3.5
make linux test
```
4. 查看版本
```bash
./src/lua -v
```

## HAProxy
```bash
wget http://www.haproxy.org/download/2.0/src/haproxy-2.0.4.tar.gz

#编译环境
yum -y install gcc gcc-c++ glibc glibc-devel pcre pcre-devel openssl openssl-devel systemd-devel net-tools vim iotop bc zip unzip zlib-devel lrzsz tree screen lsof tcpdump wget ntpdate
```

2. 编译
```bash
make ARCH=x86_64 \
TARGET=linux-glibc \
USE_PCRE=1 \
USE_OPENSSL=1 \
USE_ZLIB=1 \
USE_SYSTEMD=1 \
USE_CPU_AFFINITY=1 \
USE_LUA=1 \
LUA_INC=/usr/local/src/lua-5.3.5/src/ \
LUA_LIB=/usr/local/src/lua-5.3.5/src/ \
PREFIX=/usr/local/haproxy
```
3. 编译安装
```bash
make install PREFIX=/usr/local/haproxy
```
4. 执行程序复制到sbin下
```bash
cp /usr/local/haproxy/sbin/haproxy /usr/sbin/
```
5. 查看版本
```bash
haproxy -v
```
6. 启动脚本
```bash
cat /usr/lib/systemd/system/haproxy.service
[Unit]
Description=HAProxy Load Balancer
After=syslog.target network.target
[Service]
ExecStartPre=/usr/sbin/haproxy -f /etc/haproxy/haproxy.cfg -c -q
ExecStart=/usr/sbin/haproxy -Ws -f /etc/haproxy/haproxy.cfg -p /var/lib/haproxy/haproxy.pid
ExecReload=/bin/kill -USR2 $MAINPID
[Install]
WantedBy=multi-user.target
```
7. 配置文件
```bash
[root]# mkdir /etc/haproxy
[root]# cat /etc/haproxy/haproxy.cfg
global
    maxconn 100000
    chroot /usr/local/haproxy
    stats socket /var/lib/haproxy/haproxy.sock mode 600 level admin
    uid 99
    gid 99
    daemon
    #nbproc 4
    #cpu-map 1 0
    #cpu-map 2 1
    #cpu-map 3 2
    #cpu-map 4 3
    pidfile /var/lib/haproxy/haproxy.pid
    log 127.0.0.1 local3 info

defaults
    option http-keep-alive
    option forwardfor
    maxconn 100000
    mode http
    timeout connect 300000ms
    timeout client 300000ms
    timeout server 300000ms

listen stats
    mode http
    bind 0.0.0.0:9999
    stats enable
    log global
    stats uri /haproxy-status
    stats auth haadmin:q1w2e3r4ys

listen web_port
    bind 192.168.99.118:80
    mode http  
    log global  
    server web1 192.168.99.119:80 check inter 3000 fall 2 rise 5  
```

