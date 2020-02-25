@[TOC](本意内容)

# printf
`printf '格式' 内容`

+ 参数

参数| 注释
-|-
`\a` | 警告声
`\b` | 退格
`\f` | 清屏
`\n` | 输出新的一行
`\r` | Enter键
`\t` | Tab键

+ 格式

格式 | 注释
-| -
`%ns` | n位字符
`%ni/%nd` | n位数字
`%N.nf` | N位数，2位小数
`%c` | 字符的ASCII码
`%e/%E`|科学计数法
`%g/%G` | 以科学计数法或浮点形式显示数值
`%u` | 无符号整数
`%%` | %
`-` | 左对齐(%-10s)
`+` | 显示数值的正负号(%+2d)


# awk
`awk [OPTION] 'BEGIN{ACTION...}PATTERN{ACTION...}END{ACTION...}' filename` 

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190619213306914.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)
+ 参数

[OPTION] | 意义
-|-
`-F "CHAR"` | 指定分隔符
`-f file.awk`| 指定awk脚本
`-v var=value` | 变量赋值

+ 内定变量名

内定变量名| 意义
-|-
`$0` | 所有字段（所有域）
`$1` | 第一个字段（域）
`NF` | 每一行的字段数
`NR` | 当前处理的行数
`FS` | 输入分隔字符
`OFS` | 输出分隔符
`RS` | 指定输入的符号变成一行记录
`ORS` | 输出的换行符变成指定符号
`FNR` | 各文件分别计行号
`FILENAME` | 当前文件名
`ARGC` | 命令参数的个数
`ARGV` | 数组，保存命令的各个参数(awk为第一个)

+ 算术表达式：

算术|意义
-|-
`x+y` | 加
`x-y` | 减
`x*y` | 乘 
`x/y` | 除
`x^y` | 幂
`x%y` | 取模
`-x` | 把x转换成负数
`+x` | 把x从字符串转换成数值

+ 赋值：

赋值|意义
-|-
`=` | 
`+/-/*///%/^ =` | 自加、减、乘、除、取模、幂
`++ / --` | 自加1/自减1 

+ 比较运算符：

比较|意义
-|-
`>` | 大于
`<` | 小于
`==` | 等于 
`！=` | 不等于
**模式匹配**||
`~` | 是否匹配
`!~` | 是否不匹配

+ 逻辑运算符：

逻辑|意义 
-|-
`&&` | 与
`||` | 或
`！` | 非
`EXPRESSION?TRUE:FALSE` | 三目表达式

+ 行匹配：

行匹配| 意义 
-|-
`/PATTERN/` | 匹配PATTERN的这一行
`/PATTERN1/,/PATTERN2/` | 匹配PATTERN范围
`BEGIN{}` | 仅在开始处理文件中的文本之前执行一次
`END{}` | 仅在文本处理完成之后执行一次

+ awk示例

