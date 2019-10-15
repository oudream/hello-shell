#!/usr/bin/env bash

## mac macos osx
lsof -a -P -i tcp -p 1355
lsof -n -P -i TCP -s TCP:LISTEN

## linux
lsof -a -P -i tcp -p 1355


# lsof（list open files）是一个列出当前系统打开文件的工具
# lsof打开的文件可以是：
# 1.普通文件
# 2.目录
# 3.网络文件系统的文件
# 4.字符或设备文件
# 5.(函数)共享库
# 6.管道，命名管道
# 7.符号链接
# 8.网络文件（例如：NFS file、网络socket，unix域名socket）
# 9.还有其它类型的文件，等等

lsof [参数][文件]
## 参数
# -a 列出打开文件存在的进程
# -c<进程名> 列出指定进程所打开的文件
# -g  列出GID号进程详情
# -d<文件号> 列出占用该文件号的进程
# +d<目录>  列出目录下被打开的文件
# +D<目录>  递归列出目录下被打开的文件
# -n<目录>  列出使用NFS的文件
# -i<条件>  列出符合条件的进程。（4、6、协议、:端口、 @ip ）
# -p<进程号> 列出指定进程号所打开的文件
# -u  列出UID号进程详情
# -h 显示帮助信息
# -v 显示版本信息

# 实例2：查看谁正在使用某个文件，也就是说查找某个文件相关的进程
lsof /bin/bash
# 实例5：列出某个用户打开的文件信息
lsof -u username
# 实例7：列出多个进程多个打开的文件信息
lsof -c mysql -c apache
# 实例8：列出某个用户以及某个进程所打开的文件信息
lsof  -u test -c mysql
# 实例9：列出除了某个用户外的被打开的文件信息
lsof -u ^root
# 实例11：列出多个进程号对应的文件信息
lsof -p 1,2,3
lsof -p ^1 # 除
# 实例13：列出所有的网络连接
lsof -i
# 实例14：列出所有tcp 网络连接信息
lsof -i tcp
# 实例15：列出所有udp网络连接信息
lsof -i udp
# 实例16：列出谁在使用某个端口
lsof -i :3306
# 实例25：列出被进程号为1234的进程所打开的所有IPV4 network files
lsof -i 4 -a -p 1234
# 实例26：列出目前连接主机peida.linux上端口为：20，21，22，25，53，80相关的所有文件信息，且每隔3秒不断的执行lsof指令
lsof -i @peida.linux:20,21,22,25,53,80  -r  3