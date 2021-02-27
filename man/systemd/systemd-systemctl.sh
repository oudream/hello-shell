#!/usr/bin/env bash

sudo journalctl -f -u etcd
sudo journalctl -f -u systemd-sysctl

# Ubuntu Desktop: Completley remove Ubuntu Desktop from a Ubuntu Server
# INSTALL UBUNTU DESKTOP WITHOUT INSTALL RECOMMENDS
sudo apt-get install --no-install-recommends ubuntu-desktop
# REMOVE UBUNTU DESKTOP COMPLETELY
sudo apt purge ubuntu-desktop -y && sudo apt autoremove -y && sudo apt autoclean


# 列出所有可用单元
systemctl list-unit-files
# 列出所有运行中单元
systemctl list-units
# 列出所有失败单元
systemctl –failed
# 检查某个单元（如 crond.service）是否启用
systemctl is-enabledcrond.service
# 列出所有服务
systemctl list-unit-files –type=service

service --status-all systemctl
systemctl list-units --type=service
chkconfig --list # 列出所有系统服务
chkconfig --list | grep on # 列出所有启动的系统服务
sysv-rc-conf


systemctl enable test.service
## 以上命令相当于执行以下命令，把test.service添加到开机启动中
sudo ln -s  '/etc/systemd/system/test.service'  '/etc/systemd/system/multi-user.target.wants/test.service'
wget –no-check-certificate  https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks.sh


### 服务 Systemd 服务生命周期
sudo systemctl set-default multi-user.target # 开机后进入命令行界面：
sudo systemctl set-default graphical.target # 开机后进入图形界面
systemctl list-units --all --type=service --no-pager # List all services
sudo systemctl enable httpd # systemctl enable test.service # 开机启动
sudo systemctl disable httpd # systemctl disable test.service # 开机不启动
sudo systemctl start httpd # 启动服务
sudo systemctl restart httpd.service
sudo systemctl status httpd # 查看服务的状态
sudo systemctl stop httpd.service # 停止服务
sudo systemctl kill httpd.service # 服务停不下来。这时候就不得不"杀进程"了
systemctl is-active mysql.service
# 配置文件主要放在 /usr/lib/systemd/system 目录，也可能在 /etc/systemd/system
systemctl cat sshd.service # 查看配置文件
# [Unit] 区块：启动顺序与依赖关系
#    Description 字段给出当前服务的简单描述，Documentation 字段给出文档位置
#    After 和 Before 字段只涉及启动顺序，不涉及依赖关系
#    Wants 字段：表示"弱依赖"关系，Requires 字段则表示"强依赖"关系
# [Service] 区块：启动行为
#    ExecStart 字段：定义启动进程时执行的命令；
#    ExecReload 字段：重启服务时执行的命令;
#    ExecStop 字段：停止服务时执行的命令;
#    ExecStartPre 字段：启动服务之前执行的命令；
#    ExecStartPost 字段：启动服务之后执行的命令；
#    ExecStopPost 字段：停止服务之后执行的命令
#    Type：simple（默认值）：ExecStart字段启动的进程为主进程; oneshot（值）：类似于simple，但只执行一次
#    Restart：no（默认值）：退出后不会重启；always：不管是什么退出原因，总是重启
# [Install] 区块：Install区块，定义如何安装这个配置文件，即怎样做到开机启动。
#    WantedBy：服务组，执行 systemctl enable sshd.service 命令后，就会在 /etc/systemd/system/multi-user.target.wants目录中存放 service 文件。
rm /etc/systemd/system/filebeat-log4j.service
rm /usr/lib/systemd/system/filebeat-log4j.service
systemctl daemon-reload
systemctl reset-failed


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
Type=forking
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

