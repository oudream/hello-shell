#!/usr/bin/env bash

# 查看 重启情况
last reboot

# 查看 cpu 温度
cat /sys/class/thermal/thermal_zone0/temp
cat /proc/acpi/thermal_zone/TZS0/temperature
cat /proc/cpuinfo
cat /proc/meminfo
# 直接以度为单位显示
echo $[$(cat /sys/class/thermal/thermal_zone0/temp)/1000]
# watch实时观看
watch -n 0.1 echo CPU: $[$(cat /sys/class/thermal/thermal_zone0/temp)/1000]
# ubuntu https://zh.codepre.com/linux-9217.html?__cf_chl_jschl_tk__=pmd_947206e9f157ec04f37c4507a2d37400fc6ce7cd-1627621021-0-gqNtZGzNAeKjcnBszQai
apt-get install lm-sensors -y

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
/var/log/kern.log # 包含内核产生的日志，有助于在定制内核时解决问题。

### 或者直接以度为单位显示
echo $[$(cat /sys/class/thermal/thermal_zone0/temp)/1000]°


### 系统信息
uname -a              # 查看内核/操作系统/CPU信息
cat /etc/issue        # 查看操作系统版本——Os版本
cat /proc/version      #包含GCC的版本信息
cat /proc/cpuinfo     # 查看CPU相关信息(型号,缓存大小等)
cat /proc/stat         #查看所有CPU的活动信息
cat /sys/class/thermal/thermal_zone0/temp       #查看cpu温度（/ 1000就是温度）
hostname             # 查看计算机名
lspci -tv             # 列出所有PCI设备
lsusb -tv             # 列出所有USB设备
lsmod                 # 列出加载的内核模块
env                   # 查看环境变量


### 资源信息
free -m # 查看内存使用量和交换区使用量
df -h # 查看各分区使用情况
du -sh <目录名> # 查看指定目录的大小
grep MemTotal /proc/meminfo # 查看内存总量
grep MemFree /proc/meminfo # 查看空闲内存量
uptime # 查看系统运行时间、用户数、负载
cat /proc/loadavg # 查看系统负载


### 磁盘信息
mount | column -t # 查看挂接的分区状态
fdisk -l # 查看所有分区
swapon -s # 查看所有交换分区
hdparm -i /dev/hda # 查看磁盘参数(仅适用于IDE设备)
dmesg | grep IDE # 查看启动时IDE设备检测状况


### 网络信息
ifconfig # 查看所有网络接口的属性
iptables -L # 查看防火墙设置
route -n # 查看路由表
netstat -lntp # 查看所有监听端口
netstat -antp # 查看所有已经建立的连接
netstat -s # 查看网络统计信息


### 用户信息
w # 查看活动用户
id <用户名> # 查看指定用户信息
last # 查看用户登录日志
cut -d: -f1 /etc/passwd # 查看系统所有用户
cut -d: -f1 /etc/group # 查看系统所有组
crontab -l # 查看当前用户的计划任务


### 进程信息
ps -ef # 查看所有进程
top # 实时显示进程状态
