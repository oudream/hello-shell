[toc]

# HAProxy调度算法
HAProxy通过固定参数balance指明对后端服务器的调度算法，该参数可以配置在listen或backend选项中。
HAProxy的调度算法分为静态和动态调度算法，但是有些算法可以根据参数在静态和动态算法中相互转换。

---
## 一、静态算法
静态算法：按照事先定义好的规则轮询公平调度，不关心后端服务器的当前负载、链接数和相应速度等，且无法实时修改权重，只能靠重启HAProxy生效。

### 1. static-rr
基于权重的轮询调度，不支持权重的运行时调整及后端服务器慢启动，其后端主机数量没有限制
```bash
listen web_host
    bind 192.168.7.101:80,:8801-8810,192.168.7.101:9001-9010
    mode http
    log global
    balance static-rr
    server web1 192.168.7.103:80 weight 1 check inter 3000 fall 2 rise 5
    server web2 192.168.7.104:80 weight 2 check inter 3000 fall 2 rise 5
```

### 2. first
根据服务器在列表中的位置，自上而下进行调度，但是其只会当第一台服务器的连接数达到上限，新请求才会分配给下一台服务，因此会忽略服务器的权重设置
```bash
listen web_host
    bind 192.168.7.101:80,:8801-8810,192.168.7.101:9001-9010
    mode http
    log global
    balance first
    server web1 192.168.7.103:80 maxconn 2 weight 1 check inter 3000 fall 2 rise 5
    server web2 192.168.7.104:80 weight 1 check inter 3000 fall 2 rise 5
```

---

## 二、动态算法：
动态算法：基于后端服务器 状态进行调度适当调整，比如优先调度至当前负载较低的服务器，且权重可以在haproxy运行时动态调整无需重启。

**服务器动态权重调整**
```bash
[root]# yum install socat
[root]# echo "show info" | socat stdio /var/lib/haproxy/haproxy.sock
[root]# echo "get weight web_host/web1" | socat stdio /var/lib/haproxy/haproxy.sock
1 (initial 1)

[root]# echo "set weight web_host/web1 2" | socat stdio /var/lib/haproxy/haproxy.sock
Backend is using a static LB algorithm and only accepts weights '0%' and '100%'.
```

### 1. roundrobin
基于权重的轮询动态调度算法，支持权重的运行时调整，不完全等于lvs中的rr轮训模式，HAProxy中的roundrobin支持慢启动(新加的服务器会逐渐增加转发数)，其每个后端backend中最多支持4095个real server

roundrobin为**默认调度算法**，且支持对real server权重动态调整。
```bash
listen web_host
    bind 192.168.7.101:80,:8801-8810,192.168.7.101:9001-9010
    mode http
    log global
    balance roundrobin
    server web1 192.168.7.103:80 weight 1 check inter 3000 fall 2 rise 5
    server web2 192.168.7.104:80 weight 2 check inter 3000 fall 2 rise 5
```

**动态调整权限：**
```bash
[root]# echo "get weight web_host/web1" | socat stdio /var/lib/haproxy/haproxy.sock1
1 (initial 1)

[root]# echo "set weight web_host/web1 3" | socat stdio /var/lib/haproxy/haproxy.sock1
[root]# echo "get weight web_host/web1" | socat stdio /var/lib/haproxy/haproxy.sock1
3 (initial 1)

#手动把后端服务down掉
[root]# echo "disable web_host/web1" | socat stdio /var/lib/haproxy/haproxy.sock1
```

### 2. leastconn
加权的最少连接的动态，支持权重的运行时调整和慢启动，即当前后端服务器连接最少的优先调度(新客户端连接)，比较适合长连接的场景使用，比如MySQL等场景。
```bash
listen web_host
    bind 192.168.7.101:80,:8801-8810,192.168.7.101:9001-9010
    mode http
    log global
    balance leastconn
    server web1 192.168.7.103:80 weight 1 check inter 3000 fall 2 rise 5
    server web2 192.168.7.104:80 weight 1 check inter 3000 fall 2 rise 5
```
---

## 三、混合算法
部分算法即可作为静态算法，又可以通过选项称为动态算法

### 1. source
源地址hash，基于用户源地址hash并将请求转发到后端服务器，默认为静态即取模方式，但是可以通过hash-type支持的选项更改，后续同一个源地址请求将被转发至同一个后端web服务器，比较适用于session保持/缓存业务等场景。

源地址有两种转发客户端请求到后端服务器的服务器选取计算方式，
分别是**取模法**和**一致性hash**

**map-base取模法**
基于服务器总权重的hash数组取模，该hash是静态的即不支持在线调整权重，不支持慢启动，其对后端服务器调度均衡，缺点是当服务器的总权重发生变化时，即有服务器上线或下线，都会因权重发生变化而导致调度结果整体改变。

