#!/usr/bin/env bash

# linux 全部用户进程
ps -aux
ps -aux --sort -pmem
# 特定的PID
ps -L 1213
# 显示指定用户信息
ps -u root
# 所有进程信息，连同命令行
ps -ef
#
pstree -c -p -A $(pgrep dockerd)

# macos
ps -Ao user,pid,%cpu,%mem,vsz,rss,tt,stat,start,time,command
pstree

# linux上进程有5种状态:
#1. 运行(正在运行或在运行队列中等待)
#2. 中断(休眠中, 受阻, 在等待某个条件的形成或接受到信号)
#3. 不可中断(收到信号不唤醒和不可运行, 进程必须等待直到有中断发生)
#4. 僵死(进程已终止, 但进程描述符存在, 直到父进程调用wait4()系统调用后释放)
#5. 停止(进程收到SIGSTOP, SIGSTP, SIGTIN, SIGTOU信号后停止运行运行)

# ps工具标识进程的5种状态码:
# D: 不可中断 uninterruptible sleep (usually IO)
# R: 运行 runnable (on run queue)
# S: 中断 sleeping
# T: 停止 traced or stopped
# Z: 僵死 a defunct (”zombie”) process


# 寻找僵尸进程
ps -A -ostat,ppid,pid,cmd | grep -e '^[Zz]'

#
# 命令参数：
# a  显示所有进程
# -a 显示同一终端下的所有程序
# -A 显示所有进程
# c  显示进程的真实名称
# -N 反向选择
# -e 等于“-A”
# e  显示环境变量
# f  显示程序间的关系
# -H 显示树状结构
# r  显示当前终端的进程
# T  显示当前终端的所有程序
# u  指定用户的所有进程
# -au 显示较详细的资讯
# -aux 显示所有包含其他使用者的行程
# -C<命令> 列出指定命令的状况
# --lines<行数> 每页显示的行数
# --width<字符数> 每页显示的字符数
# --help 显示帮助信息
# --version 显示版本显示