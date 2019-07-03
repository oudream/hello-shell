#!/usr/bin/env bash

netstat -s | grep "packets received"  # 获得一些连接统计.
netstat -s | grep "packets delivered"

sudo netstat -anp | grep 3306
netstat -lntp # 查看所有监听端口
netstat -antp # 查看所有已经建立的连接
netstat -s # 查看网络统计信息
pstack 7013
# 通过pid查看占用端口
netstat -nap | grep 进程pid
# 例：通过nginx进程查看对应的端口号
ps -ef | grep nginx
netstat -nap | grep nginx-pid
# 例：查看8081号端口对应的进程名
netstat -nap | grep 8081

# -l, --listening 显示监听状态的套接字 --tcp 仅显示 TCP套接字（sockets）
# -n --numeric 不解析服务名称
ss -ltn
# 显示TCP连接
ss -t -a
# 查看进程使用的socket
ss -pl