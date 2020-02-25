@[TOC](本章内容)

本章节内容全部实验在这：[一步一步_DNS域名解析BIND实验]()
# DNS
>域名系统（英文：Domain Name System，缩写：DNS）是互联网的一项服务。它作为将域名和IP地址相互映射的一个分布式数据库，能够使人更方便地访问互联网。DNS使用TCP和UDP端口53。当前，对于每一级域名长度的限制是63个字符，域名总长度则不能超过253个字符
>>BIND：*Bekerley Internat Name Domain*，是目前使用最广泛的DNS程序

在每个电脑上，都会有一个本地名称解析配置文件：hosts。比如说windows存放在`C:\Windows\System32\drivers\etc\hosts`。在centos上，存放在`/etc/hosts`。格式像下面这样。
```bash
122.10.117.2 www.magedu.com
93.46.8.89 www.google.com
```

对于端口号53/tcp：DNS之间同步用
对于端口号53/udp：客户端查询域名用(DNS同步也用)
## DNS域名
域名可以分为：
1. 根域
2. 一级域名：(TLD)Top Level Domain，也叫顶级域
像：.com, .edu, .mil, .gov, .net
有这么三类：组织域、国家域(.cn, .ca, .hk, .tw)、反向域
3. 二级域名
像：baidu，
4. 三级域名
...

5. 域名最多127级域名
>全球根服务器：13组服务器
>根服务器主要用来管理互联网的主目录，全世界IPv4根服务器只有13台（这13台IPv4根域名服务器名字分别为“A”至“M”），1个为主根服务器在美国。其余12个均为辅根服务器，其中9个在美国，欧洲2个，位于英国和瑞典，亚洲1个位于日本。

> ICANN（The Internet Corporation for Assigned Names and Numbers）互联网名称与数字地址分配机构，负责在全球范围内对互联网通用顶级域名（gTLD）以及国家和地区顶级域名（ccTLD）系统的管理、以及根服务器系统的管理

## DNS域名结构
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190630085417821.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

