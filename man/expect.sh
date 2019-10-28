#!/usr/bin/env bash


### expect 自动输入密码
## 1, 重定向：用重定向方法实现交互的前提是指令需要有参数来指定密码输入方式，如ftp就有-i参数来指定使用标准输入来输入密码
#    shell用重定向作为标准输入的用法是：cmd<<delimiter ,shell 会将分界符delimiter之后直到下一个同样的分界符之前的内容作为输入
# 实现ftp自动登录并运行ls指令的用法如下：其中zjk为用户名，zjk123为密码
ftp -i -n 192.168.21.46 <<EOF
user zjk zjk123
ls
EOF
## 2, 管道：跟重定向一样，指令同样要有参数来指定密码输入方式，如sudo的-S参数，passwd的-stdin参数
#    所以实现sudo自动输入密码的脚本如下：其中zjk123为密码
echo 'zjk123' | sudo -S cp file1 /etc/hosts
#    实现自动修改密码的脚本写法如下：
echo 'password' | passwd -stdin userName
## 3, expect就是用来做交互用的，基本任何交互登录的场合都能使用，但是需要安装expect包
# send：用于向进程发送字符串
# expect：从进程接收字符串
# spawn：启动新的进程
# interact：允许用户交互
# 例子1：
#!/usr/bin/expect
set user root
set ipaddress 45.77.131.42
set passwd "Z-j8\$S5-E\}\[97\?1"
set timeout 30
spawn ssh $user@$ipaddress
expect {
    "*password:" { send "$passwd\r" }
    "yes/no" { send "yes\r";exp_continue }
}
interact
# 例子2：
#!/usr/bin/expect
set timeout 5
spawn sudo ls -l
expect "Password:"
send "oudream\r"
interact
