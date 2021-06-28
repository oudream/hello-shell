#!/usr/bin/env bash

# 替换文本中的字符串：
sed -i 's/book/books/' file # -i 直接修改读取的文件内容（起到保存作用）
sed -i 's/book/books/g' file # 全面替换标记g
# 正则表达式 \w\+ 匹配每一个单词，使用 [&] 替换它，& 对应于之前所匹配到的单词：
echo this is a test line | sed 's/\w\+/[&]/g'
#    [this] [is] [a] [test] [line]
# 所有以192.168.0.1开头的行都会被替换成它自已加localhost：
sed 's/^192.168.0.1/&localhost/' file
# 命令中 digit 7，被替换成了 7。样式匹配到的子串是 7，\(..\) 用于匹配子串，对于匹配到的第一个子串就标记为 \1，依此类推匹配到的第二个结果就是 \2
echo this is digit 7 in a number | sed 's/digit \([0-9]\)/\1/'
#    this is 7 in a number
echo aaa BBB | sed 's/\([a-z]\+\) \([A-Z]\+\)/\2 \1/'
#    BBB aaa
# love被标记为1，所有loveable会被替换成lovers，并打印出来：
sed -n 's/\(love\)able/\1rs/p' file


# -n选项和p命令一起使用表示只打印那些发生替换的行：
sed -n 's/test/TEST/p' file


# 删除空白行：
sed '/^$/d' file
# 删除文件的第2行：
sed '2d' file
# 删除文件的第2行到末尾所有行：
sed '2,$d' file
# 删除文件最后一行：
sed '$d' file
# 删除文件中所有开头是test的行：
sed '/^test/'d file


# 通过加入一个参数，可以将原文件做个备份。
# 以下命令会对原filepath1文件生效，并生成一个filepath1.bak文件。强烈建议使用i参数同时指定bak文件。
sed -i.bak 's/a/b/' filepath1
IFS_B=IFS;IFS=;s1="$(sed -n '/mountPath/p' nfs-pvc-deploy.yaml)";IFS=IFS_B;
echo $s1
#           mountPath: /usr/share/nginx/html
s2=$(echo $s1 | sed -e 's/mountPath:\(.*\)$/\1/')
echo $s2
#           /usr/share/nginx/html


IFS_B=IFS;IFS=;s1="$(sed -n '/mountPath/p' nfs-pvc-deploy.yaml)"; \
s2=$(echo $s1 | sed -e 's/mountPath:\(.*\)$/subPath: nginx-pvc-test/'); \
sed -i.bak "/mountPath/ i \\${s2}" nfs-pvc-deploy.yaml; \
IFS=IFS_B;


open https://man.linuxde.net/sed
# sed是一种流编辑器，它是文本处理中非常中的工具，能够完美的配合正则表达式使用，功能不同凡响。
# 处理时，把当前处理的行存储在临时缓冲区中，称为“模式空间”（pattern space），接着用sed命令处理缓冲区中的内容，处理完成后，
# 把缓冲区的内容送往屏幕。接着处理下一行，这样不断重复，直到文件末尾。
# 文件内容并没有 改变，除非你使用重定向存储输出。
# Sed主要用来自动编辑一个或多个文件；简化对文件的反复操作；编写转换程序等。

### 两种用法
sed [options] 'command' file(s)
sed [options] -f scriptfile file(s)

## 选项：
# -n ：使用安静(silent)模式。在一般 sed 的用法中，所有来自 STDIN 的数据一般都会被列出到终端上。但如果加上 -n 参数后，
#    则只有经过sed 特殊处理的那一行(或者动作)才会被列出来。
# -e ：-e<script>或--expression=<script>：以选项中的指定的script来处理输入的文本文件；
# -f ：直接将 sed 的动作写在一个文件内， -f filename 则可以运行 filename 内的 sed 动作；
# -r ：sed 的动作支持的是延伸型正规表示法的语法。(默认是基础正规表示法语法)
# -i ：直接修改读取的文件内容，而不是输出到终端。


## 动作说明： [n1[,n2]]function
# n1,n2 a : 可以空格也可以不空格

## n1, n2 ：不见得会存在，一般代表『选择进行动作的行数』，
#    举例来说，如果我的动作是需要在 10 到 20 行之间进行的，则『 10,20[动作行为] 』
# 5 选择第5行。
# 2,5 选择2到5行，共4行。
# 1~2 选择奇数行。
# 2~2 选择偶数行。
# 2,+3 和2,5的效果是一样的，共4行。
# 2,$ 从第二行到文件结尾。

## 范围的选择还可以使用正则匹配。请看下面示例。
# /sys/,+3 选择出现sys字样的行，以及后面的三行。
# /^sys/,/mem/ 选择以sys开头的行，和出现mem字样行之间的数据。


