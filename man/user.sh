#!/usr/bin/env bash

groupadd -r admins
useradd -s /sbin/nologin -G admins user1

groupadd -g 995 group1
useradd -s /sbin/nologin -r -u 997 -g 995 user2

groupadd group1
useradd -G group1 user3
cat /etc/passwd	    # 用户账户信息
# user3:x:1003:1006::/home/user3:/bin/sh
cat /etc/group      # 定义用户所属的组
# group1:x:1005:user3
# user3:x:1006:

useradd testuser
passwd testuser
cat /etc/passwd	    # 用户账户信息
#testuser:x:1002:1003::/home/testuser:/bin/sh
groupadd testgroup
cat /etc/group      # 定义用户所属的组
#testuser:x:1003:
#testgroup:x:1004:
usermod -a -G testgroup testuser
gpasswd -a testuser testgroup
cat /etc/group      # 定义用户所属的组
#testgroup:x:1004:testuser
gpasswd -d testuser testgroup
cat /etc/group      # 定义用户所属的组
# testgroup:x:1004:
#

# 添加 sudo 权限
visudo
# 添加
  username ALL=(ALL) ALL

### 用户的管理工具或命令
useradd      # 添加用户
adduesr      # 添加用户
passwd       # 为用户设置密码
usermod      # 修改用户属性，如登录名、用户的home目录等
userdel      # 删除用户
pwcov        # 同步用户从/etc/passwd 到/etc/shadow
pwck         # 校验用户配置文件/etc/passwd 和/etc/shadow 文件内容是否合法或完整；
pwunconv     # 与pwconv功能相反，用来关闭用户的投影密码。它会把密码从shadow文件内，重回存到passwd文件里，然后删除 /etc/shadow 文件。
finger       # 查看用户信息工具
id           # 查看用户的UID、GID及所归属的用户组
chfn         # 更改用户信息工具
su           # 用户切换工具
sudo         # 用来以其他身份来执行命令，预设的身份为root。在/etc/sudoers中设置了可执行sudo指令的用户。若其未经授权的用户企图使用sudo，则会发出警告的邮件给管理员。用户使用sudo时，必须先输入密码，之后有5分钟的有效期限，超过期限则必须重新输入密码。
visudo       # 用于编辑 /etc/sudoers 的命令；也可以不用这个命令，直接用vi 来编辑 /etc/sudoers 的效果是一样的。

### 管理用户组的工具或命令
# 该部分命令与“用户”命令很相似#。
groupadd     # 添加用户组
groupdel     # 删除用户组
groupmod     # 修改用户组信息
gpasswd      # add/remove USER to GROUP
groups       # 显示用户所属的用户组
grpck        # 用于验证组文件的完整性
grpconv      # 通过/etc/group和/etc/gshadow 的文件内容来同步或创建/etc/gshadow ，如果/etc/gshadow 不存在则创建；
grpunconv    # 通过/etc/group 和/etc/gshadow 文件内容来同步或创建/etc/group ，然后删除gshadow文件；


