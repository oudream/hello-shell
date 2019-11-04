#!/usr/bin/env bash

#    [ function ] funname [()]
#    {
#        action;
#        [return int;]
#    }
#
#    $#	传递到脚本的参数个数
#    $*	以一个单字符串显示所有向脚本传递的参数
#    $$	脚本运行的当前进程ID号
#    $!	后台运行的最后一个进程的ID号
#    $@	与$*相同，但是使用时加引号，并在引号中返回每个参数。
#    $-	显示Shell使用的当前选项，与set命令功能相同。
#    $?	显示最后命令的退出状态。0表示没有错误，其他任何值表明有错误。

add()
{
    a=$1
    b=$2
    ret=`expr $a + $b`
    echo $ret
}

sum1=`add $1 $2`

echo 'hello world'
echo "$1 + $2 = " $sum1

# 注意：add 函数最后是echo 而不是return，这就意味着add 函数中的所有 echo 主程序都收到了。


function adder {
  echo "$(($1 + $2))"
}
sum2=`adder 1 2` # 3