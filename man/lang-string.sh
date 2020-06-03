#!/usr/bin/env bash

#!/bin/sh

### 字符串类型: 单引号，双引号和不添加
### 单引号不对相关量进行替换，如不对$符号解释成变量引用，从而用对应变量的值替代，双引号则会进行替代


### 字符比较
#    str1 = str2        # str1 matches str2
#    str1 != str2       # str1 does not match str2
#    str1 < str2        # str1 is less than str2
#    str1 > str2        # str1 is greater than str2
#    -n str1            # str1 is not null (has length greater than 0)
#    -z str1            # str1 is null (has length 0)
#    str1 =~ str1       # matching POSIX regular expressions in the [[ conditional command.

#    一、判断读取字符串值**
#
#    表达式 含义
#
#    ${var}             变量var的值, 与$var相同
#    ${var-DEFAULT}     如果var没有被声明, 那么就以$DEFAULT作为其值 *
#    ${var:-DEFAULT}    如果var没有被声明, 或者其值为空, 那么就以$DEFAULT作为其值 *
#    ${var=DEFAULT}     如果var没有被声明, 那么就以$DEFAULT作为其值 *
#    ${var:=DEFAULT}    如果var没有被声明, 或者其值为空, 那么就以$DEFAULT作为其值 *
#    ${var+OTHER}       如果var声明了, 那么其值就是$OTHER, 否则就为null字符串
#    ${var:+OTHER}      如果var被设置了, 那么其值就是$OTHER, 否则就为null字符串
#    ${var?ERR_MSG}     如果var没被声明, 那么就打印$ERR_MSG *
#    ${var:?ERR_MSG}    如果var没被设置, 那么就打印$ERR_MSG *
#    ${!varprefix*}     匹配之前所有以varprefix开头进行声明的变量
#    ${!varprefix@}     匹配之前所有以varprefix开头进行声明的变量
#    加入了“*”  不是意思是： 当然, 如果变量var已经被设置的话, 那么其值就是$var.

#    二、字符串操作（长度，读取，替换 )
#
#    表达式 含义
#
#    ${#string}                             $string的长度
#    ${string:position}                     在$string中, 从位置$position开始提取子串
#    ${string:position:length}              在$string中, 从位置$position开始提取长度为$length的子串
#    ${string#stringExisting}               从变量$string的开头, 删除最短匹配$stringExisting的子串
#    ${string##stringExisting}              从变量$string的开头, 删除最长匹配$stringExisting的子串
#    ${string%stringExisting}               从变量$string的结尾, 删除最短匹配$stringExisting的子串
#    ${string%%stringExisting}              从变量$string的结尾, 删除最长匹配$stringExisting的子串
#    ${string/stringExisting/replacement}   使用$replacement, 来代替第一个匹配的$stringExisting
#    ${string//stringExisting/replacement}  使用$replacement, 代替所有匹配的$stringExisting
#    ${string/#stringExisting/replacement}  如果$string的前缀匹配$stringExisting, 那么就用$replacement来代替匹配到的$stringExisting
#    ${string/%stringExisting/replacement}  如果$string的后缀匹配$stringExisting, 那么就用$replacement来代替匹配到的$stringExisting
#    说明："* $stringExisting”可以是一个正则表达式。


A="$1"
B="$2"

echo "输入的原始值：A=$A,B=$B"

#判断字符串是否相等
if [ "$A" = "$B" ];then
    echo "[ = ]"
fi

#判断字符串是否相等，与上面的=等价
if [ "$A" == "$B" ];then
    echo "[ == ]"
fi

#注意:==的功能在[[]]和[]中的行为是不同的，如下

#如果$a以”a”开头(模式匹配)那么将为true
if [[ "$A" == a* ]];then
    echo "[[ ==a* ]]"
fi

#如果$a等于a*(字符匹配),那么结果为true
if [[ "$A" == "a*" ]];then
echo "==/"a*/""
fi

#File globbing(通配) 和word splitting将会发生, 此时的a*会自动匹配到对应的当前以a开头的文件
#如在当前的目录中有个文件：add_crontab.sh,则下面会输出ok
#if [ "add_crontab.sh" == a* ];then
#echo "ok"
#fi
if [ "$A" == a* ];then
    echo "[ ==a* ]"
fi

#如果$a等于a*(字符匹配),那么结果为true
if [ "$A" == "a*" ];then
    echo "==/"a*/""
fi

#字符串不相等
if [ "$A" != "$B" ];then
    echo "[ != ]"
fi

#字符串不相等
if [[ "$A" != "$B" ]];then
    echo "[[ != ]]"
fi

#字符串不为空，长度不为0
if [ -n "$A" ];then
    echo "[ -n ]"
fi

#字符串为空.就是长度为0.
if [ -z "$A" ];then
    echo "[ -z ]"
fi

# < 小于：在ASCII字母顺序下来比较
#需要转义<，否则认为是一个重定向符号
if [ $A /< $B ];then
    echo "[ < ]"
fi

if [[ $A < $B ]];then
echo "[[ < ]]"
fi

# > 小于：在ASCII字母顺序下来比较
#需要转义>，否则认为是一个重定向符号
if [ $A /> $B ];then
echo "[ > ]"
fi

if [[ $A > $B ]];then
echo "[[ > ]]"
fi


### Length
STRING="this is a string"
echo ${#STRING}            # 16


### Index
STRING="this is a string"
SUBSTRING="hat"
expr index "$STRING" "$SUBSTRING"     # 1 is the position of the first 't' in $STRING


# Substring Extraction
STRING="this is a string"
POS=1
LEN=3
echo ${STRING:$POS:$LEN}   # his

STRING="this is a string"
echo ${STRING:1}           # $STRING contents without leading character
echo ${STRING:12}          # ring


# extraction 截取
DATARECORD="last=Clifford,first=Johnny Boy,state=CA"
COMMA1=`expr index "$DATARECORD" ','`  # 14
CHOP1FIELD=${DATARECORD:$COMMA1}       # first=Johnny Boy,state=CA
COMMA2=`expr index "$CHOP1FIELD" ','`  # 17
LENGTH=`expr $COMMA2 - 6 - 1`          # 10
FIRSTNAME=${CHOP1FIELD:6:$LENGTH}      # Johnny Boy


# [[]]
[[


# IFS 默认为 空格
# 所以在变量赋值时，空格会用作拆分符号
a="one,two,three,four"
# 要将$a分割开，可以这样：
OLD_IFS="$IFS"
IFS=","
arr=($a)
IFS="$OLD_IFS"
for s in ${arr[@]};do echo "$s"; done
#one
#two
#three
#four