取模法配置示例
```bash
listen web_host
bind 192.168.7.101:80,:8801-8810,192.168.7.101:9001-9010
mode tcp
log global
balance source
server web1 192.168.7.103:80 weight 1 check inter 3000 fall 2 rise 5
server web2 192.168.7.104:80 weight 1 check inter 3000 fall 2 rise 5
```

**一致性hash：**
一致性哈希，该hash是动态的，支持在线调整权重，支持慢启动，优点在于当服务器的总权重发生变化时，对调度
结果影响是局部的，不会引起大的变动，hash（o）mod n 。

hash对象：
Hash对象到后端服务器的映射关系：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190815170545815.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

一致性hash示意图：
后端服务器在线与离线的调度方式
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190815170601851.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

**一致性hash配置示例：**
```bash
listen web_host
    bind 192.168.7.101:80,:8801-8810,192.168.7.101:9001-9010
    mode tcp
    log global
    balance source
    hash-type consistent
    server web1 192.168.7.103:80 weight 1 check inter 3000 fall 2 rise 5
    server web2 192.168.7.104:80 weight 1 check inter 3000 fall 2 rise 5
```

### 2. uri
基于对用户请求的uri做hash并将请求转发到后端指定服务器，也可以通过map-based和consistent定义使用取模法还是一致性hash。 

**uri 取模法配置示例**
```bash
listen web_host
    bind 192.168.7.101:80,:8801-8810,192.168.7.101:9001-9010
    mode http
    log global
    balance uri
    server web1 192.168.7.103:80 weight 1 check inter 3000 fall 2 rise 5
    server web2 192.168.7.104:80 weight 1 check inter 3000 fall 2 rise 5
```

**uri 一致性hash配置示例**
```bash
listen web_host
    bind 192.168.7.101:80,:8801-8810,192.168.7.101:9001-9010
    mode http
    log global
    balance uri
    hash-type consistent
    server web1 192.168.7.103:80 weight 1 check inter 3000 fall 2 rise 5
    server web2 192.168.7.104:80 weight 1 check inter 3000 fall 2 rise 5
```

### 3. url_param：
url_param对用户请求的url中的 params 部分中的参数name作hash计算，并由服务器总权重相除以后派发至某挑出的服务器；通常用于追踪用户，以确保来自同一个用户的请求始终发往同一个real server

```bash
假设:
    url = http://www.magedu.com/foo/bar/index.php?k1=v1&k2=v2
则：
    host = "www.magedu.com"
    url_param = "k1=v1&k2=v2"
```

**url_param取模法配置示例**
```bash
listen web_host
    bind 192.168.7.101:80,:8801-8810,192.168.7.101:9001-9010
    mode http
    log global
    balance url_param name,age #支持对单个及多个url_param 值hash
    server web1 192.168.7.103:80 weight 1 check inter 3000 fall 2 rise 5
    server web2 192.168.7.104:80 weight 1 check inter 3000 fall 2 rise 5
```

**url_param一致性hash配置示例**
```bash
listen web_host
    bind 192.168.7.101:80,:8801-8810,192.168.7.101:9001-9010
    mode http
    log global
    balance url_param name,age #支持对单个及多个url_param 值hash
    hash-type consistent
    server web1 192.168.7.103:80 weight 1 check inter 3000 fall 2 rise 5
    server web2 192.168.7.104:80 weight 1 check inter 3000 fall 2 rise 5
```

### 4. hdr
针对用户每个http头部(header)请求中的指定信息做hash，此处由 name 指定的http首部将会被取出并做hash计算，然后由服务器总权重相除以后派发至某挑出的服务器，假如无有效的值，则会使用默认的轮询调度。

**hdr取模法配置示例**
```bash
listen web_host
    bind 192.168.7.101:80,:8801-8810,192.168.7.101:9001-9010
    mode http
    log global
    balance hdr(User-Agent)
    server web1 192.168.7.103:80 weight 1 check inter 3000 fall 2 rise 5
    server web2 192.168.7.104:80 weight 1 check inter 3000 fall 2 rise 5
```

**hdr一致性hash配置示例**
```bash
listen web_host
    bind 192.168.7.101:80,:8801-8810,192.168.7.101:9001-9010
    mode http
    log global
    balance hdr(User-Agent)
    hash-type consistent
    server web1 192.168.7.103:80 weight 1 check inter 3000 fall 2 rise 5
    server web2 192.168.7.104:80 weight 1 check inter 3000 fall 2 rise 5
```

### 5. rdp-cookie
rdp-cookie对远程桌面的负载，使用cookie保持会话

**rdp-cookie取模法配置示例**
```bash
listen RDP
    bind 192.168.7.101:3389
    balance rdp-cookie
    mode tcp
    server rdp0 172.18.132.20:3389 check fall 3 rise 5 inter 2000 weight 1
```

