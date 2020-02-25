[toc]

# 配置详解：
HAPrpxy的配置文件：/etc/haproxy/haproxy.cfg
由两大部分组成，分别是**global**和**proxies**部分。
1. global  : 全局配置段
```bash
进程及安全配置相关的参数
性能调整相关参数
Debug参数
```
2. proxies : 代理配置段,有多个子段
```bash
defaults    为frontend, backend, listen提供默认配置
listen      同时拥有前端和后端配置

#下面不常用
frontend    前端，相当于nginx中的server {}
backend     后端，相当于nginx中的upstream {}
```

---

## global配置参数：
官方文档：https://cbonte.github.io/haproxy-dconv/2.0/intro.html
```c
global

    #锁定运行目录
    chroot  /usr/local/haproxy 

    #定义全局的syslog服务器；最多可以定义两个
    log 127.0.0.1 local3 info 

    #指定pid文件路径
    pidfile /var/run/haproxy.pid

    #以守护进程运行
    deamon  

    #每个haproxy进程的最大并发连接数
    maxconn 4000

    #运行haproxy的用户身份
    user haproxy
    group haproxy
    #或者
    uid 99
    gid 99
    /********************可选项********************/
    #开启的haproxy进程数，与CPU保持一致
    nbproc 4
    #CPU绑定
    cpu-map 1 0
    cpu-map 2 1
    cpu-map 3 2
    cpu-map 4 3

    #指定每个haproxy进程开启的线程数，默认为每个进程一个线程
    nbthread 1

    #socket文件1，mode文件的权限，level等级，process多进程时使用，绑定socket文件
    stats socket /var/lib/haproxy/haproxy.sock1 mode 600 level admin process 1
    #socket文件2
    stats socket /var/lib/haproxy/haproxy.sock2 mode 600 level admin process 2

    #每个haproxy进程ssl最大连接数,用于haproxy配置了证书的场景下
    maxsslconn 

    #每个进程每秒创建的最大连接数量
    maxconnrate 200

    #后端server状态check随机提前或延迟百分比时间，建议2-5(20%-50%)之间
    spread-checks 3
```

---

### defaults配置：
为frontend, backend, listen提供默认配置

```bash
defaults
    #默认工作类型
    mode http 
    #定义日志,global表示根据全局定义
    log  global 

    #开启与客户端的会话保持
    option http-keep-alive 
    #透传客户端真实IP至后端web服务器
    option forwardfor 

    #当server Id对应的服务器挂掉后，强制定向到其他健康的服务器
    option redispatch 
    #当服务器负载很高的时候，自动结束掉当前队列处理比较久的链接
    option abortonclose 

    #客户端请求到后端server的最长连接等待时间(TCP之前)
    timeout connect 120s 
    #客户端请求到后端服务端的超时超时时长（TCP之后）
    timeout server 600s 
    #与客户端的最长非活动时间
    timeout client 600s 

    #session 会话保持超时时间，范围内会转发到相同的后端服务器
    timeout http-keep-alive 120s 
    #对后端服务器的检测超时时间
    timeout check 5s 
```

### listen：
使用listen替换frontend和backend的配置方式：
```bash
listen WEB_PORT_80
    bind 192.168.7.102:80
    mode http
    balance <算法>
    option forwardfor
    server web1 192.168.7.101:80 check inter 3000 fall 3 rise 5
    server web2 192.168.7.101:80 check inter 3000 fall 3 rise 5
```

### frontend配置
前端，相当于nginx中的server {}
```bash
#指定HAProxy的监听地址，可同时监听多个IP或端口
bind [<address>]:<port_range> [, ...] [param*]
 

frontend WEB_PORT
    bind :80,:8080
    bind 192.168.7.102:10080,:8801-8810,192.168.7.101:9001-9010
    mode http/tcp #指定负载协议类型
    use_backend backend_name #调用的后端服务器组名称
```

### backend配置
定义一组后端服务器，backend服务器将被frontend进行调用。
```bash
#指定负载协议类型
mode http/tcp 
#配置选项
option 
#定义后端real server
server <name> <ip:port>
    #默认为1，最大值为256，0表示不参与负载均衡
    weight 
    #将后端服务器标记为备份状态
    backup 
    #将后端服务器标记为不可用状态
    disabled 
    #将请求临时重定向至其它URL，只适用于http模式
    redirect prefix http://www.magedu.net/ 
    #后端server的最大并发连接数
    maxconn <maxconn>
    #server的连接数达到上限后的后援队列长度
    backlog <backlog>
    #对指定real进行健康状态检查，默认不开启
    check 
        #可指定的健康状态监测IP
        addr IP 
        #指定的健康状态监测端口
        port num 
        #健康状态检查间隔时间，默认2000 ms
        inter num 
        #后端服务器失效检查次数，默认为3
        fall num 
        #后端服务器从下线恢复检查次数，默认为2
        rise num 

```

-- -

**frontend+backend配置实例：**
```bash
frontend WEB_PORT_80
    bind 192.168.7.248:80
    mode http
    use_backend web_prot_http_nodes

backend web_prot_http_nodes
    mode http
    option forwardfor
    server 192.168.7.101 192.168.7.101:8080 check inter 3000 fall 3 rise 5
    server 192.168.7.102 192.168.7.102:8080 check inter 3000 fall 3 rise 5
```
