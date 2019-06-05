#!/usr/bin/env bash


# ip [options] object [command [arguments]]
# OPTIONS 是修改ip行为或改变其输出的选项。所有的选项都是以-字符开头，分为长、短两种形式。如link、addr、route、rule、tunnel 。
# object是要管理者获取信息的对象。如网络接口类型eth0。
# command设置针对指定对象执行的操作，它和对象的类型有关。一般情况下，ip支持对象的增加(add)、删除(delete)和展示(show或list)。
#     有些对象不支持这些操作，或者有其它的一些命令。对于所有的对象，用户可以使用help命令获得帮助。这个命令会列出这个对象支持的命令和
#     参数的语法。如果没有指定对象的操作命令，ip会使用默认的命令。一般情况下，默认命令是list，如果对象不能列出，就会执行help命令。
# arguments是命令的一些参数，它们倚赖于对象和命令。ip支持两种类型的参数：flag和parameter。flag由一个关键词组成；
# parameter由一个关键词加一个数值组成。为了方便，每个命令都有一个可以忽略的默认参数。例如，参数dev是ip link命令的默认参数，
# 因此ip link ls eth0等于ip link ls dev eth0。命令的默认参数将使用default标出。

## 设置一个IP地址，可以使用下列ip命令：
ip addr add 192.168.0.193/24 dev wlan0
# 需要查看是否已经生效。
ip addr show wlan0
# 删除IP地址
ip addr del 192.168.0.193/24 dev wlan0


## 路由
# 列出路由表条目
# IP命令的路由对象的参数还可以帮助你查看网络中的路由数据，并设置你的路由表。第一个条目是默认的路由条目，你可以随意改动它。
ip route show

# 查看路由表
# 假设现在你有一个IP地址，你需要知道路由包从哪里来。可以使用下面的路由选项（译注：列出了路由所使用的接口等）：
ip route get 192.168.99.100

# 添加默认路由
ip route add default via 192.168.202.254
# 添加网络路由
ip route add 192.168.4.0/24 via 192.168.4.1
# 修改网络路由
ip route change 192.168.4.0/24 dev eth1
# 设置NAT路由
ip route add nat 192.168.1.100 via 192.168.1.1
# 查看某个路由表信息
ip route show table main
ip route show table local
ip route show table all
# 擦除路由表
# 擦除所有路由表
ip route flush
# 擦除路由表的缓存
ip route flush cache


## 网络统计
# 显示网络统计数据
# 使用ip命令还可以显示不同网络接口的统计数据。
ip -s link
# 当你需要获取一个特定网络接口的信息时，在网络接口名字后面添加选项ls即可。使用多个选项-s会给你这个特定接口更详细的信息。
#     特别是在排除网络连接故障时，这会非常有用。
ip -s -s link ls docker0
# 或
ip -s link ls docker0


## 查看ARP信息
# 地址解析协议（ARP）用于将一个IP地址转换成它对应的物理地址，也就是通常所说的MAC地址。使用ip命令的neigh或者neighbour选项，
#     你可以查看接入你所在的局域网的设备的MAC地址。
ip neighbour


## 网络监测
# 监控netlink消息
# 可以使用ip命令查看netlink消息。monitor选项允许你查看网络设备的状态。比如，所在局域网的一台电脑根据它的状态可以被分类成
#     REACHABLE或者STALE。使用下面的命令：
ip monitor all


## 网络接口设置
# 激活和停止网络接口
# 你可以使用ip命令的up和down选项来激某个特定的接口，就像ifconfig的用法一样。
# 停止网络接口eth0
ip link set eth0 down
# 启动网络接口eth0
ip link set eth0 up
# 修改设置传输队列的长度
ip link set dev eth0 txqueuelen 100
# 或
ip link set dev eth0 txqlen 100
# 修改网络设置MTU（最大传输单元）的值
ip link set dev eth0 mtu 1500
# 修改网卡的MAC地址
# ip link set eth0（网卡的设备名称） address aa:aa:aa:aa:aa:aa（mac地址）
ip link set dev eth0 address 00:01:4f:00:15:f1
ip link set eth0 address aa:aa:aa:aa:aa:aa


## 路由策略设置
# ip rule命令中包含add、delete、show(或者list)等子命令，注意：策略路由(policy routing)不等于路由策略(rouing policy)。
#     在某些情况下，我们不只是需要通过数据包的目的地址决定路由，可能还需要通过其他一些域：源地址、IP协议、传输层端口甚至数据包
#     的负载。这就叫做：策略路由(policy routing)。
# 插入新的规则
ip rule add
# 删除规则
ip rule delete
# 显示路由表信息
ip rule list
# 子命令可以用如下缩写：add、a；delete、del、d
# 示例1: ： 双网卡数据路由策略选择，让来自192.168.3.0/24的数据包走11.0.0.254这个网关，
#     来自192.168.4.0/24的数据包走12.0.0.254这个网关
# 定义表
echo 10 clinet_cnc >>/etc/iproute2/rt_tables
echo 20 clinet_tel >>/etc/iproute2/rt_tables
# 把规则放入表中
ip rule add from 192.168.3.0/24 table clinet_cnc
ip rule add from 192.168.4.0/24 table clinet_tel
# 添加策略路由
ip route add default via 11.0.0.254  table clinet_cnc
ip route add default via 12.0.0.254 table clinet_tel
# 刷新路由表
ip route flush cache


