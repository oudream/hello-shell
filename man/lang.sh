#!/usr/bin/env bash


### $?
# 0: 最后命令成功
# 其它: 最后命令失败


### [] test
# test和[]中可用的比较运算符只有==和!=，两者都是用于字符串比较的，
# 不可用于整数比较，整数比较只能使用-eq，-gt这种形式


### (()) $(())
### > < * 等不用转义
(()) # 命令执行
v1=$(()) # 执行后赋值


### 特殊字符
* # 任意个任意字符
? # 一个任意字符
#[..] []中的任意一个字符,这里也类似于正则表达式,中括号内可以是具体的一些字符,如[abcd]也可以是用-指定的一个范围,如[a-d]
# 注释
#(空格) 参数分隔符
cmd # 命令替换
# | 管道
# & 后台执行
# ; 命令分隔符(可以在同一行执行两个命令,用;分割)
# ~ 用户home目录


# 空指令 空操作 :
:
s1=aaa.b; [[ $s1 =~ "a.b" ]] && : || echo 'n'


# 三目运算符
echo $((2>1?2:1))
command1 && command2 || command3

echo $(expr 2>1?2:1)


# a complex variable using command substitution
# https://www.learnshell.org/en/Variables
date -d "$date1" +%A
curTime=$(date "+%H%M%S")
date1=$(date --date='1 days ago +%Y%m%d')    #前一天的日期


### $
$0 - The filename of the current script.|
$n - The Nth argument passed to script was invoked or function was called.|
$# - The number of argument passed to script or function.|
$@ - All arguments passed to script or function.|
$* - All arguments passed to script or function.|
$? - The exit status of the last command executed.|
$$ - The process ID of the current shell. For shell scripts, this is the process ID under which they are executing.|
$! - The process number of the last background command.|


## 可以识别转义字符，如\n是换行符
echo -e "1\n2"