**rdp-cookie一致性hash配置示例**
```bash
listen RDP
    bind 192.168.7.101:3389
    balance rdp-cookie
    hash-type consistent
    mode tcp
    server rdp0 172.18.132.20:3389 check fall 3 rise 5 inter 2000 weight 1
```

**基于iptables实现**
```bash
[root]# vim /etc/sysctl.conf
[root]# sysctl -p
net.ipv4.ip_forward = 1

[root]# iptables -t nat -A PREROUTING -d 192.168.7.101 -p tcp --dport 3389 -j DNAT --todestination 172.18.139.20:3389
[root]# iptables -t nat -A POSTROUTING -s 192.168.0.0/21 -j SNAT --to-source 192.168.7.101
```

### 6. random
在1.9版本开始增加一个叫做random的负载平衡算法，其基于一个随机数作为一致性hash的key，随机负载平衡对于大型服务器场或经常添加或删除服务器非常有用，因为它可以避免在这种情况下由roundrobin或leastconn导致的锤击效应。

**random配置实例**
```bash
listen web_host
    bind 192.168.7.101:80,:8801-8810,192.168.7.101:9001-9010
    mode http
    log global
    balance random
    server web1 192.168.7.103:80 weight 1 check inter 3000 fall 2 rise 5
    server web2 192.168.7.104:80 weight 1 check inter 3000 fall 2 rise 5
```

---

**算法总结**
算法 | TCP/HTTP | 动/静态
- | - | -
static-rr | tcp/http |  静态
first | tcp/http  | 静态
roundrobin | tcp/http  | 动态
leastconn | tcp/http  | 动态
random | tcp/http  | 动态
source | tcp/http | 
Uri | http | 
url_param | http  | 取决于hash_type是否consistent
hdr | http | 
rdp-cookie | tcp | 

**算法使用场景**
各算法 | 使用场景
- | -
first  | 使用较少
static-rr  | 做了session共享的web集群
roundrobin  | 
random  | 
leastconn | 数据库
source | 基于客户端公网IP的会话保持
Uri  | 缓存服务器，CDN服务商，蓝汛、百度、阿里云、腾讯
url_param |
hdr  | 基于客户端请求报文头部做下一步处理
rdp-cookie | 很少使用

-- 

### 4层与7层的区别
四层：IP+PORT转发
七层：协议+内容交换

**四层负载：**
在四层负载设备中，把client发送的报文目标地址(原来是负载均衡设备的IP地址)，根据均衡设备设置的选择web服务器的规则选择对应的web服务器IP地址，这样client就可以直接跟此服务器建立TCP连接并发送数据。

**七层代理：**
七层负载均衡服务器起了一个反向代理服务器的作用，服务器建立一次TCP连接要三次握手，而client要访问webserver要先与七层负载设备进行三次握手后建立TCP连接，把要访问的报文信息发送给七层负载均衡；然后七层负载均衡再根据设置的均衡规则选择特定的webserver，然后通过三次握手与此台webserver建立TCP连接，然后webserver把需要的数据发送给七层负载均衡设备，负载均衡设备再把数据发送给client；所以，七层负载均衡设备起到了代理服务器的作用。

--- 

# IP透传：
web服务器中需要记录客户端的真实IP地址，用于做访问统计、安全防护、行为分析、区域排行等场景

## 四层IP透传

haproxy 配置：
```bash
listen web_prot_http_nodes
    bind 192.168.7.101:80
    mode tcp
    balance roundrobin
    server web1 blogs.studylinux.net:80 send-proxy check inter 3000 fall 3 rise 5
```
nginx配置：
```bash
server {
    listen 80 proxy_protocol;
    #listen 80;
    server_name blogs.studylinux.net;
......
}
```

## 七层IP透传：
当haproxy工作在七层的时候，如何透传客户端真实IP至后端服务器
```bash
defaults
    option forwardfor
#或者：
    option forwardfor header X-Forwarded-xxx #自定义传递IP参数,后端web服务器写X-Forwardedxxx，

#如果写option forwardfor则后端服务器web格式为X-Forwarded-For
#listen配置：
listen web_host
    bind 192.168.7.101:80
    mode http
    log global
    balance random
    server web1 192.168.7.103:80 weight 1 check inter 3000 fall 2 rise 5
    server web2 192.168.7.104:80 weight 1 check inter 3000 fall 2 rise 5
```

web服务器日志格式配置
配置web服务器，记录负载均衡透传的客户端IP地址
```bash
#apache 配置：
LogFormat "%{X-Forwarded-For}i %a %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-
Agent}i\"" combined

#tomcat 配置：
pattern='%{X-Forwarded-For}i %l %T %t &quot;%r&quot; %s %b &quot;%{User-
Agent}i&quot;'/>

#nginx 日志格式：
log_format main '"$http_x_forwarded_For" - $remote_user [$time_local] "$request"'
                '$status $body_bytes_sent "$http_referer" '
                '"$http_user_agent" ';
```

