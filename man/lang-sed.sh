#!/usr/bin/env bash

### sed是一个面向行的文本处理实用程序：它从输入流或文件中逐行读取文本到一个称为模式空间 的内部缓冲区。
# 每读一行开始一个循环 。对于模式空间，sed会应用sed脚本 指定的一个或多个操作。sed实现了一种编程语言，
# 其中包含大约25个指定文本操作的命令 。对于每个输入行，在运行脚本之后，sed通常输出模式空间（由脚本修改的行），
# 然后从下一行再次开始循环。其他脚本结束行为可通过sed选项和脚本命令获得，
# 例如d删除模式空间，q退出，N立即将下一行添加到模式空间，等等。
# 因此，sed脚本对应于循环体，循环体遍历流的行，其中循环本身和循环变量（当前行号）是隐式的并由sed维护。

sed [options] commands [inputfile...]

### options
-n	取消默认输出
-e	多点编辑，可以执行多个子命令
-f	从脚本文件中读取命令（sed操作可以事先写入脚本，然后通过-f读取并执行）
-i	直接编辑原文件
-l	指定行的长度
-r	在脚本中使用扩展表达式

### commands
a # 新增， a 的后面可以接字串，而这些字串会在新的一行出现(目前的下一行)～
c # 取代， c 的后面可以接字串，这些字串可以取代 n1,n2 之间的行！
d # 删除，因为是删除啊，所以 d 后面通常不接任何咚咚；
i # 插入， i 的后面可以接字串，而这些字串会在新的一行出现(目前的上一行)；
p # 打印，亦即将某个选择的数据印出。通常 p 会与参数 sed -n 一起运行～
s # 取代，可以直接进行取代的工作哩！通常这个 s 的动作可以搭配正规表示法！例如 1,20s/old/new/g 就是啦！


# 在testfile文件的第四行后添加一行，并将结果输出到标准输出
sed -e 4a\newLine testfile

# 第 2~5 行删除
nl /etc/passwd | sed '2,5d'

# 只要删除第 2 行
nl /etc/passwd | sed '2d'

#删除第 3 到最后一行
nl /etc/passwd | sed '3,$d'

# 第二行后(亦即是加在第三行)加上 drink tea
nl /etc/passwd | sed '2a drink tea'
# 第二行前插入
nl /etc/passwd | sed '2i drink tea'

# 第2-5行的内容取代成为 No 2-5 number
nl /etc/passwd | sed '2,5c No 2-5 number'

# 仅列出 /etc/passwd 文件内的第 5-7 行
nl /etc/passwd | sed -n '5,7p'
# 搜索 /etc/passwd有root关键字的行
nl /etc/passwd | sed '/root/p'

# 删除/etc/passwd所有包含root的行，其他行输出
nl /etc/passwd | sed  '/root/d'

# 搜索/etc/passwd,找到root对应的行，执行后面花括号中的一组命令，每个命令之间用分号分隔，这里把bash替换为blueshell，再输出这行：

nl /etc/passwd | sed -n '/root/{s/bash/blueshell/;p;q}'

sed 's/要被取代的字串/新的字串/g'
sed '1,20s/old/new/g'

# 将 IP 前面的部分予以删除
/sbin/ifconfig eth0 | grep 'inet addr' | sed 's/^.*addr://g'

# 一条sed命令，删除/etc/passwd第三行到末尾的数据，并把bash替换为blueshell
nl /etc/passwd | sed -e '3,$d' -e 's/bash/blueshell/'

# 原文件操作：一条sed命令，删除/etc/passwd第三行到末尾的数据，并把bash替换为blueshell
nl /etc/passwd | sed -e '3,$d' -e 's/bash/blueshell/'

# 在 regular_express.txt 最后一行加入 # This is a test:
sed -i '$a # This is a test' regular_express.txt

