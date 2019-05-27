#!/usr/bin/env bash

### 服务 Systemd
service --status-all systemctl
systemctl list-units --type=service
chkconfig --list # 列出所有系统服务
chkconfig --list | grep on # 列出所有启动的系统服务
sysv-rc-conf
sudo systemctl set-default multi-user.target # 开机后进入命令行界面：
sudo systemctl set-default graphical.target # 开机后进入图形界面
systemctl list-units --all --type=service --no-pager # List all services
sudo systemctl enable httpd # systemctl enable test.service # 开机启动
sudo systemctl disable httpd # systemctl disable test.service # 开机不启动
sudo systemctl start httpd # 启动服务
sudo systemctl status httpd # 查看服务的状态
sudo systemctl stop httpd.service # 停止服务
sudo systemctl kill httpd.service # 服务停不下来。这时候就不得不"杀进程"了
# 配置文件主要放在 /usr/lib/systemd/system 目录，也可能在 /etc/systemd/system
systemctl cat sshd.service # 查看配置文件
# [Unit] 区块：启动顺序与依赖关系
#    Description 字段给出当前服务的简单描述，Documentation 字段给出文档位置
#    After 和 Before 字段只涉及启动顺序，不涉及依赖关系
#    Wants 字段：表示"弱依赖"关系，Requires 字段则表示"强依赖"关系
# [Service] 区块：启动行为
#    ExecStart 字段：定义启动进程时执行的命令；ExecReload 字段：重启服务时执行的命令; ExecStop 字段：停止服务时执行的命令;
#    ExecStartPre 字段：启动服务之前执行的命令；ExecStartPost 字段：启动服务之后执行的命令；ExecStopPost 字段：停止服务之后执行的命令
#    Type：simple（默认值）：ExecStart字段启动的进程为主进程; oneshot（值）：类似于simple，但只执行一次
#    Restart：no（默认值）：退出后不会重启；always：不管是什么退出原因，总是重启
# [Install] 区块：Install区块，定义如何安装这个配置文件，即怎样做到开机启动。
#    WantedBy：服务组，执行 systemctl enable sshd.service 命令后，就会在 /etc/systemd/system/multi-user.target.wants目录中存放 service 文件。


[Unit]
Description=Frp Server Service
After=systemd-networkd.service network.target sshd.service

[Service]
Type=simple
User=nobody
Restart=on-failure
RestartSec=5s
ExecStart=/bin/bash -c '/fff/frp/frps -c /fff/frp/frps.ini'

[Install]
WantedBy=multi-user.target


[Unit]
Description=Frp Client Service
After=systemd-networkd.service network.target sshd.service

[Service]
Type=simple
User=nobody
Restart=on-failure
RestartSec=5s
ExecStart=/bin/bash -c '/fff/frp/frpc -c /fff/frp/frpc.ini'
ExecReload=/usr/bin/frpc reload -c /etc/frp/frpc.ini

[Install]
WantedBy=multi-user.target


[Unit]
Description=frp deamon
After=network.target network-online.target sshd.service

[Service]
Type=simple
WorkingDirectory=/fff/frp
ExecStart=/bin/bash -c '/fff/frp/frps -c /fff/frp/frps-remote.ini'
ExecStartPre=/bin/sh -c 'until nc -zv 13.112.200.162 7000; do sleep 3; done;'
Restart=always

[Install]
WantedBy=multi-user.target

### Journalctl 查看和操作 Systemd 日志
journalctl -b   # 当前引导的日志, 显示自最近重新引导以来收集的所有日记帐分录。
journalctl --since "2015-01-10" --until "2015-01-11 03:00"
journalctl --since yesterday
journalctl --since 09:00 --until "1 hour ago"
journalctl -u nginx.service --since today # 按单位, 按消息兴趣过滤
journalctl _PID=8088 # 按进程，用户或组ID
journalctl /usr/bin/bash # 按组件路径
journalctl -k # 显示内核消息
journalctl -n 20 # 工作原理完全一样 tail -n
journalctl -f # 要积极跟踪日志，因为他们正在写的。你可能期望tail -f
journalctl --disk-usage # 该杂志目前使用占用的磁盘空间量
sudo journalctl --vacuum-size=1G # 将删除旧条目，直到磁盘上占用的总日志空间为所请求的大小



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

