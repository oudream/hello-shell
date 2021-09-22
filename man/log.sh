#!/usr/bin/env bash

# 引出OOM killer
# google了一下这个打印信息，发现linux有一个叫做OOM-killer（Out Of Memory killer）的机制。
#   OOM killer会在系统内存耗尽的情况下触发，选择性的干掉一些进程，以求释放一些内存。OOM killer是通过/proc/<pid>/oom_score这个值来决定哪个进程被干掉的。
#  这个值是系统综合进程的内存消耗量、CPU时间(utime + stime)、存活时间(uptime - start time)和oom_adj计算出的，消耗内存越多分越高，存活时间越长分越低。
#  总之，总的策略是：损失最少的工作，释放最大的内存同时不伤及无辜的用了很大内存的进程，并且杀掉的进程数尽量少。
# 找到系统日志文件（/var/log/messages），发现几条对应的信息：
#    Jul 27 14:54:11 iZbp1gq49eb2h8qr5ktv1gZ kernel: Out of memory: Kill process 1119 (test) score 865 or sacrifice child
#    Jul 27 14:54:11 iZbp1gq49eb2h8qr5ktv1gZ kernel: Killed process 1119 (test) total-vm:962016kB, anon-rss:903972kB, file-rss:80kB

# 日志在排查文件的时候至关重要，在Linux上一般跟系统相关的日志默认都会放到/var/log下面。
/var/log/boot.log
# 一般包含系统启动时的日志，包括自启动的服务。

/var/log/btmp
# 记录所有失败登录信息。非文本文件，可以使用last -f /var/log/btmp进行查看。

/var/log/cron
# cron计划任务的日志，每当cron任务被执行的时候都会在这个文件里面记录。

/var/log/dmesg
# 包含内核缓冲信息（kernel ring buffer）。在系统启动时，会在屏幕上显示许多与硬件有关的信息。可以直接查看这个文件或者使用dmesg这个命令查看。

/var/log/lastlog
# 记录所有用户的最近信息。非文本文件，可以使用lastlog进行查看。

/var/log/maillog
# 包含来着系统运行电子邮件服务器的日志信息。

/var/log/message
# 包括整体系统信息，其中也包含系统启动期间的日志。此外，mail，cron，daemon，kern和auth等内容也记录在var/log/messages日志中。

/var/log/secure
# 包含验证和授权方面信息。例如，sshd会将所有信息记录（其中包括失败登录）在这里。

/var/log/yum.log
# 包含使用yum安装软件包的信息。

/var/log/anaconda/
# or
/var/log/anconda.log
# 包含在安装CentOS/RHEL时候的日志。

/var/log/audit
# 包含audit daemon的审计日志。例如：selinux开启的时候，这里就会有关于selinux审计的日志。

/var/log/sa/
# 包含每日由sysstat软件包收集的sar文件。

/var/log/cups
# 涉及所有打印信息的日志，即cups打印服务运行的日志。

其他文件或者目录
# 例如安装系统自带的一些软件的时候，默认的日志输出都是输出到这个路径下的，例如apache默认日志路径/var/log/httpd/，这个是为了遵循系统设计的一些规范。
