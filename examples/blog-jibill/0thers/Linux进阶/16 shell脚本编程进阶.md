本章概要：循环控制(for/while/until/select)、函数、数组、declare、eval、expect等。

@[TOC](本意内容)

# 循环控制
## for
+ for格式
```bash
#格式1
for 变量名 in 列表 ; do
       循环体
done

#格式2
for ((i=1;i<j;i++))
do
       循环体
done
```

+ 列表生成方式
       1. 直接给出
       2. 整数列表`{1..100[..步进]}、$(seq [start [stop]] end)`
       3. 变量引用`$@、$*`

## while
+ 当CONDITION为真时。循环
```bash
#当CONDITION为真时。循环
while CONDITION ; do
       循环体
done

#无限循环
while :
do
       statement
done
```
+ 遍历文件的每一行，赋值给line
```bash
while read line ; do
       statement
done < /path/file
```

## until
直到CONDITION为真时。退出循环
```bash
#直到CONDITION为真时。退出循环
until CONDITION ; do
       循环体
done
```

## select
1. 循环主要用于创建菜单,显示 PS3 提示符，等待用户输入
2. 用户输入被保存在内置变量 REPLY 中
3. select 是个无限循环，用 break退出循环，或用 exit 命令终止脚本。

```bash
select var in list
do
       statement 
done
```

## continue、break、shift
+ N层循环是指循环嵌套的层
continue [N]：提前结束第N层的本轮循环，而直接进入下一轮判断
break [N]：提前结束第N层循环，最内层为第1层
+ 参量列表是指：脚本输入的参数
shift [N]：用于将参量列表 list 左移指定次数，缺省为左移一次

+ 示例
```bash
[root.CentOS 7] ➤ cat break.sh
while [ $# -gt 0 ] # or (( $# > 0 ))
do
echo $*
shift
done

[root.CentOS 7] ➤ bash break.sh 1 2 3 45 6 7 8 9 0
1 2 3 45 6 7 8 9 0
2 3 45 6 7 8 9 0
3 45 6 7 8 9 0
45 6 7 8 9 0
6 7 8 9 0
7 8 9 0
8 9 0
9 0
0

```

#  函数
## 定义函数
```bash
#语法1（推荐）
fname (){
       函数体
}

#语法2
function fname{
       函数体
}

#语法3
function fname() {
       函数体
}
```
## 函数返回值(return)
1. return 从函数中返回，用最后状态命令决定返回值
2. return 0 无错误返回
3. return 1-255 有错误返回

## 函数文件
1. 创建函数文件
```bash
> cat function.main
#!/bin/bash
findit(){
       echo hello
}
```

2. 载入函数
```bash
. function.main
或
source function.main
```

3. 删除函数
```bash
unset function_name
```

3. 环境函数
使子进程也可使用
声明：export -f function_name
查看：export -f 或 declare -xf

4. 函数参数
函数也可以使用`$1,$2,$@,$*,$#`
函数局部变量：`local NAME=VALUE`

5. 函数递归
```bash
#!/bin/bash
#
fact() {
if [ $1 -eq 0 -o $1 -eq 1 ]; then
       echo 1
       else
       echo $[$1*$(fact $[$1-1])]
       fi
}
#函数调用
fact $1
```

# 信号捕捉trap
> 信号可以用"kill -l"查看可用信号
+ trap '触发指令' 信号
进程收到系统发出的指定信号后，将执行自定义指令，而不会执行原操作
+ trap '' 信号
忽略信号的操作
+ trap '-' 信号
恢复原信号的操作
+ trap -p
列出自定义信号操作
+ trap finish EXIT
当脚本退出时，执行finish函数

```bash
#!/bin/bash
trap 'echo “signal:SIGINT"' int
trap -p
for((i=0;i<=10;i++))
do
sleep 1
echo $i
done
trap '' int
trap -p
for((i=11;i<=20;i++))
do
sleep 1
echo $i
done
trap '-' int
trap -p
for((i=21;i<=30;i++))
do
sleep 1
echo $i
done
```

