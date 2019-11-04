#!/usr/bin/env bash

# xargs
# xargs是一条Unix和类Unix操作系统的常用命令。它的作用是将参数列表转换成小块分段传递给其他命令，以避免参数列表过长的问题[1]。
# xargs的作用一般等同于大多数Unix shell中的反引号，但更加灵活易用，并可以正确处理输入中有空格等特殊字符的情况。
# 对于经常产生大量输出的命令如find、locate和grep来说非常有用。
rm $(find /path -type f)
# 如果path目录下文件过多就会因为“参数列表过长”而报错无法执行。但改用xargs以后，问题即获解决。
find /path -type f -print0 | xargs -0 rm
# -print0表示输出以null分隔（-print使用换行）；-0表示输入以null分隔。这样要比如下使用find命令效率高的多。

find . -name "*.foo" | xargs grep bar
# 该命令大体等价于
grep bar $(find . -name "*.foo")
find . -name "*.foo" -print0 | xargs -0 grep bar

# 之所以能用到这个命令，关键是由于很多命令不支持|管道来传递参数，而日常工作中有有这个必要，所以就有了 xargs 命令，例如：
find /sbin -perm +700 |ls -l       #这个命令是错误的
find /sbin -perm +700 |xargs ls -l   #这样才是正确的

cat test.txt | xargs -n3
#a b c
#d e f
#g h i

# 以 X 划分字符串
echo "nameXnameXnameXname" | xargs -dX -n2
#name name
#name name

# xargs 的一个选项 -I，使用 -I 指定一个替换字符串 {}，这个字符串在 xargs 扩展时会被替换掉，
# 当 -I 与 xargs 结合使用，每一个参数命令都会被执行一次：
cat arg.txt | xargs -I {} ./sk.sh -p {} -l
#-p aaa -l
#-p bbb -l
#-p ccc -l