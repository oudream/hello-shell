#!/usr/bin/env bash

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
