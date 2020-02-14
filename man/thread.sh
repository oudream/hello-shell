#!/usr/bin/env bash


## 查进程的线程信息
# 通过/proc伪文件系统。
cat /proc/{pid}/status

# 其中Threads后面跟的就是线程数。
# 或者：通过
ls /proc/{pid}/task | wc -l

# top命令后面跟-H，会打印出所有线程列表
top -H
top -H -p {pid}

# ps 后面加上H，能打印某个进程的所有线程
ps hH p {pid} | wc -l

# 使用ps命令来查看进程的时候，进程状态分别对应的含义如下：
# D    不可中断睡眠 (通常是在IO操作) 收到信号不唤醒和不可运行, 进程必须等待直到有中断发生
# R   正在运行或可运行（在运行队列排队中）
# S   可中断睡眠 (休眠中, 受阻, 在等待某个条件的形成或接受到信号)
# T   已停止的 进程收到SIGSTOP, SIGSTP, SIGTIN, SIGTOU信号后停止运行
# W   正在换页(2.6.内核之前有效)
# X   死进程 (未开启)
# Z   僵尸进程  进程已终止, 但进程描述符存在, 直到父进程调用wait4()系统调用后释放BSD风格的
# <   高优先级(not nice to other users)
# N   低优先级(nice to other users)
# L   页面锁定在内存（实时和定制的IO）
# s   一个信息头
# l   多线程（使用 CLONE_THREAD，像NPTL的pthreads的那样）
# +   在前台进程组

# 使用pstree命令
# 打印所有进程及其线程
pstree -p
# 打印某个进程的线程数
pstree -p {pid} | wc -l

# 修改某个账户的可允许的线程最大数
cat /etc/security/limits.d/20-nproc.conf

# Default limit for number of user's processes to prevent
# accidental fork bombs.
# See rhbz #432903 for reasoning.
*          soft    nproc     1024      # 将此处修改成unlimited或者其他数值
root       soft    nproc     unlimited

# 如果达到了系统允许的最大值，再创建线程时会报错：此时就连登陆ssh都可能登不进去。。~
-bash: fork: retry: 没有子进程
-bash: fork: retry: 资源暂时不可用
