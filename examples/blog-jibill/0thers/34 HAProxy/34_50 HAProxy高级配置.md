[toc]

# 基于cookie的会话保持
```bash
cookie name [ rewrite | insert | prefix ][ indirect ] 
            [ nocache ][ postonly ] [preserve ][ httponly ] 
            [ secure ][ domain ]* [ maxidle <idle> ][ maxlife ]

name     # cookie 的key名称，用于实现持久连接
insert   # 如果没有就插入新的cookie
indirect # 不会向客户端发送服务器已经处理过请求的cookie信息
nocache  # 当client和hapoxy之间有缓存时，不缓存cookie
```
示例：
```bash
listen web_host
    bind 192.168.7.101:80
    mode http
    log global
    balance roundrobin
    cookie SERVER-COOKIE insert indirect nocache
    server web1 192.168.7.103:80 cookie web1 check inter 3000 fall 3 rise 5
    server web2 192.168.7.104:80 cookie web2 check inter 3000 fall 3 rise 5
```

---

# HAProxy状态页
```bash
stats enable #基于默认的参数启用stats page
stats hide-version #隐藏版本
stats refresh <delay> #设定自动刷新时间间隔
stats uri <prefix> #自定义stats page uri，默认值：/haproxy?stats
stats realm <realm> #账户认证时的提示信息，示例：stats realm : HAProxy\ Statistics
stats auth <user>:<passwd> #认证时的账号和密码，可使用多次，默认：no authentication
stats admin { if | unless } <cond> #启用stats page中的管理功能
```

示例：
```bash
listen stats
    bind 0.0.0.0:9009
    stats enable
    #stats hide-version
    stats uri /haproxy-status
    stats realm HAPorxy\ Stats\ Page
    stats auth haadmin:123456
    stats auth admin:123456
    #stats refresh 30s
    #stats admin if TRUE
```

---

# 报文修改
```bash
在请求报文尾部添加指定首部
reqadd <string> [{if | unless} <cond>]
从请求报文中删除匹配正则表达式的首部
reqdel <search> [{if | unless} <cond>]
reqidel <search> [{if | unless} <cond>]
在响应报文尾部添加指定首部
rspadd <string> [{if | unless} <cond>]
示例：
rspadd X-Via:\ HAPorxy

从响应报文中删除匹配正则表达式的首部
rspdel <search> [{if | unless} <cond>]
rspidel <search> [{if | unless} <cond>]
示例：
rspidel server.* #从相应报文删除server信息
rspidel X-Powered-By:.* #从响应报文删除X-Powered-By信息
```

---

# HAProxy日志配置
```bash
在global配置项定义：
    log 127.0.0.1 local{1-7} info 
    #基于syslog记录日志到指定设备，级别有(err、warning、info、debug)

listen web_port
    bind 127.0.0.1:80
    mode http
    log global
    server web1 127.0.0.1:8080 check inter 3000 fall 2 rise 5
```

Rsyslog配置
```bash
vim /etc/rsyslog.conf
    $ModLoad imudp
    $UDPServerRun 514
    local3.* /var/log/haproxy.log
```
自定义日志格式
```bash
capture cookie <name> len <length> #捕获请求和响应报文中的 cookie并记录日志
capture request header <name> len <length> #捕获请求报文中指定的首部内容和长度并记录日志
capture response header <name> len <length> #捕获响应报文中指定的内容和长度首部并记录日志
示例：
capture request header Host len 256
capture request header User-Agent len 512
capture request header Referer len 15
```

配置示例
```bash
listen web_host
    bind 192.168.7.101:80
    mode http
    balance roundrobin
    log global
    option httplog #日志格式选项
    capture request header X-Forwarded-For len 15
    capture request header User-Agent len 512
    cookie SERVER-COOKIE insert indirect nocache
    server web1 192.168.7.103:80 cookie web1 check inter 3000 fall 3 rise 5
    server web2 192.168.7.104:80 cookie web2 check inter 3000 fall 3 rise 5
```

