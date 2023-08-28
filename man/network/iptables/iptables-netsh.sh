#!/usr/bin/env bash

# https://netfilter.org/documentation/HOWTO/netfilter-hacking-HOWTO.html
# https://linux.die.net/man/8/iptables
# https://cloud.tencent.com/developer/article/1632776
# https://zhuanlan.zhihu.com/p/42153839

/etc/init.d/iptables restart

iptables -A INPUT -p tcp --dport 6379 -j ACCEPT
iptables -A INPUT -p tcp --dport 3306 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 6379 -j ACCEPT


# 增加 Dest NAT 端口映射
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 25623 -j DNAT --to-destination 172.17.0.1:15623
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 7000 -j DNAT --to-destination 127.0.0.1:7000
iptables -t nat -D PREROUTING -p tcp -m tcp --dport 7000 -j DNAT --to-destination 127.0.0.1:7000

iptables -t nat -A PREROUTING -p tcp -m tcp --dport 5093 -j DNAT --to-destination 10.11.12.182:93
iptables -t nat -A POSTROUTING -p tcp -m tcp -d 10.11.12.182 --dport 93 -j SNAT --to-source 10.50.53.206
nc -k -lp 93

yum install iptables-services
iptables -F
iptables -t nat -A PREROUTING -p tcp -d 192.168.91.227 --dport 2322 -j DNAT --to 192.168.91.177:22
iptables -t nat -A POSTROUTING -p tcp -d 192.168.91.177 --dport 22 -j SNAT --to 192.168.91.227
firewall-cmd --zone=public --add-port=2322/tcp --permanent
firewall-cmd --reload


# 删除 Dest NAT 端口映射
iptables -t nat -D PREROUTING -p tcp -m tcp --dport 25625 -j DNAT --to-destination 172.17.0.1:15623


# 查看防火墙设置 (-t nat 查nat表）
iptables -L
iptables -vL -t nat
cat /etc/iptables.up.rules
echo 1 > /proc/sys/net/ipv4/ip_forward
cat /proc/sys/net/ipv4/ip_forward

# 源地址发送数据--> {PREROUTING-->路由规则-->POSTROUTING} -->目的地址接收到数据
# MASQUERADE，地址伪装，在iptables中有着和snat相近的效果

# e.g.
nc -l -p 6543
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
# or
echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl -p
iptables -t nat -A PREROUTING -p tcp --dport 5000 -j REDIRECT --to-ports 6543
### 以下会失败，在本地验证是通过不了的。即Server A和Client 都是同一台机器，因为使用lo网卡的时候，是没有PREROUTING这个阶段的
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 5001 -j DNAT --to-destination 127.0.0.1:6543

# 你用ADSL上网，这样你的网络中只有一个公网IP地址（如：61.129.66.5），但你的局域网中的用户还要上网（局域网IP地址为：192.168.1.0/24），
# 这时你可以使用PREROUTING(SNAT)来将局域网中用户的IP地址转换成61.129.66.5，使他们也可以上网：
iptables -t nat -A PREROUTING -s 192.168.1.0/24 -j SNAT 61.129.66.5

# 策略
iptables -t filter -L FORWARD
iptables -P FORWARD ACCEPT

# 清除规则
iptables -t nat -F PREROUTING
iptables -t nat -F POSTROUTING
# iptables清除防火墙所有配置规则
iptables -F # (flush 清除所有的已定规则)
iptables -X # (delete 删除所有用户“自定义”的链（tables）)
iptables -Z # （zero 将所有的chain的计数与流量统计都归零）

# log
iptables -A INPUT  -j LOG --log-prefix "iptables"
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 25623 -j LOG --log-prefix 'nat-prerouting-log'


### close firewalld and clean iptables
sudo systemctl status firewalld
systemctl stop firewalld
systemctl disable firewalld
iptables -F && iptables -X && iptables -F -t nat && iptables -X -t nat
iptables -P FORWARD ACCEPT


# ptables、ip6tables等都使用Xtables框架。存在“表（tables）”、“链（chain）”和“规则（rules）”三个层面。
# 每个“表”指的是不同类型的数据包处理流程，如filter表表示进行数据包过滤，而nat表针对连接进行地址转换操作。
# 每个表中又可以存在多个“链”，系统按照预订的规则将数据包通过某个内建链，例如将从本机发出的数据通过OUTPUT链。
# 在“链”中可以存在若干“规则”，这些规则会被逐一进行匹配，如果匹配，可以执行相应的动作，如修改数据包，或者跳转。
# 跳转可以直接接受该数据包或拒绝该数据包，也可以跳转到其他链继续进行匹配，或者从当前链返回调用者链。
# 当链中所有规则都执行完仍然没有跳转时，将根据该链的默认策略（“policy”）执行对应动作；如果也没有默认动作，则是返回调用者链。

