#!/bin/bash

function testString11(){
#    第一种又可以分为四种情况，下面一一介绍。
#    1、使用 # 号操作符。用途是从左边开始删除第一次出现子字符串即其左边字符，保留右边字符。用法为#*stringExist,例如：
    str='http://www.你的域名.com/cut-string.html'
    echo ${str#*//}
#    得到的结果为www.你的域名.com/cut-string.html，即删除从左边开始到第一个"//"及其左边所有字符2、使用 ## 号操作符。用途是从左边开始删除最后一次出现子字符串即其左边字符，保留右边字符。用法为##*stringExist,例如：
    str='http://www.你的域名.com/cut-string.html'
    echo ${str##*/}
#    得到的结果为cut-string.html，即删除最后出现的"/"及其左边所有字符
#    3、使用 % 号操作符。用途是从右边开始删除第一次出现子字符串即其右边字符，保留左边字符。用法为%stringExist*,例如：
    str='http://www.你的域名.com/cut-string.html'
    echo ${str%/*}
#    得到的结果为http://www.你的域名.com，即删除从右边开始到第一个"/"及其右边所有字符
#    4、使用 %% 号操作符。用途是从右边开始删除最后一次出现子字符串即其右边字符，保留左边字符。用法为%%stringExist*,例如：
    str='http://www.你的域名.com/cut-string.html'
    echo ${str%%/*}
#    得到的结果为http://www.你的域名.com，即删除从右边开始到最后一个"/"及其右边所有字符
#
#     第二种也分为四种，分别介绍如下：
#    1、从左边第几个字符开始以及字符的个数，用法为:start:len,例如：
    str='http://www.你的域名.com/cut-string.html'
    echo ${var:0:5}
#    其中的 0 表示左边第一个字符开始，5 表示字符的总个数。
#    结果是：http:
#    2、从左边第几个字符开始一直到结束，用法为:start,例如：
    str='http://www.你的域名.com/cut-string.html'
    echo ${var:7}
#    其中的 7 表示左边第8个字符开始
#    结果是：www.你的域名.com/cut-string.html
#    3、从右边第几个字符开始以及字符的个数，用法:0-start:len,例如：
    str='http://www.你的域名.com/cut-string.html'
    echo ${str:0-15:10}
#    其中的 0-6 表示右边算起第6个字符开始，10 表示字符的个数。
#    结果是：cut-string
#    3、从右边第几个字符开始一直到结束，用法:0-start,例如：
    str='http://www.你的域名.com/cut-string.html'
    echo ${str:0-4}
#    其中的 0-6 表示右边算起第6个字符开始，10 表示字符的个数。
#    结果是：html
#    注：（左边的第一个字符是用 0 表示，右边的第一个字符用 0-1 表示）

#    2.长度
    test='I love china'
    echo ${#test}
#    ${#变量名}得到字符串长度

#    3.截取字串
    test='I love china'
    echo ${test:5}
    echo ${test:5:10}
#    ${变量名:起始:长度}得到子字符串

#    4.字符串删除
    test='c:/windows/boot.ini'
    echo ${test#/}
    echo ${test#*/}
    echo ${test##*/}
    echo ${test%/*}
    echo ${test%%/*}
#    ${变量名#stringExisting正则表达式}从字符串开头开始配备stringExisting,删除匹配上的表达式。
#    ${变量名%stringExisting正则表达式}从字符串结尾开始配备stringExisting,删除匹配上的表达式。
#    注意：${test##/},${test%/} 分别是得到文件名，或者目录地址最简单方法。

#    4.字符串删除
    test='c:/windows/boot.ini'
    echo ${test#/}
    echo ${test#*/}
    echo ${test##*/}
    echo ${test%/*}
    echo ${test%%/*}
#    ${变量名#stringExisting正则表达式}从字符串开头开始配备stringExisting,删除匹配上的表达式。
#    ${变量名%stringExisting正则表达式}从字符串结尾开始配备stringExisting,删除匹配上的表达式。
#    注意：${test##/},${test%/} 分别是得到文件名，或者目录地址最简单方法。


}
echo "-----testString11 begin-----"
testString11
echo "-----testString11 end-----"


function testStringSplit11(){
    a="one,two,three,four"
    #要将$a分割开，可以这样：
    OLD_IFS="$IFS"
    IFS=","
    arr=($a)
    IFS="$OLD_IFS"
    for s in ${arr[@]};do echo "$s"; done
}
echo "-----testStringSplit11 begin-----"
testStringSplit11
echo "-----testStringSplit11 end-----"



### --- --- --- existString begin: --- --- ---
function stringExist
{
    STRING_A=$1
    STRING_B=$2

    if [[ ${STRING_A/${STRING_B}//} == $STRING_A ]]
    then
        ## is not exist.
        echo N
        return 0
    else
        ## is string exist.
        echo Y
        return 1
    fi
}

function testStringExist11(){
    stringExist "ThisIsAString" "stringExisting" # should output N
    stringExist "ThisIsAString" "String" # should output Y
}
echo "-----testStringExist11 begin-----"
testStringExist11
echo "-----testStringExist11 end-----"

function testStringExist12(){
    strA="dkasnfk"
    strB="asn"
    strC="knk"

    result=$(echo $strA | grep "${strC}")
    if [[ "$result" != "" ]]
    then
        echo "True"
    else
        echo "False"
    fi
}
echo "-----testStringExist12 begin-----"
testStringExist12
echo "-----testStringExist12 end-----"

### --- --- --- existString end. --- --- ---


### --- --- --- catchString begin: --- --- ---

### python
# import re
# str = u'陈奕迅演唱(十年)、(浮夸)、(不要说话)'
# print re.findall('\((.*?)\)', str)

# sed 就用这个吧
function catchString11() {
    s1="Here is a String"
    # 替换为组1
    s2=$(echo $s1 | sed -e 's/Here\(.*\)String/\1/')
    echo $s2
}

# grep
function catchString12() {
    a='abc[edg]adfirpqu'
    echo $a | grep -o '\[.*\]'  #中括号的处理需要转义
    # [edg]

    b='abc(edg)adfirpqu'
    echo $b|grep -o '(.*)'
    (edg)
}

# cut
function catchString12() {
    a='abc[edg]adfirpqu'
    echo $a|cut -d '[' -f2|cut -d ']' -f1
    # edg

    b='abc(edg)adfirpqu'
    echo $b | cut -d '(' -f 2 | cut -d ')' -f 1
    # edg
}

# string
function catchString12() {
    a='abc[edg]adfjaierqpwe'
    b=${a#*[}
    echo $b
    # edg]adfjaierqpwe

    c=${b%]*}
    echo $c
    # edg
}
### --- --- --- catchString end. --- --- ---


s1=aa.b; [[ $s1 =~ a.b ]] && echo 'y' || echo 'n'