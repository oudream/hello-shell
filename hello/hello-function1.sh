#!/bin/bash

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

demoFun(){
    echo "这是我的第一个 shell 函数!"
}
echo "-----函数开始执行-----"
demoFun
echo "-----函数执行完毕-----"

funWithReturn(){
    echo "这个函数会对输入的两个数字进行相加运算..."
    echo "输入第一个数字: "
    read aNum
    echo "输入第二个数字: "
    read anotherNum
    echo "两个数字分别为 $aNum 和 $anotherNum !"
    return $(($aNum+$anotherNum))
}
funWithReturn
echo "输入的两个数字之和为 $? !"

funWithParam(){
    echo "第一个参数为 $1 !"
    echo "第二个参数为 $2 !"
    echo "第十个参数为 $10 !"
    echo "第十个参数为 ${10} !"
    echo "第十一个参数为 ${11} !"
    echo "参数总数有 $# 个!"
    echo "作为一个字符串输出所有参数 $* !"
}
funWithParam 1 2 3 4 5 6 7 8 9 34 73

