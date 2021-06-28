#!/usr/bin/env bash

nohup java -cp "/www/worker/b2b2c.jar" net.shopnc.b2b2c.worker.WorkQueue 1>> /var/log/worker 2>>/dev/null &

# Ctrl-Z：该键是linux下面默认的挂起键（Suspend Key），当键入Ctrl-Z时，系统会将正在运行的程序挂起，然后放到后台，同时给出用户相关的job信息。
# 此时，程序并没有真正的停止，用户可以通过使用fg、bg命令将job恢复到暂停前的上下文环境，并继续执行。

# Ctrl-C：该键是linux下面默认的中断键（Interrupt Key），当键入Ctrl-C时，系统会发送一个中断信号给正在运行的程序和shell。
# 具体的响应结果会根据程序的不同而不同。一些程序在收到这个信号后，会立即结束并推出程序，一些程序可能会忽略这个中断信号，
# 还有一些程序在接受到这个信号后，会采取一些其他的动作（Action）。当shell接受到这个中断信号的时候，它会返回到提示界面，并等待下一个命令。

# Ctrl-D：该键是Linux下面标准输入输出的EOF。在使用标准输入输出的设备中，遇到该符号，会认为读到了文件的末尾，因此结束输入或输出。


### 重定向
### 重定向 文件描述符 0:通常是标准输入（STDIN），1:是标准输出（STDOUT），2:是标准错误输出（STDERR）。
# command > file	将输出重定向到 file。
# command < file	将输入重定向到 file。
# command >> file	将输出以追加的方式重定向到 file。
# n > file	将文件描述符为 n 的文件重定向到 file。
# n >> file	将文件描述符为 n 的文件以追加的方式重定向到 file。
# n >& m	将输出文件 m 和 n 合并。
# n <& m	将输入文件 m 和 n 合并。
# << tag	将开始标记 tag 和结束标记 tag 之间的内容作为输入。
## 例子：
# 如果希望将 stdout 和 stderr 合并后重定向到 file，可以这样写：
command > file 2>&1
command > file 1>&2
#or
command >> file 2>&1
command >> file 1>&2
# /dev/null 文件
# 如果希望执行某个命令，但又不希望在屏幕上显示输出结果，那么可以将输出重定向到 /dev/null：
command > /dev/null



### 后台运行，running in background
# 1、nohup
# 2、setsid
# 3、()和&
# 4、disown
# 5、screen

## nohup
# 忽略hangup信号，标准输出和标准错误缺省会被重定向到nohup.out文件中
nohup ping www.baidu.com &

##
setsid能新建一个session
# setsid与nohup的区分，这里的进程 ID(PID)为31758，而它的父ID(PPID)为1(即为 init进程ID)并不是当前终端的进程ID


# jobs命令用于显示当前终端关联的后台任务情况。
# 命令后面跟上& 用于将命令在后台执行。
./rsync.sh &
# 但是如上方到后台执行的进程，其父进程还是当前终端shell的进程，而一旦父进程退出，则会发送hangup信号给所有子进程，
#    子进程收到hangup以后也会退出。如果我们要在退出shell的时候继续运行进程，则需要使用nohup忽略hangup信号，
#    或者setsid将父进程设为init进程(进程号为1)
nohup ./rsync.sh &
setsid ./rsync.sh &

Ctrl+Z  # 用于将当前正在运行的前台进程暂停，变成后台进程。
bg %n   # 用于将后台暂停的进程继续运行。
fg %n   # 用于将后台执行的进程变成前台进程。
kill %n # 用于杀掉指定的任务。

## 常用参数
# -l     显示进程组ID和作业在运行的目录。
# -n    只显示上次显示过的已经停止的或已经退出的作业。
# -p    只显示选定作业的进程组的进程ID.


## 以下是完整一个任务过程的例子:
vi &   # 启动一个作业在后台
#[1] 5282

jobs -l
#[1]+  5282 Stopped (tty output)    vi

fg %1  # vi 变成前台进程。
#vi

Ctrl+Z  # 用于将当前正在运行的前台进程暂停，变成后台进程。
#[1]+  Stopped                 vi

jobs -l
#[1]+  5282 Stopped                 vi

bg %1  # 用于将后台暂停的进程继续运行。
#[1]+ vi &

jobs -l
#[1]+  5282 Stopped (tty output)    vi

kill %1
#[1]+  Stopped                 vi

jobs -l
#[1]+  5282 Stopped (tty output)    vi

fg %1
#vi
#Vim: Caught deadly signal TERM
#Vim: Finished.
#Terminated
