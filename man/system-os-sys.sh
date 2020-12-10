#!/usr/bin/env bash

# 查看当前系统设置的最大句柄数是多少
ulimit -a
# 查看具体服务所能打开的最大文件句柄（Max open files）：
cat /proc/$pid/limits


# How to discover number of *logical* cores on Mac OS X?
# https://developer.apple.com/documentation/foundation/processinfo/1415622-processorcount
sysctl -n hw.ncpu

### sysctl(选项)(参数) /etc/sysctl.conf
# -n 打印值时不打印关键字；
# -e 忽略未知关键字错误；
# -N 仅打印名称；
# -w 当改变sysctl设置时使用此项；
# -p 从配置文件“/etc/sysctl.conf”加载内核参数设置；
# -a 打印当前所有可用的内核参数变量和值；
# -A 以表格方式打印当前所有可用的内核参数变量和值。
sysctl -a
# 配置sysctl; 编辑此文件：/etc/sysctl.conf
# 您可以使用sysctl修改系统变量，也可以通过编辑sysctl.conf文件来修改系统变量。sysctl.conf看起来很像rc.conf。
# 它用variable=value的形式来设定值。指定的值在系统进入多用户模式之后被设定。并不是所有的变量都可以在这个模式下设定。
# sysctl变量的设置通常是字符串、数字或者布尔型。（布尔型用 1 来表示'yes'，用 0 来表示'no'）。
net.ipv4.icmp_echo_ignore_all = 1 # 如果希望屏蔽别人 ping 你的主机 # Disable ping requests
# 编辑完成后，请执行以下命令使变动立即生效：
/sbin/sysctl -p
/sbin/sysctl -w net.ipv4.route.flush=1

