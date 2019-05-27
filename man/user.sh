#!/usr/bin/env bash



### 用户
# 管理员：root, 0；普通用户：1-65535；系统用户：1-499, 1-999(centos7) 作用：对守护进程获取资源进行权限分配；
#    登录用户:500+, 1000+
# 用户组GID：管理员组：root, 0；系统组：1-499, 1-999(centos7)；普通组：500+, 1000+
# Linux安全上下文：运行中的程序：进程 (process)，以进程发起者的身份运行；
#    进程所能够访问的所有资源的权限取决于进程的发起者的身份；
w # 查看活动用户
id <用户名> # 查看指定用户信息
last # 查看用户登录日志
cut -d: -f1 /etc/passwd # 查看系统所有用户
cut -d: -f1 /etc/group # 查看系统所有组
crontab -l # 查看当前用户的计划任务
# 列出用户信息，文件列表，警告: 不要手动编辑这些文件。有些工具可以更好的处理锁定、避免数据库错误。
cat /etc/shadow	# 保存用户安全信息
cat /etc/passwd	# 用户账户信息
cat /etc/gshadow # 保存组账号的安全信息
cat /etc/group # 定义用户所属的组
cat /etc/sudoers # 可以运行 sudo 的用户
cat /home/* # 主目录
### 用户组名
# adm     类似 wheel 的管理器群组.
# ftp     /srv/ftp/	访问 FTP 服务器.
# games	  /var/games	访问一些游戏。
# log     访问 syslog-ng 创建的 /var/log/ 日志文件.
# http    /srv/http/	访问 HTTP 服务器文件.
# sys     Right to administer printers in CUPS.
# systemd-journal  /var/log/journal/* 以只读方式访问系统日志，和 adm 和 wheel 不同. 不在此组中的用户仅能访问自己生成的信息。
# users   标准用户组.
# uucp    /dev/ttyS[0-9]+, /dev/tts/[0-9]+, /dev/ttyUSB[0-9]+, /dev/ttyACM[0-9]+	串口和 USB 设备，例如猫、手柄 RS-232/串口。
# wheel   管理组，通常用于　sudo　和 su 命令权限。systemd 会允许非　root 的 wheel 组用户启动服务。
### 用户管理 useradd usermod userdel ，useradd 与 usermod 参数一样
useradd [options] login
usermod [OPTION] login
# -u UID: 新UID
# -g GID: 新基本组
# -G GROUP1[,GROUP2,...[,GROUPN]]]：新附加组，原来的附加组将会被覆盖；若保留原有，则要同时使用-a选项，表示append；
# -a（追加到新组时）开关是必不可少的。否则，将从任何组中删除用户
# -s SHELL：新的默认SHELL；
# -c 'COMMENT'：新的注释信息；
# -d HOME: 新的家目录；原有家目录中的文件不会同时移动至新的家目录；若要移动，则同时使用-m选项；
# -l login_name: 新的名字；
# -L: lock指定用户
# -U: unlock指定用户
# -e YYYY-MM-DD: 指明用户账号过期日期；
# -f INACTIVE: 设定非活动期限；
userdel [OPTION] login # -r: 删除用户家目录；
# 例如：
useradd testuser # 创建用户testuser
passwd testuser # 给已创建的用户testuser设置密码
# 说明：新创建的用户会在/home下创建一个用户目录testuser
usermod --help 修改用户这个命令的相关参数
userdel testuser # 删除用户testuser   rm -rf testuser 删除用户testuser所在目录
id user # 查看用户
su <用户名> # 命令行用户切换，su是switch user的缩写，
# 用户组管理： groupadd groupmod groupdel，groupadd 与 groupmod 参数一样
groupadd (选项)(参数) # -g：指定新建工作组的id；-r：创建系统工作组，系统工作组的组ID小于500；
#    -K：覆盖配置文件“/ect/login.defs”； -o：允许添加组ID号不唯一的工作组。
groupadd -g 344 linuxde
groupmod (选项)(参数)
groupdel (参数)
sudo usermod -a -G groupName userName # 增加用户到组，-a（追加）开关是必不可少的。否则，将从任何组中删除用户
# 批量管理用户：
#    成批添加/更新一组账户：newusers
#    成批更新用户的口令：chpasswd
gpasswd -a <用户账号名> <组账号名> # 向标准组中添加用户
usermod -G <组账号名> <用户账号名> # 向标准组中添加用户
gpasswd -d <用户账号名> <组账号名> # 从标准组中删除用户
passwd [<用户账号名>]  # 设置用户口令：sudo passwd root
passwd -l <用户账号名> # 禁用用户账户口令
passwd -S <用户账号名> # 查看用户账户口令状态
passwd -u <用户账号名> # 恢复用户账户口令
passwd -d <用户账号名> # 清除用户账户口令
# 口令时效设置：修改 /etc/login.defs 的相关配置参数
# id：显示用户当前的uid、gid和用户所属的组列表
# groups：显示指定用户所属的组列表
# whoami：显示当前用户的名称
# w/who：显示登录用户及相关信息
# newgrp：用于转换用户的当前组到指定的组账号，用户必须属于该组才可以正确执行该命令