# 数组
1. 索引：编号从0开始，属于数值索引
2. 声明数组：
`declare -a ARRAY_NAME`
`declare -A ARRAY_NAME 关联数组`
3. 数组元素的赋值
(1) 一次只赋值一个元素
`ARRAY_NAME[INDEX]=VALUE`
(2) 一次赋值全部元素
`ARRAY_NAME=("VAL1" "VAL2" "VAL3" ...)`
(3) 只赋值特定元素
`ARRAY_NAME=([0]="VAL1" [3]="VAL2" ...)`
(4) 交互式数组值对赋值
`read -a ARRAY`
4. 显示所有数组：`declare -a`
5. 引用数组元素
`${ARRAY_NAME[INDEX]}`
注意：省略[INDEX]表示引用下标为0的元素
6. 引用数组所有元素
`${ARRAY_NAME[*]}`
`${ARRAY_NAME[@]}`
7. 数组的长度(数组中元素的个数)
`${#ARRAY_NAME[*]}`
`${#ARRAY_NAME[@]}`
8. 删除数组中的某元素：导致稀疏格式
`unset ARRAY[INDEX]`
9. 删除整个数组
`unset ARRAY`
10. 数组切片：
`${ARRAY[@]:offset:number}`
offset 要跳过的元素个数
number 要取出的元素个数
取偏移量之后的所有元素 ${ARRAY[@]:offset}
11. 向数组中追加元素：
`ARRAY[${#ARRAY[*]}]=value`
12. 关联数组：
`declare -A ARRAY_NAME`
ARRAY_NAME=([idx_name1]='val1' [idx_name2]='val2‘...)
注意：关联数组必须先声明再调用

# 字符串切片
1. `${#var}`: 返回字符串变量var的长度
2. `${var:offset}`: 返回字符串变量var中从第offset个字符后（不包括第offset个字符）的字符开始，到最后的部分，offset的取值在0 到 ${#var}-1 之间(bash4.2后，允许为负值)
3. `${var:offset:number}`：返回字符串变量var中从第offset个字符后（不包括第offset个字符）的字符开始，长度为number的部分
4. `${var: -length}`：取字符串的最右侧几个字符
注意：冒号后必须有一空白字符
5. `${var:offset:-length}`：从最左侧跳过offset字符，一直向右取到距离最右侧lengh个字符之前的内容
6. `${var: -length:-offset}`：先从最右侧向左取到length个字符开始，再向右取到距离最右侧offset个字符之间的内容
注意：-length前空格

## 基于模式取子串(# → ，% ←)
### 1. 搜索删除
1. `${var#*word}`：其中word可以是指定的任意字符
功能：自左而右，查找var变量所存储的字符串中，第一次出现的word, 删除字符串开头至第一次出现word字符串（含）之间的所有字符
2. `${var##*word}`：同上，贪婪模式，不同的是，删除的是字符串开头至最后一次由word指定的字符之间的所有内容
+ 示例：

```bash
file=“var/log/messages”
${file#*/}: log/messages
${file##*/}: messages
```

3. `${var%word*}`：其中word可以是指定的任意字符
功能：自右而左，查找var变量所存储的字符串中，第一次出现的word, 删除字符串最后一个字符向左至第一次出现word字符串（含）之间的所有字符
file="/var/log/messages"
${file%/*}: /var/log
4. `${var%%word*}`：同上，只不过删除字符串最右侧的字符向左至最后一次出现word字符之间的所有字符
+ 示例：

```bash
url=http://www.magedu.com:80
${url##*:} 80
${url%%:*} http
```

### 2. 查找替换

1. `${var/pattern/substr}`：查找var，第一次被pattern所匹配，以substr替换之
2. `${var//pattern/substr}`: 查找var，所有能被pattern所匹配，以substr替换之
3. `${var/#pattern/substr}`：查找var，行首被pattern所匹配，以substr替换之
4. `${var/%pattern/substr}`：查找var，行尾被pattern所匹配，以substr替换之

### 3. 查找并删除

1. `${var/pattern}`  # 删除var第一次被pattern匹配的
2. `${var//pattern}` # 删除var所有被pattern匹配的
3. `${var/#pattern}` # 删除var所有以pattern为行首匹配的
4. `${var/%pattern}` # 删除var所有以pattern为行尾所匹配的

### 4. 字符大小写转换

1. `${var^^}`：把var中的所有小写字母转换为大写
2. `${var,,}`：把var中的所有大写字母转换为小写


+ 变量赋值

变量配置方式|str没有配置|str为空|str已配置并非空
-|-|-|-
`var=${str-expr`}|var=expr|var=|var=$str
`var=${str:-expr}`|var=expr|var=expr|var=$str
`var=${str+expr}`|var=|var=expr|var=expr
`var=${str:+expr}`|var=|var=|var=expr
`var=${str=expr}`|var=expr<p>str=expr|str不变<p>var=|str不变<p>var=$str
`var=${str:=expr}`|var=str=expr|var=str=expr|str不变<p>var=$str
`var=${str?expr}`|expr输出到stderr|var=|var=$str
`var=${str:?expr}`|expr输出到stderr|expr输出到stderr|var=$str

# 高级变量用法-有类型变量
Shell变量一般是无类型的，但是bash Shell提供了declare和typeset两个命令用于指定变量的类型，两个命令是等价的

## declare [选项] 变量名

[OPTION]|意义
-|-
`-r `|声明或显示只读变量
`-i `|将变量定义为整型数
`-a `|将变量定义为数组
`-A `|将变量定义为关联数组
`-f `|显示已定义的所有函数名及其内容
`-F `|仅显示已定义的所有函数名
`-x `|声明或显示环境变量和函数
`-l `|声明变量为小写字母 declare –l var=UPPER
`-u `|声明变量为大写字母 declare –u var=lower

## eval
>eval命令将会首先扫描命令行进行所有的置换，然后再执行该命令。该命令适用于那些一次扫描无法实现其功能的变量.该命令对变量进行两次扫描

+示例：

```bash
[root@server ~]# CMD=whoami
[root@server ~]# echo $CMD
whoami
[root@server ~]# eval $CMD
root
[root@server ~]# n=10
[root@server ~]# echo {0..$n}
{0..10}
[root@server ~]# eval echo {0..$n}
0 1 2 3 4 5 6 7 8 9 10
```

## 间接变量引用
1. `eval var1=\$$var2`
2. `var1=${!var2}`

```bash
[root@localhost ~]$var1=var2
[root@localhost ~]$var2=mage
[root@localhost ~]$echo $var1
var2
[root@localhost ~]$echo \$$var1
$var2
[root@localhost ~]$eval echo \$$var1
mage
[root@localhost ~]$echo ${!var1}
mage
```

## 命令：mktemp
创建并显示临时文件，可避免冲突
`mktemp [OPTION]... [TEMPLATE]`
*TEMPLATE: filenameXXX(X是随机数)*

[OPTION]|意义 
-|-
-d| 创建临时目录
-p DIR或--tmpdir=DIR|指明临时文件所存放目录位置

+ 示例：

```bash
mktemp /tmp/testXXX
tmpdir=`mktemp –d /tmp/testdirXXX`
mktemp --tmpdir=/testdir testXXXXXX
```

## 命令：install
复制文件并设置属性
`install [OPTION]... SOURCE... DIRECTORY`

[OPTION]|意义 
-|-
-m MODE|默认755
-o OWNER|所有者
-g GROUP|所属组
-d DIR | 创建空目录

+ 示例：

```bash
#复制文件file1,2,3到dir
install -t dir file1 file2 file3

#复制文件srcfile到desfile并设置属性
install -m 700 -o wang -g admins srcfile desfile

#创建目录/testdir/installdir并设置属性
install –m 770 –d /testdir/installdir
```

## expect
>expect 是由Don Libes基于Tcl（ Tool Command Language ）语言开发的，主要应用于自动化交互式操作的场景，借助 expect 处理交互的命令，可以将交互过程如：ssh登录，ftp登录等写在一个脚本上，使之自动化完成。尤其适用于需要对多台服务器执行相同操作的环境中，可以大大提高系统管理人员的工作效率

+ expect 语法：
`expect [选项] [ -c cmds ] [ [ -[f|b] ] cmdfile ] [ args ]`
+ 选项:
`-c`：从命令行执行expect脚本，默认expect是交互地执行的
示例：expect -c 'expect "\n" {send "pressed enter\n"}
`-d`：可以输出输出调试信息
示例：expect -d ssh.exp
+ 命令
expect中相关命令
spawn 启动新的进程
send 用于向进程发送字符串
expect 从进程接收字符串
interact 允许用户交互
exp_continue 匹配多个字符串在执行动作后加此命令


+ 单一分支模式语法：
```bash
expect “hi” {send “You said hi\n"}
匹配到hi后，会输出“you said hi”，并换行
```
+ 多分支模式语法：
```bash
expect "hi" { send "You said hi\n" } \
"hehe" { send "Hehe yourself\n" } \
"bye" { send "Good bye\n" }
#匹配hi,hello,bye任意字符串时，执行相应输出。等同如下：
expect {
"hi" { send "You said hi\n"}
"hehe" { send "Hehe yourself\n"}
"bye" { send " Good bye\n"}
}
```

+ 示例

```bash
#!/usr/bin/expect
spawn scp /etc/fstab 192.168.8.100:/app
expect {
"yes/no" { send "yes\n";exp_continue }
"password" { send "magedu\n" }
}
expect eof

#!/usr/bin/expect
spawn ssh 192.168.8.100
expect {
"yes/no" { send "yes\n";exp_continue }
"password" { send "magedu\n" }
}
interact
#expect eof

# 变量
#!/usr/bin/expect
set ip 192.168.8.100
set user root
set password magedu
set timeout 10
spawn ssh $user@$ip
expect {
"yes/no" { send "yes\n";exp_continue }
"password" { send "$password\n" }
}
interact

# 位置参数
#!/usr/bin/expect
set ip [lindex $argv 0]
set user [lindex $argv 1]
set password [lindex $argv 2]
spawn ssh $user@$ip
expect {
"yes/no" { send "yes\n";exp_continue }
"password" { send "$password\n" }
}
interact
#./ssh3.exp 192.168.8.100 root magedu

# 执行多个命令
#!/usr/bin/expect
set ip [lindex $argv 0]
set user [lindex $argv 1]
set password [lindex $argv 2]
set timeout 10
spawn ssh $user@$ip
expect {
"yes/no" { send "yes\n";exp_continue }
"password" { send "$password\n" }
}
expect "]#" { send "useradd haha\n" }
expect "]#" { send "echo magedu |passwd --stdin haha\n" }
send "exit\n"
expect eof
#./ssh4.exp 192.168.8.100 root magedu

# shell脚本调用expect
#!/bin/bash
ip=$1
user=$2
password=$3
expect <<EOF
set timeout 20
spawn ssh $user@$ip
expect {
"yes/no" { send "yes\n";exp_continue }
"password" { send "$password\n" }
}
expect "]#" { send "useradd hehe\n" }
expect "]#" { send "echo magedu |passwd --stdin hehe\n" }
expect "]#" { send "exit\n" }
expect eof
EOF
#./ssh5.sh 192.168.8.100 root magedu
```




# 练习:
==用for实现==
1. 判断/var/目录下所有文件的类型
2. 添加10个用户user1-user10，密码为8位随机字符
3. /etc/rc.d/rc3.d目录下分别有多个以K开头和以S开头的文件；分别读取每个文件，以K开头的输出为文件加stop，以S开头的输出为文件名加start，如K34filename stop S66filename start
4. 编写脚本，提示输入正整数n的值，计算1+2+…+n的总和
5. 计算100以内所有能被3整除的整数之和
6. 编写脚本，提示请输入网络地址，如192.168.0.0，判断输入的网段中主机在线状态
7. 打印九九乘法表
8. 在/testdir目录下创建10个html文件,文件名格式为数字N（从1到10）加随机8个字母，如：1AbCdeFgH.html
9. 打印等腰三角形
10. 猴子第一天摘下若干个桃子，当即吃了一半，还不瘾，又多吃了一个第二天早上又将剩下的桃子吃掉一半，又多吃了一个。以后每天早上都吃了前一天剩下的一半零一个。到第10天早上想再吃时，只剩下一个桃子了。求第一天共摘了多少？
==用while实现==
11. 编写脚本，求100以内所有正奇数之和
12. 编写脚本，提示请输入网络地址，如192.168.0.0，判断输入的网段中主机在线状态，并统计在线和离线主机各多少
13. 编写脚本，利用变量RANDOM生成10个随机数字，输出这个10数字，并显示其中的最大值和最小值
14. 编写脚本，实现打印国际象棋棋盘
15. 后续六个字符串：efbaf275cd. 4be9c40b8b. 44b2395c46. f8c8873ce0. b902c16c8b. ad865d2f63是通过对随机数变量RANDOM随机执行命令： echo $RANDOM|md5sum|cut –c1-10 后的结果，请破解这些字符串对应的RANDOM值
16. 每隔3秒钟到系统上获取已经登录的用户的信息；如果发现用户hacker登录，则将登录时间和主机记录于日志/var/log/login.log中,并退出脚本
17. 随机生成10以内的数字，实现猜字游戏，提示比较大或小，相等则退出
18. 用文件名做为参数，统计所有参数文件的总行数
19. 用二个以上的数字为参数，显示其中的最大值和最小值
==用while read line实现==
20. 扫描/etc/passwd文件每一行，如发现GECOS字段为空，则将用户名和单位电话为62985600填充至GECOS字段，并提示该用户的GECOS信息修改成功
==函数练习==
21. 编写函数，实现OS的版本判断
22. 编写函数，实现取出当前系统eth0的IP地址
23. 编写函数，实现打印绿色OK和红色FAILED
24. 编写函数，实现判断是否无位置参数，如无参数，提示错误
25. 编写服务脚本/root/bin/testsrv.sh，完成如下要求
(1) 脚本可接受参数：start, stop, restart, status
(2) 如果参数非此四者之一，提示使用格式后报错退出
(3) 如是start:则创建/var/lock/subsys/SCRIPT_NAME, 并显示“启动成功”
考虑：如果事先已经启动过一次，该如何处理？
(4) 如是stop:则删除/var/lock/subsys/SCRIPT_NAME, 并显示“停止完成”
考虑：如果事先已然停止过了，该如何处理？
(5) 如是restart，则先stop, 再start
考虑：如果本来没有start，如何处理？
(6) 如是status, 则如果/var/lock/subsys/SCRIPT_NAME文件存在，则显示“SCRIPT_NAME is running...”，如果/var/lock/subsys/SCRIPT_NAME文件不存在，则显示“SCRIPT_NAME is stopped...”
(7)在所有模式下禁止启动该服务，可用chkconfig 和 service命令管理
说明：SCRIPT_NAME为当前脚本名
26. 编写脚本/root/bin/copycmd.sh
(1) 提示用户输入一个可执行命令名称
(2) 获取此命令所依赖到的所有库文件列表
(3) 复制命令至某目标目录(例如/mnt/sysroot)下的对应路径下
如：/bin/bash ==> /mnt/sysroot/bin/bash
/usr/bin/passwd ==> /mnt/sysroot/usr/bin/passwd
(4) 复制此命令依赖到的所有库文件至目标目录下的对应路径下： 如：/lib64/ld-linux-x86-64.so.2 ==> /mnt/sysroot/lib64/ld-linux-x86-64.so.2
(5)每次复制完成一个命令后，不要退出，而是提示用户键入新的要复制的命令，并重复完成上述功能；直到用户输入quit退出
27. 编写函数实现两个数字做为参数，返回最大值
28. 斐波那契数列又称黄金分割数列，因数学家列昂纳多·斐波那契以兔子繁殖为例子而引入，故又称为“兔子数列”，指的是这样一个数列：0、1、1、2、3、5、8、13、21、34、……，斐波纳契数列以如下被以递归的方法定义：F（0）=0，F（1）=1，F（n）=F(n-1)+F(n-2)（n≥2）
利用函数，求n阶斐波那契数列
29. 汉诺塔（又称河内塔）问题是源于印度一个古老传说。大梵天创造世界的时候做了三根金刚石柱子，在一根柱子上从下往上按照大小顺序摞着64片黄金圆盘。大梵天命令婆罗门把圆盘从下面开始按大小顺序重新摆放在另一根柱子上。并且规定，在小圆盘上不能放大圆盘，在三根柱子之间一次只能移动一个圆盘，利用函数，实现N片盘的汉诺塔的移动步骤
30. 输入若干个数值存入数组中，采用冒泡算法进行升序或降序排序
31. 将下图所示，实现转置矩阵matrix.sh
```bash
1 2 3      1 4 7
4 5 6 ===> 2 5 8
7 8 9      3 6 9
```
32. 打印杨辉三角形
