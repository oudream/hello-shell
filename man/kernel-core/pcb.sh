#!/usr/bin/env bash

# process control block (PCB)
# https://en.wikipedia.org/wiki/Process_control_block
# https://zh.wikipedia.org/wiki/%E8%A1%8C%E7%A8%8B%E6%8E%A7%E5%88%B6%E8%A1%A8

# 进程控制块（英语：Process Control Block，PCB）是操作系统核心中一种数据结构，主要表示行程状态。

# 虽各实际情况不尽相同，PCB通常记载行程之相关信息，包括：

#  行程状态：可以是new、ready、running、waiting或blocked等。
#  程序计数器：接着要运行的指令地址。
#  CPU寄存器：如累加器、变址寄存器、堆栈指针以及一般用途寄存器、状况代码等，主要用途在于中断时暂时存储数据，以便稍后继续利用；其数量及类别因计算机体系结构有所差异。
#  CPU排班法：优先级、排班队列等指针以及其他参数。
#  存储器管理：如标签页表等。
#  会计信息：如CPU与实际时间之使用数量、时限、账号、工作或行程号码。
#  输入输出状态：配置行程使用I/O设备，如磁带机。
#  总言之，PCB如其名，内容不脱离各行程相关信息。


### unistd.h
# getcwd(), getegid(), geteuid(), getgid(), getgroups(), gethostid(), getlogin(), getpgid(), getpgrp(), getpid(), getppid(), getsid(), getuid(), getwd(),
# https://pubs.opengroup.org/onlinepubs/7908799/xsh/unistd.h.html
# https://github.com/torvalds/linux/blob/master/include/uapi/asm-generic/unistd.h
# task_struct
# 每一个进程都由task_struct 数据结构来定义. task_struct就是我们通常所说的PCB
# https://github.com/torvalds/linux/blob/master/include/linux/sched.h
#  struct task_struct {
#
#    long state; /*任务的运行状态（-1 不可运行，0 可运行(就绪)，>0 已停止）*/
#
#    long counter;/*运行时间片计数器(递减)*/
#
#    long priority;/*优先级*/
#
#    long signal;/*信号*/
#
#    struct sigaction sigaction[32];/*信号执行属性结构，对应信号将要执行的操作和标志信息*/
#
#    long blocked; /* bitmap of masked signals */
#
#    　　/* various fields */
#
#    int exit_code;/*任务执行停止的退出码*/
#
#    unsigned long start_code, end_code, end_data, brk, start_stack;/*代码段地址 代码长度（字节数）
#
#                                     　　代码长度 + 数据长度（字节数）总长度 堆栈段地址*/
#
#    long pid, father, pgrp, session, leader;/*进程标识号(进程号) 父进程号 父进程组号 会话号 会话首领*/
#
#    unsigned short uid, euid, suid;/*用户标识号（用户id） 有效用户id 保存的用户id*/
#
#    unsigned short gid, egid, sgid; /*组标识号（组id） 有效组id 保存的组id*/
#
#    long alarm;/*报警定时值*/
#
#    long utime, stime, cutime, cstime, start_time;/*用户态运行时间 内核态运行时间 子进程用户态运行时间
#
#                            　　子进程内核态运行时间 进程开始运行时刻*/
#
#    unsigned short used_math;/*标志：是否使用协处理器*/
#
#    　　/* file system info */
#
#    int tty; /* -1 if no tty, so it must be signed */
#
#    unsigned short umask;/*文件创建属性屏蔽位*/
#
#    struct m_inode * pwd;/*当前工作目录i 节点结构*/
#
#    struct m_inode * root;/*根目录i节点结构*/
#
#    struct m_inode * executable;/*执行文件i节点结构*/
#
#    unsigned long close_on_exec;/*执行时关闭文件句柄位图标志*/
#
#    struct file * filp[NR_OPEN];/*进程使用的文件表结构*/
#
#    　　/* ldt for this task 0 - zero 1 - cs 2 - ds&ss */
#
#    struct desc_struct ldt[3];/*本任务的局部描述符表。0-空，1-代码段cs，2-数据和堆栈段ds&ss*/
#
#    　　/* tss for this task */
#
#    struct tss_struct tss;/*本进程的任务状态段信息结构*/
#
#  };