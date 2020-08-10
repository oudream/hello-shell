#!/usr/bin/env bash

kill -9 $PID
### kill[参数][进程号]
# 不指定型号将发送SIGTERM（15）终止指定进程。
# 如果任无法终止该程序可用“-KILL” 参数，其发送的信号为SIGKILL(9) ，将强制结束进程，使用ps命令或者jobs 命令可以查看进程号。
# root用户将影响用户的进程，非root用户只能影响自己的进程。

# -l  信号，若果不加信号的编号参数，则使用“-l”参数会列出全部的信号名称
# -a  当处理当前进程时，不限制命令名和进程号的对应关系
# -p  指定kill 命令只打印相关进程的进程号，而不发送任何信号
# -s  指定发送信号
# -u  指定用户

kill -2 123

# 实例1：列出所有信号名称
kill -l


First the signals described in the original POSIX.1-1990 standard.

   Signal     Value     Action   Comment
#   ──────────────────────────────────────────────────────────────────────
   SIGHUP        1       Term    Hangup detected on controlling terminal
                                 or death of controlling process
   SIGINT        2       Term    Interrupt from keyboard
   SIGQUIT       3       Core    Quit from keyboard
   SIGILL        4       Core    Illegal Instruction
   SIGABRT       6       Core    Abort signal from abort(3)
   SIGFPE        8       Core    Floating point exception
   SIGKILL       9       Term    Kill signal
   SIGSEGV      11       Core    Invalid memory reference
   SIGPIPE      13       Term    Broken pipe: write to pipe with no
                                 readers
   SIGALRM      14       Term    Timer signal from alarm(2)
   SIGTERM      15       Term    Termination signal
   SIGUSR1   30,10,16    Term    User-defined signal 1
   SIGUSR2   31,12,17    Term    User-defined signal 2
   SIGCHLD   20,17,18    Ign     Child stopped or terminated
   SIGCONT   19,18,25    Cont    Continue if stopped
   SIGSTOP   17,19,23    Stop    Stop process
   SIGTSTP   18,20,24    Stop    Stop typed at terminal
   SIGTTIN   21,21,26    Stop    Terminal input for background process
   SIGTTOU   22,22,27    Stop    Terminal output for background process

   The signals SIGKILL and SIGSTOP cannot be caught, blocked, or ignored.

   Next  the  signals  not  in  the POSIX.1-1990 standard but described in
   SUSv2 and POSIX.1-2001.

   Signal       Value     Action   Comment
#   ────────────────────────────────────────────────────────────────────
   SIGBUS      10,7,10     Core    Bus error (bad memory access)
   SIGPOLL                 Term    Pollable event (Sys V).
                                   Synonym for SIGIO
   SIGPROF     27,27,29    Term    Profiling timer expired
   SIGSYS      12,31,12    Core    Bad argument to routine (SVr4)
   SIGTRAP        5        Core    Trace/breakpoint trap
   SIGURG      16,23,21    Ign     Urgent condition on socket (4.2BSD)
   SIGVTALRM   26,26,28    Term    Virtual alarm clock (4.2BSD)
   SIGXCPU     24,24,30    Core    CPU time limit exceeded (4.2BSD)
   SIGXFSZ     25,25,31    Core    File size limit exceeded (4.2BSD)

   Up to and including Linux 2.2, the default behavior for  SIGSYS,  SIGX‐
   CPU,  SIGXFSZ,  and (on architectures other than SPARC and MIPS) SIGBUS
   was to terminate the process (without a core  dump).   (On  some  other
   UNIX systems the default action for SIGXCPU and SIGXFSZ is to terminate
   the  process  without  a  core  dump.)   Linux  2.4  conforms  to   the
   POSIX.1-2001  requirements  for  these signals, terminating the process
   with a core dump.

   Next various other signals.

   Signal       Value     Action   Comment
#   ────────────────────────────────────────────────────────────────────
   SIGIOT         6        Core    IOT trap. A synonym for SIGABRT
   SIGEMT       7,-,7      Term
   SIGSTKFLT    -,16,-     Term    Stack fault on coprocessor (unused)
   SIGIO       23,29,22    Term    I/O now possible (4.2BSD)
   SIGCLD       -,-,18     Ign     A synonym for SIGCHLD
   SIGPWR      29,30,19    Term    Power failure (System V)
   SIGINFO      29,-,-             A synonym for SIGPWR
   SIGLOST      -,-,-      Term    File lock lost (unused)
   SIGWINCH    28,28,20    Ign     Window resize signal (4.3BSD, Sun)
   SIGUNUSED    -,31,-     Core    Synonymous with SIGSYS

   (Signal 29 is SIGINFO / SIGPWR on an alpha but SIGLOST on a sparc.)

   SIGEMT is not specified in POSIX.1-2001, but  nevertheless  appears  on
   most  other UNIX systems, where its default action is typically to ter‐
   minate the process with a core dump.

   SIGPWR (which is not specified in POSIX.1-2001) is typically ignored by
   default on those other UNIX systems where it appears.

   SIGIO (which is not specified in POSIX.1-2001) is ignored by default on
   several other UNIX systems.

   Where defined, SIGUNUSED is synonymous with SIGSYS  on  most  architec‐
   tures.

