#!/usr/bin/env bash

awk -F, '{print $1,$2}'   log.txt

awk 'END{ print NR }' filename


# https://wangchujiang.com/linux-command/c/awk.html

# 它依次处理文件的每一行，并读取里面的每一个字段。对于日志、CSV 那样的每行格式相同的文本文件，awk可能是最方便的工具。
# awk是一个强大的文本分析工具，相对于grep的查找，sed的编辑，awk在其对数据分析并生成报告时，显得尤为强大。
# 简单来说awk就是把文件逐行的读入，以空格为默认分隔符将每行切片，切开的部分再进行各种分析处理。
# awk有3个不同版本: awk、nawk和gawk，未作特别说明，一般指gawk，gawk 是 AWK 的 GNU 版本。

# awk命令格式和选项
# 语法形式
awk [options] 'script' var=value file(s)
awk [options] -f scriptfile var=value file(s)

#    常用命令选项
#    -F fs fs指定输入分隔符，fs可以是字符串或正则表达式，如-F:
#    -v var=value 赋值一个用户定义变量，将外部变量传递给awk
#    -f scripfile 从脚本文件中读取awk命令
#    -m[fr] val 对val值设置内在限制，-mf选项限制分配给val的最大块数目；-mr选项限制记录的最大数目。这两个功能是Bell实验室版awk的扩展功能，在标准awk中不适用。


# 使用","分割
awk -F, '{print $1,$2}'   log.txt

# 打印每一行的第二和第三个字段：
awk '{ print $2,$3 }' filename

# 统计文件中的行数：
awk 'END{ print NR }' filename

echo -e "A line 1\nA line 2" | awk 'BEGIN{ print "Start" } { print } END{ print "End" }'


# 将外部变量值传递给awk
# 借助 -v选项 ，可以将外部值（并非来自stdin）传递给awk：
VAR=10000
echo | awk -v VARIABLE=$VAR '{ print VARIABLE }'

# 当使用不带参数的print时，它就打印当前行，当print的参数是以逗号进行分隔时，
# 打印时则以空格作为定界符。在awk的print语句块中双引号是被当作拼接符使用，例如：
echo | awk '{ var1="v1"; var2="v2"; var3="v3"; print var1,var2,var3; }'
# 双引号拼接使用：
echo | awk '{ var1="v1"; var2="v2"; var3="v3"; print var1"="var2"="var3; }'

echo -e "line1 f2 f3\nline2 f4 f5\nline3 f6 f7" | awk '{print "Line No:"NR", No of fields:"NF, "$0="$0, "$1="$1, "$2="$2, "$3="$3}'

# 使用print $NF可以打印出一行中的最后一个字段，使用$(NF-1)则是打印倒数第二个字段，其他以此类推：
echo -e "line1 f2 f3n line2 f4 f5" | awk '{print $NF}'
echo -e "line1 f2 f3n line2 f4 f5" | awk '{print $(NF-1)}'

#    awk内置变量（预定义变量）
#    说明：[A][N][P][G]表示第一个支持变量的工具，[A]=awk、[N]=nawk、[P]=POSIXawk、[G]=gawk
#
#     **$n**  当前记录的第n个字段，比如n为1表示第一个字段，n为2表示第二个字段。
#     **$0**  这个变量包含执行过程中当前行的文本内容。
#    [N]  **ARGC**  命令行参数的数目。
#    [G]  **ARGIND**  命令行中当前文件的位置（从0开始算）。
#    [N]  **ARGV**  包含命令行参数的数组。
#    [G]  **CONVFMT**  数字转换格式（默认值为%.6g）。
#    [P]  **ENVIRON**  环境变量关联数组。
#    [N]  **ERRNO**  最后一个系统错误的描述。
#    [G]  **FIELDWIDTHS**  字段宽度列表（用空格键分隔）。
#    [A]  **FILENAME**  当前输入文件的名。
#    [P]  **FNR**  同NR，但相对于当前文件。
#    [A]  **FS**  字段分隔符（默认是任何空格）。
#    [G]  **IGNORECASE**  如果为真，则进行忽略大小写的匹配。
#    [A]  **NF**  表示字段数，在执行过程中对应于当前的字段数。
#    [A]  **NR**  表示记录数，在执行过程中对应于当前的行号。
#    [A]  **OFMT**  数字的输出格式（默认值是%.6g）。
#    [A]  **OFS**  输出字段分隔符（默认值是一个空格）。
#    [A]  **ORS**  输出记录分隔符（默认值是一个换行符）。
#    [A]  **RS**  记录分隔符（默认是一个换行符）。
#    [N]  **RSTART**  由match函数所匹配的字符串的第一个位置。
#    [N]  **RLENGTH**  由match函数所匹配的字符串的长度。
#    [N]  **SUBSEP**  数组下标分隔符（默认值是34）。