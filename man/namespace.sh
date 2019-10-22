#!/usr/bin/env bash

# Namespace资源隔离
#目前 linux 内核主要实现了一下几种不同的资源 namespace：
#
#名称	    宏定义         	隔离的内容
# IPC	    CLONE_NEWIPC	System V IPC, POSIX message queues (since Linux 2.6.19)
# Network	CLONE_NEWNET	network device interfaces, IPv4 and IPv6 protocol stacks, IP routing tables, firewall rules, the /proc/net and /sys/class/net directory trees, sockets, etc (since Linux 2.6.24)
# Mount	    CLONE_NEWNS	    Mount points (since Linux 2.4.19)
# PID	    CLONE_NEWPID	Process IDs (since Linux 2.6.24)
# User	    CLONE_NEWUSER	User and group IDs (started in Linux 2.6.23 and completed in Linux 3.8)
# UTS	    CLONE_NEWUTS	Hostname and NIS domain name (since Linux 2.6.19)
# Cgroup	CLONE_NEWCGROUP	Cgroup root directory (since Linux 4.6)

/proc 目录
#每个进程都有一个 /proc/[pid]/ns 的目录，里面保存了该进程所在对应 namespace 的链接：
ls -l /proc/$$/ns/

### clone：创建新进程并设置它的namespace
# clone 类似于 fork 系统调用，可以创建一个新的进程，不同的是你可以指定要子进程要执行的函数以及通过参数控制子进程的运行环境（比如这篇文章主要介绍的 namespace）。下面是 clone(2) 的定义：
##include <sched.h>
#
#int clone(int (*fn)(void *), void *child_stack,
#         int flags, void *arg, ...
#         /* pid_t *ptid, struct user_desc *tls, pid_t *ctid */ );

#它有四个重要的参数：
#fn             参数是一个函数指针，子进程启动的时候会调用这个函数来执行
#arg            作为参数传给该函数。当这个函数返回，子进程的运行也就结束，函数的返回结果就是 exit code。
#child_stack    参数指定了子进程 stack 开始的内存地址，因为 stack 都会从高位到地位增长，所以这个指针需要指向分配 stack 的最高位地址。
#flags          是子进程启动的一些配置信息，包括信号（子进程结束的时候发送给父进程的信号 SIGCHLD）
#               、子进程要运行的 namespace 信息（上面已经看到的 CLONE_NEWIPC，CLONE_NEWNET、CLONE_NEWIPC等）、
#               其他配置信息（可以参考 clone(2) man page）



### setns 能够把某个进程加入到给定的 namespace，它的定义是这样的：
#int setns(int fd, int nstype);

#fd 参数是一个文件描述符，指向 /proc/[pid]/ns/ 目录下的某个 namespace，调用这个函数的进程就会被加入到 fd 指向文件所代表的 namespace，fd 可以通过打开 namespace 对应的文件获取。

#nstype 限定进程可以加入的 namespaces，可能的取值是：
#0: 可以加入任意的 namespaces
#CLONE_NEWIPC：fd 必须指向 ipc namespace
#CLONE_NEWNET：fd 必须指向 network namespace
#CLONE_NEWNS：fd 必须指向 mount namespace
#CLONE_NEWPID：fd 必须指向 PID namespace
#CLONE_NEWUSER： fd 必须指向 user namespace
#CLONE_NEWUTS： fd 必须指向 UTS namespace


#Establish a PID namespace, ensure we're PID 1 in it against a
#newly mounted procfs instance.
unshare --fork --pid --mount-proc readlink /proc/self
#Establish a user namespace as an unprivileged user with a root
#user within it.
unshare --map-root-user --user sh -c whoami

### c - api
#unshare(CLONE_NEWPID | CLONE_NEWNS );
#int pid = fork();
#if (pid != 0) {
#    int status;
#    waitpid(-1, &status, 0);
#    return status;
#}
#printf("New PID after unshare is %i", getpid());
#if (mount("none", "/proc", NULL, MS_PRIVATE|MS_REC, NULL)) {
#    printf("Cannot umount proc! errno=%i", errno);
#    exit(1);
#}
#if (mount("proc", "/proc", "proc", MS_NOSUID|MS_NOEXEC|MS_NODEV, NULL)) {
#    printf("Cannot mount proc! errno=%i", errno);
#    exit(1);
#}
#if (mount("devpts", "/dev/pts", "devpts", MS_MGC_VAL | MS_NOSUID | MS_NOEXEC, "newinstance") ) {
#    printf("Cannot mount pts! errno=%i", errno);
#    exit(1);
#}
#if (mount("/dev/pts/ptmx", "/dev/ptmx", NULL, MS_MGC_VAL | MS_NOSUID | MS_NOEXEC | MS_BIND, NULL) ) {
#    printf("Cannot mount ptmx! errno=%i", errno);
#    exit(1);
#}
