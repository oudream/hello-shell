#!/usr/bin/env bash


yum -y install epel-release
yum -y install htop
yum -y install psmisc # pstree


### CentOS7自动以root身份登陆gnome桌面
vim /etc/gdm/custom.conf
# 然后在[daemon]下面添加：
#  [daemon]
#  AutomaticLoginEnable=True
#  AutomaticLogin=root  #你想自动登录的用户名


### 默认启动方式
# 字符界面启动的方法
systemctl get-default graphical.target
# 命令行
systemctl set-default multi-user.target


# Bash Centos7 “which” command
yum whatprovides *bin/which
# or
yum install which

# yum-config-manager: command not found
yum -y install yum-utils

# netstat command not found
yum install net-tools

yum install unzip

# https://stackoverflow.com/questions/21802223/how-to-install-crontab-on-centos
yum install cronie

yum -y install gcc gcc-c++ automake autoconf libtool make epel-release wget java-1.8.0-openjdk && \

yum localinstall jdk-8u60-linux-x64.rpm