# 1) SIGHUP
# 本信号在用户终端连接(正常或非正常)结束时发出, 通常是在终端的控制进程结束时, 通知同一session内的各个作业, 这时它们与控制终端不再关联。
#
# 登录Linux时，系统会分配给登录用户一个终端(Session)。在这个终端运行的所有程序，包括前台进程组和后台进程组，一般都属于这个Session。
# 当用户退出Linux登录时，前台进程组和后台有对终端输出的进程将会收到SIGHUP信号。这个信号的默认操作为终止进程，因此前台进程组和后台
# 有终端输出的进程就会中止。不过可以捕获这个信号，比如wget能捕获SIGHUP信号，并忽略它，这样就算退出了Linux登录，wget也能继续下载。
#
# 此外，对于与终端脱离关系的守护进程，这个信号用于通知它重新读取配置文件。
#
# 2) SIGINT
# 程序终止(interrupt)信号, 在用户键入INTR字符(通常是Ctrl-C)时发出，用于通知前台进程组终止进程。
#
# 3) SIGQUIT
# 和SIGINT类似, 但由QUIT字符(通常是Ctrl-/)来控制. 进程在因收到SIGQUIT退出时会产生core文件, 在这个意义上类似于一个程序错误信号。
#
# 4) SIGILL
# 执行了非法指令. 通常是因为可执行文件本身出现错误, 或者试图执行数据段. 堆栈溢出时也有可能产生这个信号。
#
# 5) SIGTRAP
# 由断点指令或其它trap指令产生. 由debugger使用。
#
# 6) SIGABRT
# 调用abort函数生成的信号。
#
# 7) SIGBUS
# 非法地址, 包括内存地址对齐(alignment)出错。比如访问一个四个字长的整数, 但其地址不是4的倍数。
# 它与SIGSEGV的区别在于后者是由于对合法存储地址的非法访问触发的(如访问不属于自己存储空间或只读存储空间)。
#
# 8) SIGFPE
# 在发生致命的算术运算错误时发出. 不仅包括浮点运算错误, 还包括溢出及除数为0等其它所有的算术的错误。
#
# 9) SIGKILL
# 用来立即结束程序的运行. 本信号不能被阻塞、处理和忽略。如果管理员发现某个进程终止不了，可尝试发送这个信号。
#
# 10) SIGUSR1
# 留给用户使用
#
# 11) SIGSEGV
# 试图访问未分配给自己的内存, 或试图往没有写权限的内存地址写数据.
#
# 12) SIGUSR2
# 留给用户使用
#
# 13) SIGPIPE
# 管道破裂。这个信号通常在进程间通信产生，比如采用FIFO(管道)通信的两个进程，读管道没打开或者意外终止就往管道写，
# 写进程会收到SIGPIPE信号。此外用Socket通信的两个进程，写进程在写Socket的时候，读进程已经终止。
#
# 14) SIGALRM
# 时钟定时信号, 计算的是实际的时间或时钟时间. alarm函数使用该信号.
#
# 15) SIGTERM
# 程序结束(terminate)信号, 与SIGKILL不同的是该信号可以被阻塞和处理。通常用来要求程序自己正常退出，
# shell命令kill缺省产生这个信号。如果进程终止不了，我们才会尝试SIGKILL。
#
# 17) SIGCHLD
# 子进程结束时, 父进程会收到这个信号。
#
# 如果父进程没有处理这个信号，也没有等待(wait)子进程，子进程虽然终止，但是还会在内核进程表中占有表项，这时的子进程称为僵尸进程。
# 这种情况我们应该避免(父进程或者忽略SIGCHILD信号，或者捕捉它，或者wait它派生的子进程，或者父进程先终止，这时子进程的终止自动由init进程来接管)。
#
# 18) SIGCONT
# 让一个停止(stopped)的进程继续执行. 本信号不能被阻塞. 可以用一个handler来让程序在由stopped状态变为继续执行时完成特定的工作.
# 例如, 重新显示提示符
#
# 19) SIGSTOP
# 停止(stopped)进程的执行. 注意它和terminate以及interrupt的区别:该进程还未结束, 只是暂停执行. 本信号不能被阻塞, 处理或忽略.
#
# 20) SIGTSTP
# 停止进程的运行, 但该信号可以被处理和忽略. 用户键入SUSP字符时(通常是Ctrl-Z)发出这个信号
#
# 21) SIGTTIN
# 当后台作业要从用户终端读数据时, 该作业中的所有进程会收到SIGTTIN信号. 缺省时这些进程会停止执行.
#
# 22) SIGTTOU
# 类似于SIGTTIN, 但在写终端(或修改终端模式)时收到.
#
# 23) SIGURG
# 有"紧急"数据或out-of-band数据到达socket时产生.
#
# 24) SIGXCPU
# 超过CPU时间资源限制. 这个限制可以由getrlimit/setrlimit来读取/改变。
#
# 25) SIGXFSZ
# 当进程企图扩大文件以至于超过文件大小资源限制。
#
# 26) SIGVTALRM
# 虚拟时钟信号. 类似于SIGALRM, 但是计算的是该进程占用的CPU时间.
#
# 27) SIGPROF
# 类似于SIGALRM/SIGVTALRM, 但包括该进程用的CPU时间以及系统调用的时间.
#
# 28) SIGWINCH
# 窗口大小改变时发出.
#
# 29) SIGIO
# 文件描述符准备就绪, 可以开始进行输入/输出操作.
#
# 30) SIGPWR
# Power failure
#
# 31) SIGSYS
# 非法的系统调用。