DNS解析
1. DNS查询类型：
[递归查询](https://baike.baidu.com/item/%E9%80%92%E5%BD%92%E6%9F%A5%E8%AF%A2)：客户端向自己所指定的DNS服务器请求的过程，是递归的，也就是说客户端向服务器请求时，服务器返回的必须是一个明确的结果，要么找到，要么找不到

[迭代查询](https://baike.baidu.com/item/%E8%BF%AD%E4%BB%A3%E6%9F%A5%E8%AF%A2)：是指当客户端请求到达直接指定的DNS服务器后，如果该服务器上没有缓存相关的条目，则需要向根域请求，根域返回给DNS服务器一个顶级域的地址，然后DNS服务器又根据返回的顶级域地址去找，顶级域又返回一个二级域的地址，而后，DNS服务器又向二级域去请求，追踪返回出一个明确的解析结果给DNS服务器，这个DNS一级一级去查找的过程就是迭代查询



## DNS服务器类型
+ DNS服务器的类型：
    1. 主DNS服务器：管理和维护所负责解析的域内解析库的服务器
    2. 从DNS服务器：从主服务器或从服务器“复制”（区域传输）解析库副本
    3. 缓存DNS服务器（转发器）


+ “通知”机制：主服务器解析库发生变化时，会主动通知从服务器

## 区域传输
+ 区域传输：
完全传输：传送整个解析库
增量传输：传递解析库变化的那部分内容
+ Domain: Fully Qualified Domain Name （全称域名）
正向：FQDN --> IP
反向: IP --> FQDN
+ 负责本地域名的正向和反向解析库
正向区域
反向区域

## DNS解析
+ Domain: Fully Qualified Domain Name （全称域名）
    1. 正向解析：FQDN --> IP
    2. 反向解析: IP --> FQDN
+ 一次完整的查询请求经过的流程：
Client --> hosts文件 --> DNS Service Local Cache(本地缓存) --> DNS Server (recursion递归) --> Server Cache(服务器缓存) --> iteration(迭代) --> 根 --> 顶级域名DNS --> 二级域名DNS…
+ 解析答案：
    1. **肯定答案**：有解析出来的结果
    2. **否定答案**：请求的条目不存在等原因导致无法返回结果
    3. **权威答案**：由直接负责的DNS服务器给出的答案，也就是给出的结果是自己负责解析域时，给出的答案
    4. **非权威答案**：给出的答案是缓存中的缓存下来的条目，此时因为缓存还在有效期，而后端真实的结果可能已经改变，但是由于有缓存，则依然用缓存响应请求，此时返回的就是非权威答案

## 资源记录

区域解析库：由众多RR(Resource Record)组成
+ 记录类型：A, AAAA, PTR, SOA, NS, CNAME, MX
    1. `SOA`：Start Of Authority，起始授权记录；一个区域解析库有且仅能有一个SOA记录，必须位于解析库的第一条记录
    2. `A`：internet Address，作用，FQDN --> IP
    3. `AAAA`：FQDN --> IPv6
    4. `PTR`：PoinTeR：IP --> FQDN
    5. `NS`：Name Server，专用于标明当前区域的DNS服务器
    6. `CNAME` ： Canonical Name，别名记录
    7. `MX`：Mail eXchanger，邮件交换器
    8. `TXT`：对域名进行标识和说明的一种方式，一般做验证记录时会使用此项，如：SPF（反垃圾邮件）记录，https验证等
    示例：_dnsauth TXT 2012011200000051qgs69bwoh4h6nht4n1h0lr038x

### 资源记录格式
先放出一个例子看看，下面还会对每一条记录详细的说明
+ 资源记录定义的格式：`name [TTL] IN rr_type value`

**序列号**：解析库版本号，主服务器解析库变化时，其序列递增
**刷新时间间隔**：从服务器从主服务器请求同步解析的时间间隔
**重试时间间隔**：从服务器请求同步失败时，再次尝试时间间隔
**过期时长**：从服务器联系不到主服务器时，多久后停止服务

```bash
$TTL 1D    #现有存在记录的缓存时长
#"@"表示"mage.com."这个域,"IN","SOA"是类型,"master"是表示主DNS服务器，最后是邮箱"@"用"."表示
@   IN SOA  master.mage.com. admin.mage.com. (           
                    0   ; serial   #序列号
                    1D  ; refresh  #刷新时间间隔
                    1H  ; retry    #重试时间间隔(从服务器更新失败时)
                    1W  ; expire   #过期时长(如果一直没有更新，将失效)
                    3H )    ; minimum   #3H表示不存在记录缓存时长
    NS  master          #NS，指定名称服务器
    A   127.0.0.1 
    AAAA    ::1 
master A 192.168.99.10 
@ MX 10 mailsrv     #邮件，别名mailsrv  
mailsrv A 192.168.88.111   #mailsrv记录 
ftp  A  1.1.1.1 
db A 2.2.2.2 
mail 86400 IN A 1.1.1.2 
www CNAME websrv 
websrv A 192.168.99.10 
websrv A 192.168.99.11 
$GENERATE 1-100 yourname$ A 10.0.0.$
#上面这条就是说你访问yourname88.mage.com就是10.0.0.88
```
注意：
(1) TTL可从全局继承 
(2) @可用于引用当前区域的名字 
(3) 同一个名字可以通过多条记录定义多个不同的值；此时DNS服务器会以轮询方式响应
(4) 同一个值也可能有多个不同的定义名字；通过多个不同的名字指向同一个值进行定义；此仅表示通过多个不同的名字可以找到同一个主机

#### SOA记录
+ name: 当前区域的名字，例如`magedu.com.`
+ value: 有多部分组成
(1) 当前区域的主DNS服务器的FQDN，也可以使用当前区域的名字；
(2) 当前区域管理员的邮箱地址；但地址中不能使用`@`符号，一般用`.`替换
例如：admin.magedu.com(即admin@magedu.com)
(3) 主从服务区域传输相关定义以及否定的答案的统一的TTL
例如：
```bash
magedu.com. 86400 IN SOA ns.magedu.com. nsadmin.magedu.com. (
2015042201 ; serial
2H ; refresh 
10M ; retry
1W ; expire 
1D ) ; minimum 
```

#### NS记录
+ name: 当前区域的名字
+ value: 当前区域的某DNS服务器的名字，例如ns.magedu.com.
注意：一个区域可以有多个NS记录
例如：
```bash
magedu.com. IN NS ns1.magedu.com.
magedu.com. IN NS ns2.magedu.com.
```
注意：
(1) TTL可从全局继承，所以最前面可以写条`@TTL 1D`，后面可以省略，下同
(2) 相邻的两个资源记录的name相同时，后续的可省略
(3) 对NS记录而言，任何一个ns记录后面的服务器名字，都应该在后续有一个A记录

#### MX记录
+ name: 当前区域的名字
+ value: 当前区域的某邮件服务器(smtp服务器)的主机名
+ 一个区域内，MX记录可有多个；但每个记录的value之前应该有一个数字(0-99)，表示此服务器的优先级；数字越小优先级越高
例如：
```bash
magedu.com. IN MX 10 mx1.magedu.com.
IN MX 20 mx2.magedu.com.
```
注意：对MX记录而言，任何一个MX记录后面的服务器名字，都应该在后续有一个A记录

#### A记录
+ name: 某主机的FQDN，例如：www.magedu.com.
+ value: 主机名对应主机的IPv4地址
例如：
```bash
www.magedu.com.  IN  A  1.1.1.1
www.magedu.com.  IN  A  2.2.2.2
mx1.magedu.com.  IN  A  3.3.3.3
mx2.magedu.com.  IN  A  4.4.4.4
*.magedu.com. IN A 5.5.5.5
magedu.com. IN A 6.6.6.6
```
注意：避免用户写错名称时给错误答案，可通过泛域名解析(*.magedu.com)进行解析至某特定地址

#### AAAA记录
1. AAAA:
    + name: FQDN
    + value: IPv6
#### PTR记录
2. PTR:
    + name: IP，有特定格式，把IP地址反过来写，1.2.3.4，要写作4.3.2.1；而有特定后缀：in-addr.arpa.，所以完整写法为：4.3.2.1.in-addr.arpa.
    + value: FQDN

例如：
```basg
4.3.2.1.in-addr.arpa. IN PTR www.magedu.com.
```
如1.2.3为网络地址，可简写成：
```bash
4 IN PTR www.magedu.com.
```
注意：网络地址及后缀可省略；主机地址依然需要反着写

#### CNAME别名记录
1. CNAME：
    + name: 别名的FQDN
    + value: 真正名字的FQDN

例如：
```bash
www.magedu.com. IN CNAME websrv.magedu.com.
```

## 子域
子域授权：每个域的名称服务器，都是通过其上级名称服务器在解析库进行授权，类似根域授权TLD(顶级域名)：
```bash
#这里是根域的解析库
.com. IN NS ns1.com.
.com. IN NS ns2.com.
ns1.com. IN A 2.2.2.1
ns2.com. IN A 2.2.2.2
``` 
**上面表示：** 你想找关于任何`.com`结尾的，可以去2.2.2.1或者2.2.2.2的DNS服务器去找。比如`magedu.com`这个地址，就得去找`.com`的DNS服务器，而在`.com`的名称服务器上的解析库中有这么个资源记录：
```bash
magedu.com. IN NS ns1.magedu.com.
magedu.com. IN NS ns2.magedu.com.
               NS ns3.magedu.com.
ns1.magedu.com. IN A 3.3.3.1
ns2.magedu.com. IN A 3.3.3.2
ns3.magedu.com. IN A 3.3.3.3
```
这表示你想访问`magedu.com`就在3.3.3.3，你还想找
glue record：粘合记录，父域授权子域的记录



# BIND
1. DNS服务器软件：bind(最常用)，powerdns，unbound
2. BIND相关程序包：yum list all bind*
bind：服务器
bind-libs：相关库
bind-utils: 客户端
bind-chroot: /var/named/chroot/
3. BIND程序名：named

## bind服务器
服务脚本和名称：/etc/rc.d/init.d/named /usr/lib/systemd/system/named.service
主配置文件：/etc/named.conf, /etc/named.rfc1912.zones, /etc/rndc.key
解析库文件：/var/named/ZONE_NAME.ZONE
注意：
(1) 一台物理服务器可同时为多个区域提供解析
(2) 必须要有根区域文件；named.ca
(3) 应该有两个（如果包括ipv6的，应该更多）实现localhost和本地回环地址的解析库
rndc：remote name domain controller，
默认与bind安装在同一主机，且只能通过127.0.0.1连接named进程
提供辅助性的管理功能；953/tcp

## 配置文件
主配置文件：
全局配置：options {};
日志子系统配置：logging {};
区域定义：本机能够为哪些zone进行解析，就要定义哪些zone
zone "ZONE_NAME" IN {};
注意：任何服务程序如果期望其能够通过网络被其它主机访问，至少应该监听在一个能与外部主机通信的IP地址上
缓存名称服务器的配置：
监听外部地址即可
dnssec: 建议关闭dnssec，设为no

## 配置主DNS服务器
主DNS名称服务器：
(1) 在主配置文件中定义区域
```bash
zone "ZONE_NAME" IN {
type {master|slave|hint|forward};
file "ZONE_NAME.zone";
};
```
(2) 定义区域解析库文件
出现的内容
宏定义
资源记录
主配置文件语法检查：
named-checkconf
解析库文件语法检查：
named-checkzone "magedu.com" /var/named/magedu.com.zone
配置生效：
rndc reload 或 service named reload


## 主区域示例
```bash
$TTL 86400
$ORIGIN magedu.com.
@ IN SOA ns1.magedu.com. admin.magedu.com (
2015042201
1H
5M
7D
1D )
IN NS ns1
IN NS ns2
IN MX 10 mx1
IN MX 20 mx2
ns1 IN A 172.16.100.11
ns2 IN A 172.16.100.12
mx1 IN A 172.16.100.13
mx2 IN A 172.16.100.14
websrv IN A 172.16.100.11
websrv IN A 172.16.100.12
www IN CNAME websrv
```

## 测试命令：dig
`dig [-t type] name [@SERVER] [query options]`
dig只用于测试dns系统，不会查询hosts文件进行解析
1. 查询选项：
+[no]trace：跟踪解析过程 : dig +trace magedu.com
+[no]recurse：进行递归解析

2. 测试反向解析：
```bash
dig -x IP = dig –t ptr reverseip.in-addr.arpa
```

3. 模拟区域传送：
```bash
dig -t axfr ZONE_NAME @SERVER
dig -t axfr magedu.com @10.10.10.11
dig –t axfr 100.1.10.in-addr.arpa @172.16.1.1
dig -t NS . @114.114.114.114
dig -t NS . @a.root-servers.net
```


##测试命令：host
```bash
host [-t type] name [SERVER]
host –t NS magedu.com 172.16.0.1
host –t soa magedu.com
host –t mx magedu.com
host –t axfr magedu.com
host 1.2.3.4
```

## nslookup命令： nslookup [-option] [name | -] [server]
•交互式模式：
`nslookup>`
server IP: 指明使用哪个DNS server进行查询
set q=RR_TYPE: 指明查询的资源记录类型
NAME: 要查询的名称



## 反向区域
反向区域：
区域名称：网络地址反写.in-addr.arpa.
`172.16.100. --> 100.16.172.in-addr.arpa.`
(1) 定义区域
```bash
zone "ZONE_NAME" IN {
type {master|slave|forward}；
file "网络地址.zone"
};
```
(2) 定义区域解析库文件
注意：不需要MX,以PTR记录为主

+ 反向区域示例
```bash
$TTL 86400
$ORIGIN 100.16.172.in-addr.arpa.
@ IN SOA ns1.magedu.com. admin.magedu.com. (
2015042201
1H
5M
7D
1D )
IN NS ns1.magedu.com.
IN NS ns2.magedu.com.
11 IN PTR ns1.magedu.com.
11 IN PTR www.magedu.com.
12 IN PTR mx1.magedu.com.
12 IN PTR www.magedu.com.
13 IN PTR mx2.magedu.com.
```

## rndc命令
rndc：
`rndc COMMAND`

COMMAND | 意义
-|-
reload |  重载主配置文件和区域解析库文件
reload zonename |  重载区域解析库文件
retransfer zonename |  手动启动区域传送，而不管序列号是否增加
notify zonename |  重新对区域传送发通知
reconfig |  重载主配置文件
querylog |  开启或关闭查询日志文件/var/log/message
trace |  递增debug一个级别
trace LEVEL |  指定使用的级别
notrace | 将调试级别设置为 0
flush | 清空DNS服务器的所有缓存记录

## 子域

子域授权：分布式数据库
定义一个子区域：
```bash
ops.magedu.com. IN NS ns1.ops.magedu.com.
ops.magedu.com. IN NS ns2.ops.magedu.com.
ns1.ops.magedu.com. IN A 1.1.1.1
ns2.ops.magedu.com. IN A 1.1.1.2
fin.magedu.com. IN NS ns1.fin.magedu.com.
fin.magedu.com. IN NS ns2.fin.magedu.com.
ns1.fin.magedu.com. IN A 3.1.1.1
ns2.fin.magedu.com. IN A 3.1.1.2
```

## 转发服务器
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190701114300247.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)
注意：被转发的服务器需要能够为请求者做递归，否则转发请求不予进行
(1) 全局转发: 对非本机所负责解析区域的请求，全转发给指定的服务器
```bash
Options {
forward first|only;  #first先转发，找不到就自己去根找。only只转发
forwarders { ip;};   #转到哪？
};
```
(2) 特定区域转发：仅转发对特定的区域的请求，比全局转发优先级高
```bash
zone "ZONE_NAME" IN {
type forward;
forward first|only;
forwarders { ip;};
};
```
注意：关闭dnssec功能
```bash
dnssec-enable no;
dnssec-validation no;
```

(3) bind中ACL
bind中基础的安全相关的配置：
acl: 把一个或多个地址归并为一个集合，并通过一个统一的名称调用
格式：
```bash
acl acl_name {
ip;
net/prelen;
……
};
```
示例：
```bash
acl mynet {
172.16.0.0/16;
10.10.10.10;
};
```

bind有四个内置的acl:

    none 没有一个主机
    any 任意主机
    localhost 本机
    localnet 本机的IP同掩码运算后得到的网络地址
注意：只能先定义后使用；因此一般定义在配置文件中，处于options的前面

(4)访问控制
`allow-query {}`： 允许查询的主机；白名单
`allow-transfer {}`：允许区域传送的主机；白名单
`allow-recursion {}`: 允许递归的主机,建议全局使用
`allow-update {}`: 允许更新区域数据库中的内容


- - -

# CDN （Content Delivery Network）
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190701140532931.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)