```bash
#print 打印
[root@localhost ~]$last -n 5 | awk '{print $1 "\t" $3}'
root    192.168.88.2
root    192.168.88.2
root    192.168.88.2
root    192.168.88.2
root    192.168.88.2

#NR、NF
[root@localhost ~]$last -n 5 | awk '{print NR $1 "\t" NF}'
1root   10
2root   10
3root   10
4root   10
5root   10
6       0
7wtmp   7

#ARGV内定变量
[root.CentOS 7] ➤ awk '{print ARGV[2]}' f1 f1.sh f2  | head -1
f1.sh
...

#FS和逻辑运算符
[root@localhost ~]$cat /etc/passwd | awk -v FS=':' '$3 < 10 {print $1 "\t" $3}'
root:x:0:0:root:/root:/bin/bash
bin     1
daemon  2
adm     3
lp      4
sync    5
shutdown        6
halt    7
mail    8

#多命令时，需要用“;”分隔或者换行
#也可以用if(NR==1)
[root@localhost ~]$cat printf.txt | \
> awk 'NR==1{printf "%10s %10s %10s %10s %10s\n",$1,$2,$3,$4,"Total" }
> NR>=2{total = $2 + $3 + $4
> printf "%10s %10d %10d %10d %10.2f\n",$1,$2,$3,$4,total}'
      name        1st        2nd        3th      Total
       tom        234        124     124124  124482.00
      leoi         23       2133        321    2477.00
      chan      12312      21323       2121   35756.00

#-v变量赋值
[root.CentOS 7] ➤ awk -v test="hello" 'BEGIN{print test}' f1
hello
[root.CentOS 7] ➤ awk 'BEGIN{test="hello";print test}' f1
hello

#printf
[root.CentOS 7] ➤ awk -v FS=":" '{printf "Username:%-10s\tUID:%5d\n",$1,$3}' /etc/passwd
Username:root           UID:    0
Username:bin            UID:    1
Username:daemon         UID:    2
Username:adm            UID:    3

#模式匹配
[root.CentOS 7] ➤ awk -F : '$4==100{print}' /etc/passwd
games:x:12:100:games:/usr/games:/sbin/nologin

[root.CentOS 7] ➤ awk -F: '$0~"^root"{print $1}' /etc/passwd
root

#逻辑操作符
[root.CentOS 7] ➤ awk -F: '$3>=0&&$3<=100{print $1}' /etc/passwd
root
bin
daemon
adm

lp[root.CentOS 7] ➤ awk -F : '!($3>=10){print $1}' /etc/passwd
root
bin
daemon

[root.CentOS 7] ➤ awk -F: '$3<1000?usertype="SYSTEM":usertype="USER"{print $1"\t"usertype}' /etc/passwd
root    SYSTEM
bin     SYSTEM
daemon  SYSTEM
adm     SYSTEM
chen    USER

#$NF表示最后一个变量
[root.CentOS 7] ➤ awk -F: '$NF ~ /bash$/{print $1,$NF}' /etc/passwd
root /bin/bash
chen /bin/bash

#PATTERN匹配范围
[root.CentOS 7] ➤ awk -F: '/^root\>/,/^nobody\>/{print $1}' /etc/passwd
root
bin
daemon
adm
lp
sync
shutdown
halt
mail
operator
games
ftp
nobody

#BEGIN和END
[root.CentOS 7] ➤ awk -F: 'BEGIN{print "USER"}{print $1 ":" $3}END{print "END"}' /etc/passwd
USER
root:0
bin:1
daemon:2
adm:3
...
END

[root.CentOS 7] ➤ seq 10 | awk 'i=!i'
1
3
5
7
9
```

## awk控制语句
### if-else
```bash
awk '{if(i==1){print $1}else{}print $2}' f1.txt
```
### while
```bash
awk '{while(i<=NR){print $0}}' f1.txt
```
### do-while
```bash
[2019-06-09 11:36.37] ~
[root.CentOS 7] ➤  seq 10 | awk -v i=0 'BEGIN{do{print i;i++;}while(i<5)}'
0
1
2
3
4
```
### for
```bash
#常用
awk 'BEGIN{for(i=1;i<j;i++){print $0}}' 

#遍历数组
awk 'BEGIN{for(var in array){print var,length(var)}}
```
### switch
```bash
awk 'BEGIN{switch(){case VAR or /REGEXP/:statement;default:statement2}}'
```

### break和continue
break:表示跳出循环
continue:表示结束本次循环 

### next
next:表示结束awk的本次循环

## awk数组
+ 数组：array[index]
index可以是数字也可以是字符串
+ 去重功能
```bash
> cat a.txt
a
b
aa
bb
bb
cc
aa
dd
a
> awk '!a[$0]++` a.txt
a
b
aa
bb
cc
dd
```
+ 使用for(var in array){for-body}

## awk函数
+ rand()：返回一个随机数（0~1间）(srand()随机数种子)
+ length()：返回字符串的长度
+ (g)sub(/r/,s,[t])：对t搜索r模式匹配的内容，替换成s。(g)替换所有
+ int(x)：将x转换成整数
+ split(s,array,[r])：以r为分隔符，切割字符串s，保存到数组array(索引从1开始)
+ system("COMMAND")：调用系统命令
+ 自定义函数格式：
```bash
function fun_name(parameter...){
      statements
      return expression
}

#示例：
>cat fun.awk
function max(x,y){
      x>y?var=x:vary=y
      return var
}
```

## awk脚本
1. 调用awk脚本
```bash
>cat f2.awk
{if($3>=100)print $1,$3}