---

# 压缩功能
```bash
#启用http协议中的压缩机制，常用算法有gzip deflate
compression algo 
#调试使用的压缩方式
identity 
#常用的压缩方式，与各浏览器兼容较好
gzip 
#有些浏览器不支持
deflate 
#新出的压缩方式
raw-deflate 
#要压缩的文件类型
compression type 
```
配置示例
```bash
listen web_host
    bind 192.168.7.101:80
    mode http
    balance roundrobin
    log global
    option httplog
    #capture request header X-Forwarded-For len 15
    #capture request header User-Agent len 512
    compression algo gzip deflate
    compression type compression type text/plain text/html text/css text/xml
    text/javascript application/javascript
    cookie SERVER-COOKIE insert indirect nocache
    server web1 192.168.7.103:80 cookie web1 check inter 3000 fall 3 rise 5
    server web2 192.168.7.104:80 cookie web2 check inter 3000 fall 3 rise 5
```

---

# web服务器状态监测

```bash
option httpchk
option httpchk <uri>
option httpchk <method> <uri>
option httpchk <method> <uri> <version>
```

**三种状态监测方式**
1. 基于四层的传输端口做状态监测
2. 基于指定URI 做状态监测
3. 基于指定URI的request请求头部内容做状态监测

配置示例
```bash
listen web_host
    bind 192.168.7.101:80
    mode http
    balance roundrobin
    log global
    option httplog
    #option httpchk GET /app/monitor/check.html HTTP/1.0
    option httpchk HEAD /app/monitor/check.html HTTP/1.0\r\nHost:\ 192.168.7.102
    cookie SERVER-COOKIE insert indirect nocache
    server web1 192.168.7.103:80 cookie web1 check inter 3000 fall 3 rise 5
    server web2 192.168.7.104:80 cookie web2 check inter 3000 fall 3 rise 5
```

---

# ACL
格式：
```bash
acl <aclname> <criterion> [flags] [operator] [<value>]
acl   名称      匹配规范   匹配模式 具体操作符 操作对象类型
```
`<aclname>`
```bash
acl image_service hdr_dom(host) -i img.magedu.com
ACL名称，可以使用大字母A-Z、小写字母a-z、数字0-9、冒号：、点.、中横线和下划线，并且严格区分大小写，必须Image_site和image_site完全是两个acl。
```
`<criterion>`
```bash
hdr（[<name> [，<occ>]]）#完全匹配字符串
hdr_beg（[<name> [，<occ>]]）#前缀匹配
hdr_dir（[<name> [，<occ>]]）#路径匹配
hdr_dom（[<name> [，<occ>]]）#域匹配
hdr_end（[<name> [，<occ>]]）#后缀匹配
hdr_len（[<name> [，<occ>]]）#长度匹配
hdr_reg（[<name> [，<occ>]]）#正则表达式匹配
hdr_sub（[<name> [，<occ>]]）#子串匹配
dst         # 目标IP
dst_port    # 目标PORT
src         # 源IP
src_port    # 源PORT

示例：
hdr <string>    #用于测试请求头部首部指定内容
hdr_dom(host)   #请求的host名称，如 www.magedu.com
hdr_beg(host)   #请求的host开头，如 www. img. video. download. ftp.
hdr_end(host)   #请求的host结尾，如 .com .net .cn
path_beg        #请求的URL开头，如/static、/images、/img、/css
path_end        #请求的URL中资源的结尾，如 .gif .png .css .js .jpg .jpeg
```

`[flags]`
```bash
-i  #不区分大小写
-m  #使用指定的pattern匹配方法
-n  #不做DNS解析
-u  #禁止acl重名，否则多个同名ACL匹配或关系
```