## filter表
#    filter表是默认的表，如果不指明表则使用此表。其通常用于过滤数据包。其中的内建链包括：
#
#    INPUT，输入链。发往本机的数据包通过此链。
#    OUTPUT，输出链。从本机发出的数据包通过此链。
#    FORWARD，转发链。本机转发的数据包通过此链。
#
## nat表
#    nat表如其名，用于地址转换操作。其中的内建链包括：
#
#    PREROUTING，路由前链，在处理路由规则前通过此链，通常用于目的地址转换（DNAT）。
#    POSTROUTING，路由后链，完成路由规则后通过此链，通常用于源地址转换（SNAT）。
#    OUTPUT，输出链，类似PREROUTING，但是处理本机发出的数据包。
#
## mangle表
#    mangle表用于处理数据包。其和nat表的主要区别在于，nat表侧重连接而mangle表侧重每一个数据包。[5]其中内建链列表如下。
#
#    PREROUTING
#    OUTPUT
#    FORWARD
#    INPUT
#    POSTROUTING
#
## raw表
#    raw表用于处理异常，有如下两个内建链：
#
#    PREROUTING
#    OUTPUT


# 我们需要做的最后一件事情，就是存储我们的规则，好让它们在下次开机时会自动被重新装入：
/sbin/service iptables save

# 界面
# 在上一个范本中，我们看见如何能接纳所有来自某个界面的封包，也就是 localhost 界面：
iptables -A INPUT -i lo -j ACCEPT

# 假设我们现在有两个独立的网络界面，分别是将我们连接到内部网络的 eth0 及连接到外部互联网的 ppp0 拨号调制解调器
# （或者 eth1 适配器）。我们或许会想接纳所有来自内部网络的对内封包，但依然过滤那些来自互联网的封包。我们可以这样做：
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -i eth0 -j ACCEPT

# 让特别留意 —— 假如你接纳来自互联网界面（例如 ppp0 拨号调制解调器）的所有封包：
iptables -A INPUT -i ppp0 -j ACCEPT
#你便等同于停用了我们的防火墙！

# 接纳来自被信任 IP 地址的封包
iptables -A INPUT -s 192.168.0.4 -j ACCEPT # change the IP address as appropriate

# 接纳来自被信任 IP 地址的封包
iptables -A INPUT -s 192.168.0.0/24 -j ACCEPT  # using standard slash notation
iptables -A INPUT -s 192.168.0.0/255.255.255.0 -j ACCEPT # using a subnet mask

# 接纳来自被信任 IP 地址的封包
iptables -A INPUT -s 192.168.0.4 -m mac --mac-source 00:50:8D:FD:E6:32 -j ACCEPT

# 接纳目标端口是 6881 号（bittorrent）的 tcp 封包
iptables -A INPUT -p tcp --dport 6881 -j ACCEPT

# 接纳目标端口是 6881-6890 号的 tcp 封包
iptables -A INPUT -p tcp --dport 6881:6890 -j ACCEPT

# 接纳目标端口是 22 号（SSH）的 tcp 封包
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# 接纳来自私人网络，目标端口是 22 号（SSH）的 tcp 封包
iptables -A INPUT -p tcp -s 192.168.0.0/24 --dport 22 -j ACCEPT




### windows
# 1.添加一个端口映射
# netsh interface portproxy add v4tov4 listenaddress=大网IP listenport=端口 connectaddress=要映射的小网IP  connectport=端口
# 例：访问本地127.0.0.1:80 跳转 183.192.162.133:10008
netsh interface portproxy add v4tov4 listenaddress=0.0.0.0 listenport=1883 connectaddress=172.16.78.233 connectport=1883
netsh interface portproxy add v4tov4 listenaddress=0.0.0.0 listenport=3404 connectaddress=127.0.0.1 connectport=2404

# 2.查看存在的转发
netsh interface portproxy show v4tov4

# 3.删除某条规则
# netsh interface portproxy delete v4tov4 listenaddress=IP listenport=端口
# e.g.
netsh interface portproxy delete v4tov4 listenaddress=0.0.0.0 listenport=1883





