#!/usr/bin/env bash

# PID pid
ps aux | grep redis | grep -v "grep" | tr -s ' ' | cut -d ' ' -f 2
ps aux | grep -v "grep" | grep redis | awk '{print $2}'
# pidof 获取程序的文件名匹配到的进程号
pidof "cmdname"
# pgrep 效果 与 grep
pgrep "cmdname"


# linux 全部用户进程
ps -aux
ps -aux --sort -pmem
# 特定的PID
ps -L 1213
# 显示指定用户信息
ps -u root
# 所有进程信息，连同命令行
ps -ef
# show process of 指定 parent id == 683,
ps -l --ppid=683
#
pstree -c -p -A $(pgrep dockerd)


# macos
ps -Ao user,pid,%cpu,%mem,vsz,rss,tt,stat,start,time,command
pstree

# http://man7.org/linux/man-pages/man1/ps.1.html
# https://wangchujiang.com/linux-command/c/ps.html
# https://www.ibm.com/support/knowledgecenter/en/ssw_aix_71/p_commands/ps.html


# linux上进程有5种状态:
#1. 运行(正在运行或在运行队列中等待)
#2. 中断(休眠中, 受阻, 在等待某个条件的形成或接受到信号)
#3. 不可中断(收到信号不唤醒和不可运行, 进程必须等待直到有中断发生)
#4. 僵死(进程已终止, 但进程描述符存在, 直到父进程调用wait4()系统调用后释放)
#5. 停止(进程收到SIGSTOP, SIGSTP, SIGTIN, SIGTOU信号后停止运行运行)
# https://unix.stackexchange.com/questions/412471/what-does-i-uppercase-i-mean-in-ps-aux
# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=06eb61844d841d0032a9950ce7f8e783ee49c0d0
#	/* states in TASK_REPORT: */
#	"R (running)",		/* 0x00 */
#	"S (sleeping)",		/* 0x01 */
#	"D (disk sleep)",	/* 0x02 */
#	"T (stopped)",		/* 0x04 */
#	"t (tracing stop)",	/* 0x08 */
#	"X (dead)",		/* 0x10 */
#	"Z (zombie)",		/* 0x20 */
#
#	/* states beyond TASK_REPORT: */
#	"I (idle)",		/* 0x40 */

# idle（发呆）模式下部份片内模块停止运行，功耗降低，适于短时无任务时降低系统功耗用，恢复正常工作模式的速度较快。
# sleep（冬眠）模式（也可称stop模式）下绝大多数片内模块停止运行，这时的功耗比idle模式更低，适于长时无任务时将系统功耗降至最低，其恢复到正常工作模式的速度比idle模式慢。


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