`[operator]` 
```bash
整数比较：eq、ge、gt、le、lt
字符比较：
- exact match (-m str) :字符串必须完全匹配模式
- substring match (-m sub) :在提取的字符串中查找模式，如果其中任何一个被发现，ACL将匹配
- prefix match (-m beg) :在提取的字符串首部中查找模式，如果其中任何一个被发现，ACL将匹配
- suffix match (-m end) :将模式与提取字符串的尾部进行比较，如果其中任何一个匹配，则ACL进行匹配
- subdir match (-m dir) :查看提取出来的用斜线分隔（“/”）的字符串，如果其中任何一个匹配，则
ACL进行匹配
- domain match (-m dom) :查找提取的用点（“.”）分隔字符串，如果其中任何一个匹配，则ACL进行匹配
```

`[<value>]`
```bash
The ACL engine can match these types against patterns of the following types :
- Boolean #布尔值
- integer or integer range #整数或整数范围，比如用于匹配端口范围
- IP address / network #IP地址或IP范围, 192.168.0.1 ,192.168.0.1/24
- string
exact –精确比较
substring—子串 www.magedu.com
suffix-后缀比较
prefix-前缀比较
subdir-路径， /wp-includes/js/jquery/jquery.js
domain-域名，www.magedu.com
- regular expression #正则表达式
- hex block #16进制
```

## ACL调用方式
```bash
- 与：隐式（默认）使用
- 或：使用“or” 或 “||”表示
- 否定：使用“!“ 表示

示例：
if valid_src valid_port #与关系
if invalid_src || invalid_port #或
if ! invalid_src #非
```

---
## ACL示例

ACL示例1-域名匹配
```bash
listen web_host
    bind 192.168.7.101:80
    mode http
    balance roundrobin
    log global
    option httplog

    acl web_host hdr_dom(host) www.magedu.net

    use_backend magedu_host if web_host
    default_backend default_web

backend magedu_host
    mode http
    server web1 192.168.7.103 check inter 2000 fall 3 rise 5

backend default_web
    mode http
    server web1 192.168.7.104:80 check inter 2000 fall 3 rise 5
```

ACL示例2-基于源IP或子网调度访问
```bash
listen web_host
    bind 192.168.7.101:80
    mode http
    balance roundrobin
    log global
    option httplog
    acl ip_range_test src 172.18.0.0/16 192.168.7.103
    use_backend magedu_host if ip_range_test
    default_backend default_web

backend magedu_host
    mode http
    server web1 192.168.7.103 check inter 2000 fall 3 rise 5

backend default_web
    mode http
    server web1 192.168.7.104:80 check inter 2000 fall 3 rise 5
```

ACL示例3-基于源IP或子网调度访问
```bash
listen web_host
    bind 192.168.7.101:80
    mode http
    balance roundrobin
    log global
    option httplog
    acl ip_range_test src 172.18.0.0/16 192.168.7.103
    use_backend magedu_host if ip_range_test
    default_backend default_web

backend magedu_host
    mode http
    server web1 192.168.7.103 check inter 2000 fall 3 rise 5

backend default_web
    mode http
    server web1 192.168.7.104:80 check inter 2000 fall 3 rise 5
```
ACL示例4-基于源地址的访问控制
```bash
listen web_host
    bind 192.168.7.101:80
    mode http
    balance roundrobin
    log global
    option httplog
    acl block_test src 192.168.7.103 192.168.0.0/24
    block if block_test
    default_backend default_web

backend magedu_host
    mode http
    server web1 192.168.7.103 check inter 2000 fall 3 rise 5

backend default_web
    mode http
    server web1 192.168.7.104:80 check inter 2000 fall 3 rise 5
```
ACL示例5-匹配浏览器类型
```bash
listen web_host
    bind 192.168.7.101:80
    mode http
    balance roundrobin
    log global
    option httplog
    acl web_host hdr_dom(host) www.magedu.net
    use_backend magedu_host if web_host
    acl redirect_test hdr(User-Agent) -m sub -i "Mozilla/5.0 (Windows NT 6.1; WOW64;
    Trident/7.0; rv:11.0) like Gecko"
    redirect prefix http://192.168.7.103 if redirect_test
    default_backend default_web

backend magedu_host
    mode http
    server web1 192.168.7.103 check inter 2000 fall 3 rise 5

backend default_web
    mode http
    server web1 192.168.7.104:80 check inter 2000 fall 3 rise 5
```
ACL示例6-基于文件后缀名实现动静分离
```bash
listen web_host
    bind 192.168.7.101:80
    mode http
    balance roundrobin
    log global
    option httplog
    acl php_server path_end -i .php
    use_backend php_server_host if php_server
    acl image_server path_end -i .jpg .png .jpeg .gif
    use_backend image_server_host if image_server
    default_backend default_web

backend php_server_host
    mode http
    server web1 192.168.7.103 check inter 2000 fall 3 rise 5

backend image_server_host
    mode http
    server web1 192.168.7.104 check inter 2000 fall 3 rise 5

backend default_web
    mode http
    server web1 192.168.7.102:80 check inter 2000 fall 3 rise 5
```

