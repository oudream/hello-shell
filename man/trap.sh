#!/usr/bin/env bash


# 1
# 终端被挂起或者是 Ctrl+C 被按下，这些文件将被删除
trap "rm $WORKDIR/work1$$ $WORKDIR/dataout$$; exit" 1 2
# 如果程序收到了信号值为 2 的信号，trap 命令将会被执行。从 Shell 程序上执行 trap 的这一点开始，
# work1$$ 和 dataout$$ 这两个文件会自动被删除。

# 2
# 忽略的多个信号
trap '' 1 2 3 15


# 3
# 当你改变了信号接收后的默认动作，你可以通过一个简单的省略第一个参数的 trap 命令将默认动作重置回来
trap 1 2


# testing signal trapping


trap "echo 'Sorry! I have trapped Ctrl-C'" SIGINT SIGTERM

echo this is a test program

count=1

while [ $count -le 10 ]
do
	echo "Loop #$count"
	sleep 5
	count=$[ $count+1 ]
done



trap "echo byebye" EXIT

count=1
while [ $count -le 5 ]
do
	echo "Loop #$count"
	sleep 3
	count=$[ $count + 1 ]
done


#移除捕捉
trap - EXIT



#     1) SIGHUP       2) SIGINT       3) SIGQUIT      4) SIGILL
#     5) SIGTRAP      6) SIGABRT      7) SIGBUS       8) SIGFPE
#     9) SIGKILL     10) SIGUSR1     11) SIGSEGV     12) SIGUSR2
#    13) SIGPIPE     14) SIGALRM     15) SIGTERM     16) SIGSTKFLT
#    17) SIGCHLD     18) SIGCONT     19) SIGSTOP     20) SIGTSTP
#    21) SIGTTIN     22) SIGTTOU     23) SIGURG      24) SIGXCPU
#    25) SIGXFSZ     26) SIGVTALRM   27) SIGPROF     28) SIGWINCH
#    29) SIGIO       30) SIGPWR      31) SIGSYS      34) SIGRTMIN
#    35) SIGRTMIN+1  36) SIGRTMIN+2  37) SIGRTMIN+3  38) SIGRTMIN+4
#    39) SIGRTMIN+5  40) SIGRTMIN+6  41) SIGRTMIN+7  42) SIGRTMIN+8
#    43) SIGRTMIN+9  44) SIGRTMIN+10 45) SIGRTMIN+11 46) SIGRTMIN+12
#    47) SIGRTMIN+13 48) SIGRTMIN+14 49) SIGRTMIN+15 50) SIGRTMAX-14
#    51) SIGRTMAX-13 52) SIGRTMAX-12 53) SIGRTMAX-11 54) SIGRTMAX-10
#    55) SIGRTMAX-9  56) SIGRTMAX-8  57) SIGRTMAX-7  58) SIGRTMAX-6
#    59) SIGRTMAX-5  60) SIGRTMAX-4  61) SIGRTMAX-3  62) SIGRTMAX-2
#    63) SIGRTMAX-1  64) SIGRTMAX