
### l2tp xl2tpd
```shell
git clone https://github.com/oudream/xl2tpd.git
```

### setup on centos7
- https://blog.51cto.com/smoke520/1845206?u_atoken=756fb585-174e-41dc-a7d2-63f021313e17&u_asession=01WUv8igiYcxH_sSAEIznaQATmsGX05mxpoY8yMwFKmM_1HVDB2YJAtQed6S5Q3a4yX0KNBwm7Lovlpxjd_P_q4JsKWYrT3W_NKPr8w6oU7K9aC1QXfXw4xJyuzirrqT2iUXLKsZCw8uLq-8807CgvBGBkFo3NEHBv0PZUm6pbxQU&u_asig=05X6H9Mq2JiZ3QXBSPPCQzX6-CQeMTXTy96Ox2F5pyBIEeyF1uO6F6BSxsA3KZa4tbspgFCu3cRBZHzCNOvqyCNsOPCMrptglxY2b2CPEh-aZSjtAx0yI_IwNCfcr5ONU9GxhqTcdZYHmC0W6UjHLPpJjGA20uqgFyo-hQS5VtPXr9JS7q8ZD7Xtz2Ly-b0kmuyAKRFSVJkkdwVUnyHAIJzWBoWYdtC_sq9AgKbEqHy6aK1-ap0a3w8fn0nhpdFcrk3Vp2qa9nm3AFc9E78pgjbu3h9VXwMyh6PgyDIVSG1W_ZnQwIJqsmKZpqnKWDrabL9DF7TKnKQYEk6HFWwBQz7ynHYGX_halApXB5tTdaZgkmfiJV5mTbNwoCNx2ERcTymWspDxyAEEo4kbsryBKb9Q&u_aref=MNRXrO8EeYo2XljS8xmx48hSU6c%3D
- https://robin-2016.github.io/2018/09/08/Centos-7%E6%90%AD%E5%BB%BAL2TP-VPN%E6%9C%8D%E5%8A%A1%E5%99%A8/
```shell
# 先看看你的主机是否支持pptp，返回结果为yes就表示通过。
modprobe ppp-compress-18 && echo yes
# 是否开启了TUN，有的虚拟机主机需要开启，返回结果为cat: /dev/net/tun: File descriptor in bad state。就表示通过。
cat /dev/net/tun
# 更新一下再安装
yum install update
yum update -y
# 安装EPEL源（CentOS7官方源中已经去掉了xl2tpd）
yum install -y epel-release
# 安装xl2tpd和libreswan(openswan已经停止维护)
yum install -y xl2tpd libreswan lsof
```
- 1) 创建/etc/xl2tpd目录,将examples/xl2tpd.conf复制到/etc/xl2tpd下
```text
[global]
listen-addr = xxx.xxx.xxx.xxx #外网ip
port = 1701
auth file = /etc/ppp/chap-secrets
[lns default]
ip range = 192.168.34.100-192.168.34.200 #客户端ip范围
local ip = 192.168.34.99     #本地ip
require chap = yes
refuse pap = yes
require authentication = yes
name = Linux×××server
ppp debug = yes
pppoptfile = /etc/ppp/options.xl2tpd
length bit = yes
```
- 2) 配置ppp 将examples下的ppp-options.xl2tpd拷贝至/etc/ppp下命名为options.xl2ptd（与上面的xl2tpd中的配置pppoptfile一致）
- options.xl2tpd配置如下
```text
name xl2tpd
ipcp-accept-local
ipcp-accept-remote
ms-dns 8.8.8.8  #这里是dns，可以根据自己的情况进行调整
ms-dns 208.67.220.220  #这里是dns
ms-wins 8.8.8.8
ms-wins 208.67.220.220
noccp
auth
crtscts
idle 1800
mtu 1410
mru 1410
nodefaultroute
debug
lock
proxyarp
connect-delay 5000
```
- 3) 密码设置 在/etc/ppp/chap-secrets中添加密码设置，格式如下：
- 第一列是用户名，第二列是server即为options.xl2tp中的name参数*代表所有，第三列是密码，第四列是允许的IP(*为全部允许)
```text
user         *  password       *
```
- 4) 添加路由设置(可连接×××但不能上网时需要设置)
- 登录后复制
```shell
iptables -t nat -A POSTROUTING -s 192.168.34.0/24 -j SNAT --to-source xxx.xxx.xxx.xxx
service iptables save
```
- 5) linux系统转发设置
- 修改/etc/sysctl.conf，修改如下配置
```text
net.ipv4.ip_forward = 1
```
- 让配置生效
```shell
sysctl -p
```
```
systemctl restart xl2tpd
```