## macos
sudo ifconfig en0 ether 28:D2:44:7E:99:E5

## ip [ OPTIONS ] netns  { COMMAND | help }
# 可以通过 help 命令查看 ip netns 所有操作的帮助信息：
# Usage: ip netns list
#        ip netns add NAME
#        ip netns set NAME NETNSID
#        ip [-all] netns delete [NAME]
#        ip netns identify [PID]
#        ip netns pids NAME
#        ip [-all] netns exec [NAME] cmd ...
#        ip netns monitor
#        ip netns list-id

## network namespace 在逻辑上是网络堆栈的一个副本，它有自己的路由、防火墙规则和网络设备。
# 默认情况下，子进程继承其父进程的 network namespace。也就是说，如果不显式创建新的 network namespace，
#     所有进程都从 init 进程继承相同的默认 network namespace。
# 根据约定，命名的 network namespace 是可以打开的 /var/run/netns/ 目录下的一个对象。比如有一个名称为 net1 的
#     network namespace 对象，则可以由打开 /var/run/netns/net1 对象产生的文件描述符引用 network namespace net1。
#     通过引用该文件描述符，可以修改进程的 network namespace。

## 显示所有命名的 network namespace
ip netns list # 命令显示所有命名的 network namesapce，其实就是显示 /var/run/netns 目录下的所有 network namespace 对象：

## 创建命名的 network namespace
ip netns add NAME # 命令创建一个命名的 network namespace：

# 删除命名的 network namespace
ip [-all] netns del [ NAME ] # 命令删除指定名称的 network namespace。如果指定了 -all 选项，则尝试删除所有的 network namespace。
#     注意，如果我们把网卡设置到了某个 network namespace 中，并在该 network namespace 中启动了进程：
sudo ip netns add net0
sudo ip link set dev eth0 netns net0
sudo ip netns exec net0 bash
# 在另一个 bash 进程中删除 network namespace net0：
sudo ip netns del net0
# 此时虽然可以删除 netowrk namespace，但是在进程退出之前，网卡一直会保持在你已经删除了的那个 network namespace 中。
# 查看进程的 network namespace
ip netns identify [PID] # 命令用来查看进程的 network namespace。如果不指定 PID 就显示当前进程的 network namespace：

## 下面的命令指定了 PID：
# 查看 network namespace 中进程的 PID
ip netns pids NAME # 命令用来查看指定的 network namespace 中的进程的 PID。这个命令其实就是去检查 /proc 下的所有进程，
#     看进程的 network namespace 是不是指定的 network namespace：
# 在指定的 network namespace 中执行命令
ip [-all] netns exec [ NAME ] cmd # 命令用来在指定的 network namespace 中执行命令。
#     比如我们要看一下某个 network namespace 中有哪些网卡：
sudo ip netns exec neta bash # ip netns exec 后面跟着 namespace 的名字，比如这里的 neta，然后是要执行的命令，
#     只要是合法的 shell 命令都能运行，比如上面的 ip addr 或者 bash。更棒的是，执行的可以是任何命令，
#     不只是和网络相关的(当然，和网络无关命令执行的结果和在外部执行没有区别)。比如下面例子中，执行 bash 命令之后，
#     后面所有的命令都是在这个 network namespace 中执行的，好处是不用每次执行命令都要把 ip netns exec NAME 补全，
#     缺点是你无法清楚知道自己当前所在的 shell，容易混淆：
#     通过 -all 参数我们可以同时在所有的 network namespace 执行命令：
#     输出中的 netns: 指示在某个 network namespace 中执行的结果。

## 监控对 network namespace 的操作
ip netns monitor # 命令用来监控对 network namespace 的操作。比如我们删除一个 network namespace 时就会收到相应的通知：



## arp(选项)(参数)
# 选项
# -a <主机>：显示arp缓冲区的所有条目；
# -H <地址类型>：指定arp指令使用的地址类型；
# -d <主机>：从arp缓冲区中删除指定主机的arp条目；
# -D ：使用指定接口的硬件地址；
# -e ：以Linux的显示风格显示arp缓冲区中的条目；
# -i <接口>：指定要操作arp缓冲区的网络接口；
# -s <主机><MAC地址>：设置指定的主机的IP地址与MAC地址的静态映射；
# -n ：以数字方式显示arp缓冲区中的条目；
# -v ：显示详细的arp缓冲区条目，包括缓冲区条目的统计信息；
# -f <文件>：设置主机的IP地址与MAC地址的静态映射。
arp -v
arp -a


