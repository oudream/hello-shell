#!/usr/bin/env bash

# sudo 是一种权限管理机制，管理员可以授权普通用户去执行 root 权限的操作，而不需要知道 root 的密码。
# sudo 以其他用户身份执行命令，默认以root身份执行。配置文件/etc/sudoers，使用命令 visudo 编辑配置，配置文本行数100gg

vim /etc/sudoers

## Allow root to run any commands anywhere
root      ALL          =  (ALL)                   ALL
boy       ALL          =  (ALL)                   NOPASSWD:/bin/ls                  #允许boy用户使用ls命令，且无需输入密码
boy       ALL          =  (ALL)                   NOPASSWD:ALL                      #允许boy用户使用全部命令，且无需输入密码
# 用户 从哪些主机执行命令  =  （用户身份，默认root用户）  可使用命令的全路径格式,多个命令以逗号分隔

# sudo时间戳：普通用户第一次执行sudo命令时，需输入账户密码，系统会在/var/run/sudo/ts目录下为该用户创建时间戳，
# 有效时间5分钟，可使用-v参数延长有效期，使用-k参数清除时间戳。

# 仅允许用户 nick 在 192.168.10.0/24 网段上连接主机并且以 root 权限执行 useradd 命令
nick 192.168.10.0/24=(root) /usr/sbin/useradd


# 对/etc/sudoers检查语法
visudo -c


###  命令
# 查看用户sudo可使用命令
sudo -l

sudo [-bhHpV][-s ][-u <用户>][指令]
# 或
sudo [-klv]

# 参数
    -b   # 在后台执行指令。

    -h   # 显示帮助。

    -H   # 将HOME环境变量设为新身份的HOME环境变量。

    -k   # 结束密码的有效期限，也就是下次再执行sudo时便需要输入密码。

    -l   # 列出当前用户可执行与无法执行的指令。

    -p   # 改变询问密码的提示符号。

    -s   # 执行指定的shell。

    -u   # <用户> 　以指定的用户作为新的身份。若不加上此参数，则预设以root作为新的身份。

    -v   # 延长密码有效期限5分钟。

    -V   # 显示版本信息。

    -S   # 从标准输入流替代终端来获取密码

