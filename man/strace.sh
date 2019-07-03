#!/usr/bin/env bash

strace -p 1137 -f -e trace=network
strace -tt -s 10 -o lgwr.txt -p 5912

# strace命令性能监测与优化
# strace命令是一个集诊断、调试、统计与一体的工具，我们可以使用strace对应用的系统调用和信号传递的跟踪结果来对应用
#    进行分析，以达到解决问题或者是了解应用工作过程的目的。当然strace与专业的调试工具比如说gdb之类的是没法相比的，
#    因为它不是一个专业的调试器。
# strace的最简单的用法就是执行一个指定的命令，在指定的命令结束之后它也就退出了。在命令执行的过程中，strace会记录
#    和解析命令进程的所有系统调用以及这个进程所接收到的所有的信号值。

# 语法
strace  [  -dffhiqrtttTvxx  ] [ -acolumn ] [ -eexpr ] ...
    [ -ofile ] [-ppid ] ...  [ -sstrsize ] [ -uusername ]
    [ -Evar=val ] ...  [ -Evar  ]...
    [ command [ arg ...  ] ]

strace  -c  [ -eexpr ] ...  [ -Ooverhead ] [ -Ssortby ]
    [ command [ arg...  ] ]

## 选项
# -c  统计每一系统调用的所执行的时间,次数和出错的次数等.
# -d  输出strace关于标准错误的调试信息.
# -f  跟踪由fork调用所产生的子进程.
# -ff 如果提供-o filename,则所有进程的跟踪结果输出到相应的filename.pid中,pid是各进程的进程号.
# -F  尝试跟踪vfork调用.在-f时,vfork不被跟踪.
# -h  输出简要的帮助信息.
# -i  输出系统调用的入口指针.
# -q  禁止输出关于脱离的消息.
# -r  打印出相对时间关于,,每一个系统调用.
# -t  在输出中的每一行前加上时间信息.
# -tt 在输出中的每一行前加上时间信息,微秒级.
# -ttt 微秒级输出,以秒了表示时间.
# -T  显示每一调用所耗的时间.
# -v  输出所有的系统调用.一些调用关于环境变量,状态,输入输出等调用由于使用频繁,默认不输出.
# -V  输出strace的版本信息.
# -x  以十六进制形式输出非标准字符串
# -xx 所有字符串以十六进制形式输出.
# -a  column 设置返回值的输出位置.默认 为40.
# -e  expr 指定一个表达式,用来控制如何跟踪.格式：[qualifier=][!]value1[,value2]...
# qualifier 只能是 trace,abbrev,verbose,raw,signal,read,write其中之一.value是用来限定的符号或数字.默认的 qualifier是 trace.感叹号是否定符号.例如:-eopen等价于 -e trace=open,表示只跟踪open调用.而-etrace!=open 表示跟踪除了open以外的其他调用.有两个特殊的符号 all 和 none. 注意有些shell使用!来执行历史记录里的命令,所以要使用\\.
# -e  trace=set 只跟踪指定的系统 调用.例如:-e trace=open,close,rean,write表示只跟踪这四个系统调用.默认的为set=all.
# -e  trace=file 只跟踪有关文件操作的系统调用.
# -e  trace=process 只跟踪有关进程控制的系统调用.
# -e  trace=network 跟踪与网络有关的所有系统调用.
# -e  strace=signal 跟踪所有与系统信号有关的 系统调用
# -e  trace=ipc 跟踪所有与进程通讯有关的系统调用
# -e  abbrev=set 设定strace输出的系统调用的结果集.-v 等与 abbrev=none.默认为abbrev=all.
# -e  raw=set 将指定的系统调用的参数以十六进制显示.
# -e  signal=set 指定跟踪的系统信号.默认为all.如 signal=!SIGIO(或者signal=!io),表示不跟踪SIGIO信号.
# -e  read=set 输出从指定文件中读出 的数据.例如: -e read=3,5
# -e  write=set 输出写入到指定文件中的数据.
# -o  filename 将strace的输出写入文件filename
# -p  pid 跟踪指定的进程pid.
# -s  strsize 指定输出的字符串的最大长度.默认为32.文件名一直全部输出.
# -u  username 以username的UID和GID执行被跟踪的命令

strace ./test
# 从trace结构可以看到，系统首先调用execve开始一个新的进行，接着进行些环境的初始化操作，
#   最后停顿在”read(0,”上面，这也就是执行到了我们的scanf函数，等待我们输入数字呢，在输入完99之后，
#   在调用write函数将格式化后的数值”000000099″输出到屏幕，最后调用exit_group退出进行，完成整个程序的执行过程。


# 系统调用统计 -c
#    它还能将进程所有的系统调用做一个统计分析给你，下面就来看看strace的统计，这次我们执行带-c参数的strace：
strace -c ./test


# 重定向输出 -o
# 参数-o用在将strace的结果输出到文件中，如果不指定-o参数的话，默认的输出设备是STDERR，也就是说使用”-o filename”
#    和” 2>filename”的结果是一样的。
# 这两个命令都是将strace结果输出到文件test.txt中
strace -c -o test.txt ./test
strace -c ./test  2>test.txt


# 对系统调用进行计时 -T
# strace可以使用参数-T将每个系统调用所花费的时间打印出来，每个调用的时间花销现在在调用行最右边的尖括号里面。
strace -T ./test
# -t	10:33:04 exit_group(0)	输出结果精确到秒
# -tt	10:33:48.159682 exit_group(0)	输出结果精确到微妙
# -ttt	1262169244.788478 exit_group(0)	精确到微妙，而且时间表示为unix时间戳

# 截断输出 -s
# -s参数用于指定trace结果的每一行输出的字符串的长度，下面看看test程序中-s参数对结果有什么影响，
#    现指定-s为20，然后在read的是是很我们输入一个超过20个字符的数字串
strace -s 20 ./test


# 一个现有的进程 -p
# strace不光能自己初始化一个进程进行trace，还能追踪现有的进程，参数-p就是取这个作用的，用法也很简单，具体如下。
strace -p pid