ACL-匹配访问路径实现动静分离
```bash
listen web_host
    bind 192.168.7.101:80
    mode http
    balance roundrobin
    log global
    option httplog
    acl static_path path_beg -i /static /images /javascript
    use_backend static_path_host if static_path
    default_backend default_web
    
backend static_path_host
    mode http
    server web1 192.168.7.104 check inter 2000 fall 3 rise 5
backend default_web
    mode http
    server web1 192.168.7.102:80 check inter 2000 fall 3 rise 5
```

ACL示例-基于ACL的HTTP访问控制
```bash
listen web_host
bind 192.168.7.101:80
mode http
balance roundrobin
log global
option httplog
acl static_path path_beg -i /static /images /javascript
use_backend static_path_host if static_path
acl badguy_deny src 192.168.7.102
http-request deny if badguy_deny
http-request allow
default_backend default_web
backend static_path_host
mode http
server web1 192.168.7.104 check inter 2000 fall 3 rise 5
backend default_web
mode http
server web1 192.168.7.102:80 check inter 2000 fall 3 rise 5
```

预定义ACL

ACL name | Equivalent to |  Usage
- | - | -
FALSE  | always_false  | never match
HTTP  | req_proto_http  | match if protocol is valid HTTP
HTTP_1.0  | req_ver 1.0  | match HTTP version 1.0
HTTP_1.1  | req_ver 1.1  | match HTTP version 1.1
HTTP_CONTENT  | hdr_val(content-length) gt 0  | match an existing content-length
HTTP_URL_ABS  | url_reg ^[^/:]*://  | match absolute URL with scheme
HTTP_URL_SLASH  | url_beg /  | match URL beginning with "/"
HTTP_URL_STAR  | url *  | match URL equal to "*"
LOCALHOST  | src 127.0.0.1/8  | match connection from local host
METH_CONNECT  | method CONNECT  | match HTTP CONNECT method
METH_DELETE  | method DELETE  | match HTTP DELETE method
METH_GET  | method GET HEAD  | match HTTP GET or HEAD method
METH_HEAD  | method HEAD  | match HTTP HEAD method
METH_OPTIONS |  method OPTIONS  | match HTTP OPTIONS method
METH_POST  | method POST  | match HTTP POST method
METH_PUT |  method PUT  | match HTTP PUT method
METH_TRACE  | method TRACE  | match HTTP TRACE method
RDP_COOKIE  | req_rdp_cookie_cnt gt 0  | match presence of an RDP cookie
REQ_CONTENT  | req_len gt 0  | match data in the request buffer
TRUE  | always_true  | always match
WAIT_END  | wait_end |  wait for end of content analysis

预定义ACL的使用
```bash
acl static_path path_beg -i /static /images /javascript
use_backend static_path_host if HTTP_1.1 TRUE static_path
```