>awk -F: -f f2.awk /etc/passwd
```
2. d调用awk脚本2
```bash
>cat f4.awk
#!/bin/awk -f
{if($3>=1000)print $1,$3}
>chmod +x f4.awk
>./f2.awk -F: /etc/passwd
```
3. 向awk脚本传递参数
```bash
#-v可以让awk在BEGIN拿到参数，不加则会在首行加载后可以使用 
awkfile var=value -v var2=value2 Inputfile
```



# 练习
1. 文件ip_list.txt如下格式，请提取”.magedu.com”前面的主机名部分并写入到回到该文件中
1 blog.magedu.com
2 www.magedu.com
…
999 study.magedu.com
2. 统计/etc/fstab文件中每个文件系统类型出现的次数
3. 统计/etc/fstab文件中每个单词出现的次数
4. 提取出字符串Yd$C@M05MB%9&Bdh7dq+YVixp3vpw中的所有数字
5. 有一文件记录了1-100000之间随机的整数共5000个，存储的格式100,50,35,89…请取出其中最大和最小的整数
6. 解决DOS攻击生产案例：根据web日志或者或者网络连接数，监控当某个IP并发连接数或者短时内PV达到100，即调用防火墙命令封掉对应的IP，监控频率每隔5分钟。防火墙命令为：iptables -A INPUT -s IP -j REJECT
7. 将以下文件内容中FQDN取出并根据其进行计数从高到低排序
http://mail.magedu.com/index.html
http://www.magedu.com/test.html
http://study.magedu.com/index.html
http://blog.magedu.com/index.html
http://www.magedu.com/images/logo.jpg
http://blog.magedu.com/20080102.html
8. 将以下文本以inode为标记，对inode相同的counts进行累加，并且统计出同一inode中，beginnumber的最小值和endnumber的最大值
inode|beginnumber|endnumber|counts|
106|3363120000|3363129999|10000|
106|3368560000|3368579999|20000|
310|3337000000|3337000100|101|
310|3342950000|3342959999|10000|
310|3362120960|3362120961|2|
311|3313460102|3313469999|9898|
311|3313470000|3313499999|30000|
311|3362120962|3362120963|2|
输出的结果格式为：
310|3337000000|3362120961|10103|
311|3313460102|3362120963|39900|
106|3363120000|3368579999|30000|

## 练习答案
1. 文件ip_list.txt如下格式，请提取”.magedu.com”前面的主机名部分并写入到回到该文件中
```bash
[root.CentOS 7] ➤ awk -F. '{print $1}' ip-list.txt >> ip-list.txt
```
2. 统计/etc/fstab文件中每个文件系统类型出现的次数
```bash
[root.CentOS 7] ➤ awk '/^[^#].*$/{print $3}' /etc/fstab |sort|uniq -c
      1 swap
      2 xfs
```
3. 统计/etc/fstab文件中每个单词出现的次数
```bash
[root.CentOS 7] ➤ awk 'gsub(/[^[:alpha:]]/,"\n",$0)' /etc/fstab | sort|uniq -c
```
4. 提取出字符串Yd$C@M05MB%9&Bdh7dq+YVixp3vpw中的所有数字
```bash
[root.CentOS 7] ➤ echo "Yd$C@M05MB%9&Bdh7dq+YVixp3vpw" | awk 'gsub(/[^[:digit:]]/,"",$0)'
05973
```
5. 有一文件记录了1-100000之间随机的整数共5000个，存储的格式100,50,35,89…请取出其中最大和最小的整数
```bash
awk -F, '{if($1>$2){big=$1;small=$2}\
else{big=$2;small=$1}\
for(i=3;i<=NF;i++){\
if(big<$i){big=$i}\
if(small>$i){small=$i}\
}}\
END{print "big:"big"\nsmall:"small}' RANDOM.txt
```
6. 解决DOS攻击生产案例：根据web日志或者或者网络连接数，监控当某个IP并发连接数或者短时内PV达到100，即调用防火墙命令封掉对应的IP，监控频率每隔5分钟。防火墙命令为：iptables -A INPUT -s IP -j REJECT
```bash
>crontab -e
*/5 * * * * bash dos.sh
>cat dos.sh
#!/bin/bash
ss -t | awk -F "[[:space:]]+|:" '{count[$6]++;}END{for(i in count){if(count[i]>1){system("iptables  -A INPUT -s " i " -j REJECT")}}}'

```
7. 将以下文件内容中FQDN取出并根据其进行计数从高到低排序
```bash
[root.CentOS 7] ➤ awk -F "[/|.]" '{count[$3]++}END{for(i in count){print i,count[i]}}' url.txt
www 2
mail 1
blog 2
study 1
```

8. 将以下文本以inode为标记，对inode相同的counts进行累加，并且统计出同一inode中，beginnumber的最小值和endnumber的最大值
```bash
awk -F "|" -v OFS="|" 'NR==1{print $0}\
NR>1{count[$1]+=$4;if(max[$1]<$3){max[$1]=$3}\
if(!min[$1]){min[$1]=$2}if(min[$i]>$2){min[$1]=$2}}\
END{for(i in count){print i,min[i],max[i],count[i]"|"}}' inode.txt
```
