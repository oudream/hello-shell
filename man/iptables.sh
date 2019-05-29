#!/usr/bin/env bash

iptables -L # 查看防火墙设置

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