### 用户
# 管理员：root, 0；普通用户：1-65535；系统用户：1-499, 1-999(centos7) 作用：对守护进程获取资源进行权限分配；
#    登录用户:500+, 1000+
# 用户组GID：管理员组：root, 0；系统组：1-499, 1-999(centos7)；普通组：500+, 1000+
# Linux安全上下文：运行中的程序：进程 (process)，以进程发起者的身份运行；
## 进程所能够访问的所有资源的权限取决于进程的发起者的身份；
w                           # 查看活动用户
id ${username}              # 查看指定用户信息
last                        # 查看用户登录日志
cut -d: -f1 /etc/passwd     # 查看系统所有用户
cut -d: -f1 /etc/group      # 查看系统所有组
crontab -l                  # 查看当前用户的计划任务
## 列出用户信息，文件列表，警告: 不要手动编辑这些文件。有些工具可以更好的处理锁定、避免数据库错误。
cat /etc/shadow	    # 保存用户安全信息
cat /etc/passwd	    # 用户账户信息
cat /etc/gshadow    # 保存组账号的安全信息
cat /etc/group      # 定义用户所属的组
cat /etc/sudoers    # 可以运行 sudo 的用户
cat /home/*         # 主目录

/etc/passwd
# 用户名:口令:用户标识号:组标识号:注释性描述:主目录:登录Shell

/etc/shadow
# 登录名:加密口令:最后一次修改时间:最小时间间隔:最大时间间隔:警告时间:不活动时间:失效时间:标志
# 由于/etc/passwd文件对所有用户都可读，所以这仍是一个安全隐患。因此，现在许多Linux 系统（如SVR4）都使用了shadow技术，
# 把真正的加密后的用户口令字存放到/etc/shadow文件中，而在/etc/passwd文件的口令字段中只存放一个特殊的字符，例如“x”或者“*”。
# 只有 root 权限才能打开 shadow
# /etc/shadow中的记录行与/etc/passwd中的一一对应，它由pwconv命令根据/etc/passwd中的数据自动产生

### 伪用户（pseudo users）: 这些用户在/etc/passwd文件中也占有一条记录，但是不能登录，因为它们的登录Shell为空。
# 它们的存在主要是方便系统管理，满足相应的系统进程对文件属主的要求。
# bin 拥有可执行的用户命令文件
# sys 拥有系统文件
# adm 拥有帐户文件
# uucp UUCP使用
# lp lp或lpd子系统使用
# nobody NFS使用
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
# -s SHELL：新的默认SHELL；用户登录后，要启动一个进程，负责将用户的操作传给内核；用户的登录Shell也可以指定为某个特定的程序（此程序不是一个命令解释器）
# -c 'COMMENT'：新的注释信息；
# -d HOME: 新的家目录；原有家目录中的文件不会同时移动至新的家目录；若要移动，则同时使用-m选项；
# -l login_name: 新的名字；
# -L: lock指定用户
# -U: unlock指定用户
# -e YYYY-MM-DD: 指明用户账号过期日期；
# -f INACTIVE: 设定非活动期限；
# -r, --system : Create a system account
#    System users will be created with no aging information in /etc/shadow, and their numeric identifiers are chosen in
#    the SYS_UID_MIN-SYS_UID_MAX range, defined in /etc/login.defs, instead of UID_MIN-UID_MAX (and their GID
#    counterparts for the creation of groups).
#
#    Note that useradd will not create a home directory for such a user, regardless of the default setting in
#    /etc/login.defs (CREATE_HOME). You have to specify the -m options if you want a home directory for a system account
#    to be created.
userdel [OPTION] login # -r: 删除用户家目录；
# 例如：
useradd testuser # 创建用户testuser
passwd testuser # 给已创建的用户testuser设置密码
# create user docker and append to group docker
useradd -g docker -m docker
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
passwd user1 # 设置用户口令：sudo passwd root
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


### 赋予root权限
# 方法一：修改 /etc/sudoers 文件
# %wheel    ALL=(ALL)    ALL
usermod -g root user1
# 或 添加一行
user1   ALL=(ALL)     ALL
# 方法三：修改 /etc/passwd 文件，找到如下行，把用户ID修改为 0 ，如下所示：
user1:x:0:33:user1:/data/webroot:/bin/bash



### 查组包含的用户列表
# 组的信息放在/etc/group，知道组的id,即gid
grep 'Plants' /etc/group
# Plants：x：1003
awk -F":" '{print $1"\t\t"$4}' /etc/passwd | grep '1003'

grep 'nogroup' /etc/group
awk -F":" '{print $1"\t\t"$4}' /etc/passwd | grep '65534'



### 添加批量用户
# https://www.runoob.com/linux/linux-user-manage.html
# 先编辑一个文本用户文件。
# 每一列按照/etc/passwd密码文件的格式书写，要注意每个用户的用户名、UID、宿主目录都不可以相同，其中密码栏可以留做空白或输入x号。
# 一个范例文件user.txt内容如下：
#
cat >> ~/user.txt <<EOF
user001::600:100:user:/home/user001:/bin/bash
user002::601:100:user:/home/user002:/bin/bash
user003::602:100:user:/home/user003:/bin/bash
EOF
# 以root身份执行命令 /usr/sbin/newusers ( 用户加入到 /etc/passwd  )
newusers < user.txt
# 将 /etc/shadow 产生的 shadow 密码解码，然后回写到 /etc/passwd 中，并将/etc/shadow的shadow密码栏删掉。
# 这是为了方便下一步的密码转换工作，即先取消 shadow password 功能。/usr/sbin/pwunconv
pwunconv

cat >> ~/passwd.txt <<EOF
user001:123456
user002:123456
user003:123456
EOF

chpasswd < passwd.txt

pwconv

