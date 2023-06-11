# /etc/rc.d 或 /etc/init.d 目录：这些目录通常用于存放系统启动脚本。你可以将你的自启动脚本添加到这些目录中，并确保该脚本具有可执行权限。

# ~/.config/autostart 目录：如果你希望在特定用户登录后自动启动应用程序，可以将启动程序的.desktop文件放置在该目录中。
# 这些.desktop文件通常包含了启动应用程序所需的命令和参数。


# 怎么样知道这linux使用哪种 init 系统，或两种都使用
# systemd：运行 ps -p 1 -o comm= 命令，如果返回结果为 systemd
ps -p 1 -o comm=

# SysV init：运行 ls /sbin/init 命令，如果结果是 /sbin/init
ls /sbin/init


#SysV init 系统，/etc/init.d 目录中的脚本文件通常可以通过以下命令进行操作：

#启动服务：
/etc/init.d/service-name start
#停止服务：
/etc/init.d/service-name stop
#重启服务：
/etc/init.d/service-name restart
#查看服务状态：
/etc/init.d/service-name status
# 启用服务自启动：这会将指定服务配置为在系统启动时自动启动。
chkconfig service-name on
# 禁用服务自启动：这会将指定服务配置为在系统启动时不自动启动。
chkconfig service-name off
# 查看服务列表：这将列出系统上所有已安装的服务及其当前状态。
service --status-all


# 将启动脚本添加到运行级别 3 中, 命令将修改 /etc/rc3.d/ 目录中的符号链接，以确保你的启动脚本在运行级别 3 中被自动执行
update-rc.d myscript defaults 3

# 常见的运行级别：
  #
  #运行级别 0 (halt)：系统关机模式，用于完全停止系统。
  #
  #运行级别 1 (single-user)：单用户模式，用于系统维护和修复，只有一个用户（root）可以登录。
  #
  #运行级别 2 (multi-user)：多用户模式，没有网络服务。
  #
  #运行级别 3 (multi-user with networking)：多用户模式，包括网络服务。
  #
  #运行级别 4：保留给用户自定义使用。
  #
  #运行级别 5 (graphical)：图形用户界面（GUI）模式，通常是默认的图形登录模式。
  #
  #运行级别 6 (reboot)：系统重启模式。