+ **GSLB：Global Server Load Balance全局负载均衡**
(1). GSLB是对服务器和链路进行综合判断来决定由哪个地点的服务器来提供服务，实现异地服务器群服务质量的保证
(2). GSLB主要的目的是在整个网络范围内将用户的请求定向到最近的节点（或者区域）
(3). GSLB分为基于DNS实现、基于重定向实现、基于路由协议实现，其中最通用的是基于DNS解析方式

+ **GSLB和CDN**
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190701142415143.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

# bind view

+ CDN: Content Delivery Network内容分发网络
+ 服务商：蓝汛，网宿，帝联等
+ 智能DNS：`dnspod`、`dns.la`
+ view视图：实现智能DNS
    1. 一个bind服务器可定义多个view，每个view中可定义一个或多个zone
    2. 每个view用来匹配一组客户端
    3. 多个view内可能需要对同一个区域进行解析，但使用不同的区域解析库文件
+ 注意：
(1) 一旦启用了view，所有的zone都只能定义在view中
(2) 仅在允许递归请求的客户端所在view中定义根区域
(3) 客户端请求到达时，是自上而下检查每个view所服务的客户端列表
+ 格式：
```bash
view VIEW_NAME {
match-clients { testacl; };
zone “magedu.com” {
type master;
file “magedu.com.zone”;
};
include “/etc/named.rfc1912.zones”;
};
```

## DNS排错

1. 可使用dig +trace排错，可能是网络和防火墙导致
NXDOMAIN：The queried name does not exist in the zone.
2. 可能是CNAME对应的A记录不存在导致
REFUSED：The nameserver refused the client's DNS request due to policy restrictions.
3. 可能是DNS策略导致
4. NOERROR不代表没有问题，也可以是过时的记录
5. 查看是否为权威记录，flags:aa标记判断
6. 被删除的记录仍能返回结果，可能是因为*记录存在
如：*.example.com． IN A 172.25.254.254
7. 注意“.”的使用
9. 避免CNAME指向CNAME记录，可能产生回环
    test.example.com. IN CNAME lab.example.com.
    lab.example.com. IN CNAME test.example.com.
10. 正确配置PTR记录，许多服务依赖PTR，如sshd,MTA
11. 正确配置轮询round-robin记录