# function：
# a ：新增， a 的后面可以接字串，而这些字串会在新的一行出现(目前的下一行)～
# c ：取代， c 的后面可以接字串，这些字串可以取代 n1,n2 之间的行！
# d ：删除，因为是删除啊，所以 d 后面通常不接任何咚咚；
# i ：插入， i 的后面可以接字串，而这些字串会在新的一行出现(目前的上一行)；
# p ：列印，亦即将某个选择的数据印出。通常 p 会与参数 sed -n 一起运行～
# s ：取代，可以直接进行取代的工作哩！通常这个 s 的动作可以搭配正规表示法！例如 1,20s/old/new/g 就是啦！


# sed元字符集
#    ^ 匹配行开始，如：/^sed/匹配所有以sed开头的行。
#    $ 匹配行结束，如：/sed$/匹配所有以sed结尾的行。
#    . 匹配一个非换行符的任意字符，如：/s.d/匹配s后接一个任意字符，最后是d。
#    * 匹配0个或多个字符，如：/*sed/匹配所有模板是一个或多个空格后紧跟sed的行。
#    [] 匹配一个指定范围内的字符，如/[ss]ed/匹配sed和Sed。
#    [^] 匹配一个不在指定范围内的字符，如：/[^A-RT-Z]ed/匹配不包含A-R和T-Z的一个字母开头，紧跟ed的行。
#    \(..\) 匹配子串，保存匹配的字符，如s/\(love\)able/\1rs，loveable被替换成lovers。
#    & 保存搜索字符用来替换其他字符，如s/love/**&**/，love这成**love**。
#    \< 匹配单词的开始，如:/\<love/匹配包含以love开头的单词的行。
#    \> 匹配单词的结束，如/love\>/匹配包含以love结尾的单词的行。
#    x\{m\} 重复字符x，m次，如：/0\{5\}/匹配包含5个0的行。
#    x\{m,\} 重复字符x，至少m次，如：/0\{5,\}/匹配至少有5个0的行。
#    x\{m,n\} 重复字符x，至少m次，不多于n次，如：/0\{5,10\}/匹配5~10个0的行。

# 定界符
# 以上命令中字符 / 在sed中作为定界符使用，也可以使用任意的定界符：
sed 's:test:TEXT:g'
sed 's|test|TEXT|g'
# 定界符出现在样式内部时，需要进行转义：
sed 's/\/bin/\/usr\/local\/bin/g'


# 文件头增加
sed -i '1 i --- the end ---' filepath1
# 文件尾增加
sed -i '$ a --- the end ---' filepath1
# 删除所有#开头的行和空行。
sed -e 's/#.*//' -e '/^$/ d' filepath1
# 表示打印group文件中的第二行。
sed -n '2p' /etc/group
# /sys/,+3 选择出现sys字样的行，以及后面的三行。
sed '/sys/,+3 s/a/b/g' file
# /^sys/,/mem/ 选择以sys开头的行，和出现mem字样行之间的数据。
sed '/^sys/,/mem/s/a/b/g' file


## flag 参数
# 这些参数可以单个使用，也可以使用多个，仅介绍最常用的。
# g 默认只匹配行中第一次出现的内容，加上g，就可以全文替换了。常用。
# p 当使用了-n参数，p将仅输出匹配行内容。
# w 和上面的w模式类似，但是它仅仅输出有变换的行。
# i 这个参数比较重要，表示忽略大小写。
# e 表示将输出的每一行，执行一个命令。不建议使用，可以使用xargs配合完成这种功能。
# 看两个命令的语法：
sed -n 's/a/b/gipw output.txt' file
sed 's/^/ls -la/e' file


##好玩
# 由于正则的关系，很多字符需要转义。你会在脚本里做些很多\\，\*之类的处理。你可以使用|^@!四个字符来替换\。
# 比如，下面五个命令是一样的。
sed '/aaa/s/\/etc/\/usr/g' file
sed '/aaa/s@/etc@/usr@g' file
sed '/aaa/s^/etc^/usr^g' file
sed '/aaa/s|/etc|/usr|g' file
sed '/aaa/s!/etc!/usr!g' file
# 注意：前半部分的范围是不能使用这种方式的。我习惯使用符号@。


# 输出长度不小于50个字符的行
sed -n '/^.{50}/p'
# 统计文件中有每个单词出现了多少次
sed 's/ /\n/g' file | sort | uniq -c
# 查找目录中的py文件，删掉所有行级注释
find ./ -name "*.py" | xargs sed -i.bak '/^[ ]*#/d'
# 查看第5-7行和10-13行
sed -n -e '5,7p' -e '10,13p' file
# 仅输出ip地址
ip route show | sed -n '/src/p' | sed -e 's/ */ /g' | cut -d' ' -f9


