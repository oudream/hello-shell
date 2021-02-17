#!/usr/bin/env bash

# 查看 重启情况
last reboot

#
vim /etc/sysctl.conf
sysctl.conf
vm.max_map_count=262144
sysctl -p

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

### 系統日誌
# 系统日志是由一个名为syslog的服务管理的，如以下日志文件都是由syslog日志服务驱动的：
/var/log/boot.log # 录了系统在引导过程中发生的事件，就是Linux系统开机自检过程显示的信息
/var/log/lastlog  # 记录最后一次用户成功登陆的时间、登陆IP等信息
/var/log/messages  # 记录Linux操作系统常见的系统和服务错误信息
/var/log/secure  # Linux系统安全日志，记录用户和工作组变坏情况、用户登陆认证情况
/var/log/btmp  # 记录Linux登陆失败的用户、时间以及远程IP地址
/var/log/syslog # 只记录警告信息，常常是系统出问题的信息，使用lastlog查看
/var/log/wtmp # 该日志文件永久记录每个用户登录、注销及系统的启动、停机的事件，使用last命令查看
/var/run/utmp # 该日志文件记录有关当前登录的每个用户的信息。如 who、w、users、finger等就需要访问这个文件
