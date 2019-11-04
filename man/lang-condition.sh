#!/usr/bin/env bash


# 1，数字比较。$[ 1 > 0 ] 与 $(( 1 > 0 )) 与 `expr 1 \> 0` 等同。都返回 1
# 2，字符串、文件、命令都是命令是否成功


if test; then

fi


if test; then

else
    echo
fi


if test; then

elif test; then
    echo
else
    echo
fi

# 目前理解，所有条件都是要运算（即命令），运算成功通过，不成功就走 else
# test , [ , [[ , 命令 ：都一样。 1 > 0
#

# test的三个基本作用是判断文件、判断字符串、判断整数

test, [, [[

### SYNOPSIS
test expression

[ expression ]

[[ expression ]]

let "i += 1"
(( VAR = 0; VAR < ${LOOP_LIMIT}; ++VAR ))
(( ++i ))
(( i++ ))


### [
#"["是一条命令，与test等价,"["与"test"是内部(builtin)命令，
# 换句话说执行"test"/"["时不会调用/some/path/to/test这样的外部命令(如果有这样的命令的话)。


### test
# 命令行里test expr和[ expr ]的效果相同。
# 要注意的有：
# test中可用的比较运算符只有==和!=
# 两者都是用于字符串比较的，不可用于整数比较，整数比较只能使用-eq, -gt这种形式。
# 无论是字符串比较还是整数比较都千万不要使用大于号小于号。当然，如果你实在想用也是可以的，对于字符串比较可以使用尖括号的转义形式，
# 如果比较"ab"和"bc"：[ ab \< bc ]，结果为真，也就是返回状态为0.


### [[]]
#这是内置在shell中的一个命令，支持字符串的模式匹配（使用=~操作符时甚至支持shell的正则表达式）。
# 逻辑组合可以不使用test的-a,-o而使用&&,||


### (())
#(( ))结构扩展并计算一个算术表达式的值。如果表达式值为0，会返回1或假作为退出状态码。$(())
# 一个非零值的表达式返回一个0或真作为退出状态码。这个结构和先前test命令及[]结构的讨论刚好相反。


-f file # file exists and is a regular file
-g file # file exists and has its setgid bit set
-G file # file exists and is owned by the effective group ID
-h file # file exists and is a symbolic link
-k file # file exists and has its sticky bit set
-L file # file exists and is a symbolic link
-N file # file was modified since it was last read
-O file # file exists and is owned by the effective user ID
-p file # file exists and is a pipe or named pipe (FIFO file)
-r file # file exists and is readable
-s file # file exists and is not empty
-S file # file exists and is a socket
-t N    # File descriptor N points to a terminal
-u file # file exists and has its setuid bit set
-w file # file exists and is writeable
-x file # file exists and is executable, or file is a directory that can be searched
fileA -nt fileB # fileA modification time is newer than fileB
fileA -ot fileB # fileA modification time is older than fileB
fileA -ef fileB # fileA and fileB point to the same file
-e file	# 如果文件存在则为真
-r file	# 如果文件存在且可读则为真
-w file	# 如果文件存在且可写则为真
-x file	# 如果文件存在且可执行则为真
-s file	# 如果文件存在且至少有一个字符则为真
-d file	# 如果文件存在且为目录则为真
-f file	# 如果文件存在且为普通文件则为真
-c file	# 如果文件存在且为字符型特殊文件则为真
-b file	# 如果文件存在且为块特殊文件则为真


-n string #string is non-null
-z string # string has a length of zero
stringA = stringB # stringA equals stringB (POSIX version)
stringA == stringB # stringA equals stringB
stringA != stringB # stringA does not match stringB
stringA =~ regexp # stringA matches the extended regular expression regexp[3]
stringA < stringB # stringA sorts before stringB lexicographically
stringA > stringB # stringA sorts after stringB lexicographically

exprA -eq exprB # Arithmetic expressions exprA and exprB are equal
exprA -ne exprB # Arithmetic expressions exprA and exprB are not equal
exprA -lt exprB # exprA is less than exprB
exprA -gt exprB # exprA is greater than exprB
exprA -le exprB # exprA is less than or equal to exprB
exprA -ge exprB # exprA is greater than or equal to exprB
exprA -a exprB # exprA is true and exprB is true
exprA -o exprB # exprA is true or exprB is true


#算数运算
# 运算符	说明	举例
+	# 加法	`expr $a + $b` 结果为 30
-	# 减法	`expr $a - $b` 结果为 10
*	# 乘法	`expr $a \* $b` 结果为 200
/	# 除法	`expr $b / $a` 结果为 2
%	# 取余	`expr $b % $a` 结果为 0
=	# 赋值	a=$b 将把变量 b 的值赋给 a
==	# 相等。用于比较两个数字，相同则返回 true	[ $a == $b ] 返回 false
!=	# 不相等。用于比较两个数字，不相同则返回 true	[ $a != $b ] 返回 true


### 复杂条件
#1.1 判断第一种
#if [ 条件判断一 ] &&(||) [ 条件判断二 ];then
#	待执行命令一
#elif [ 条件判断三 ] &&(||) [ 条件判断四 ];then
#	待执行命令二
#else
#	执行其他
#fi

#1.2 判断第二种
#if [条件判断一 -a(-o) 条件判断二 -a(-o) 条件判断三];then
#	待执行命令一
#elif [ 条件判断四 -a(-o) 条件判断五 ];then
#	待执行命令二
#else
#	执行其他
#fi

#判断第三种
#if [[ 条件判断一 &&(||) 条件判断二 ]];then
#	待执行命令一
#elif [[ 条件判断三 &&(||) 条件判断四 ]];then
#	待执行判断二
#else
#	执行其他
#fi
