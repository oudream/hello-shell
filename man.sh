#!/usr/bin/env bash

### init
sudo apt-get update -y ; sudo apt-get upgrade -y
## 一次性安装
sudo apt-get update -y ; sudo apt-get upgrade -y && \
sudo apt-get install apt-utils wget openssh-server telnet vim passwd ifstat unzip iftop htop telnet samba net-tools lsof rsync gcc g++ cmake build-essential gdb gdbserver unixodbc unixodbc-dev libcurl4-openssl-dev uuid uuid-dev qt5-default libqt5svg5 libqt5svg5-dev qtcreator -y && \
sudo rm -rf /var/lib/apt/lists/*

## 创建目录
sudo mkdir /opt/ddd; sudo mkdir /opt/eee; sudo mkdir /opt/fff; sudo chown oudream /opt/ddd; sudo chown oudream /opt/eee; sudo chown oudream /opt/fff
sudo mkdir /ddd; sudo mkdir /eee; sudo mkdir /fff; sudo chown oudream /ddd; sudo chown oudream /eee; sudo chown oudream /fff

scp /fff


### etc 环境变量配置文件加载优先级，三个阶段：系统运行、用户登录、软件运行
# linux
/etc/environment    /etc/profile    ~/.bash_profile    ~/.bashrc    /etc/bashrc
/etc/bashrc_Apple_Terminal
# /etc/profile全局环境变量文件，用户登录系统后首先会加载，系统上默认的shell主环境变量。每个用户登录后都会加载。
# /etc/profile.d目录下的脚本文件在加载完/etc/profile文件后才会执行，这个目录下脚本有很多。
# ~/.bash_profile：每个用户都可使用该文件设置专用于自己的shell信息，当用户登录时，该文件仅执行一次。默认情况下，他设置一些环境变量，执行用户的.bashrc文件。
# ~/.bashrc：该文件包含专用于自己的shell信息，当登录时以及每次打开新shell时，该文件被读取。
# /etc/bashrc：为每一个运行bash shell的用户执行此文件，当bash shell被打开时，该文件被读取
# 区别：.bash_profile是在你每次登录的时候执行的；.bashrc是在你新开了一个命令行窗口时执行的。
# 不想维护两个独立的配置文件，可以在.bash_profile中调用.bashrc
# if [ -f ~/.bashrc ]; then . ~/.bashrc fi



# macos
/etc/profile    /etc/paths    ~/.bash_profile    ~/.bash_login    ~/.profile    ~/.bashrc
# 当然/etc/profile和/etc/paths是系统级别的，系统启动就会加载，后面几个是当前用户级的环境变量。
# 后面3个按照从前往后的顺序读取，如果~/.bash_profile文件存在，则后面的几个文件就会被忽略不读了，
# 如果~/.bash_profile文件不存在，才会以此类推读取后面的文件。~/.bashrc没有上述规则，它是bash shell打开的
# 时候载入的。值得一提的是这几个文件中，/etc/paths文件里面不用export那种方式添加环境变量，直接它的文件内容
# 里面的每一行的路径就会被添加到环境变量中。
~/Library/Mobile\ Documents/com~apple~CloudDocs/ # iCloud path


### 环境变量
BASH # Bash Shell的全路径
CDPATH # 用于快速进入某个目录。
PATH # 决定了shell将到哪些目录中寻找命令或程序
HOME # 当前用户主目录
HISTSIZE # 历史记录数
LOGNAME # 当前用户的登录名
HOSTNAME # 指主机的名称
SHELL # 当前用户Shell类型
LANGUGE # 语言相关的环境变量，多语言可以修改此环境变量
MAIL # 当前用户的邮件存放目录
PS1 # 基本提示符，对于root用户是#，对于普通用户是$

# 命令
echo         # 显示某个环境变量值 echo $PATH
export       # 设置一个新的环境变量 export HELLO="hello" (可以无引号)
env          # 显示所有环境变量
set          # 显示本地定义的shell变量
unset        # 清除环境变量 unset HELLO
readonly     # 设置只读环境变量 readonly HELLO

# C程序调用环境变量函数
getenv() # 返回一个环境变量。
setenv() # 设置一个环境变量。
unsetenv() # 清除一个环境变量。


# 列出Bash Shell内置命令
compgen -b
# Bash Shell内置命令，列出全部可执行命令
compgen -c




### node.js
node xxx.js
node percent.js m75.07796,155c0,-42.49836 34.42367,-76.92204 76.92204,-76.92204c42.49836,0 76.92204,34.42367 76.92204,76.92204c0,42.49836 -34.42367,76.92204 -76.92204,76.92204c-42.49836,0 -76.92204,-34.42367 -76.92204,-76.92204z



### python
jupyter notebook --no-browser --port 8901 --ip=10.35.191.17

### jupyter password
from notebook.auth import passwd
passwd()
Enter password: 1
Verify password: 1
'sha1:8493e810f097:cffe7bf193dfd17ee26182cfbba826e29c2df795'

jupyter nbconvert --to python --output-dir /ddd/ai/fastai/courses-py/deeplearningning1/nbs/ *.ipynb

python -m http.server 8893 # python3
python -m SimpleHTTPServer 8893 # python2



### install ubuntu
# 合上盖子想不休眠，需要进行以下修改：
sudo sed -i 's/#HandleLidSwitch=suspend/HandleLidSwitch=ignore/g' /etc/systemd/logind.conf
# 修改完成后重启系统服务：
systemctl restart systemd-logind
# 该方法除了适用于Ubuntu 18.04外，还适用于Ubuntu 16.04版本，其它的版本没有测试，应该问题不大。



# ln
ln -s /ddd/dir1 link-dir1 # create link link-dir1



### grep more less sort wc
grep -E 'pattern1.*pattern2' filename
ls -lR | grep '^./\|.ipynb$'



### clipboard
ll | xsel
cat /fff/tmp/000.txt | ssh -X 10.35.191.11 "DISPLAY=:0.0 pbcopy -i"



### expr 注意 $a 后的空格，注意 \< 要有转义符
###  {+, -} {*, /, %} {=, >, >=, <, <=, !=} expr2
f=`expr $a \< $b`
var4=$[$var1 * ($var2 - $var3)] # []
var1=$(echo "scale=4; 3.44 / 5" | bc) # bc



# alias
alias ll='ls -lt' # 设置别名
alias -p # 查看已经设置的别名列表
unalias ll # 删除别名
alias ls='ls -la' # 如果别名已经指定过，
# 要使以上别名失效并强制执行原始的 ls 命令，可使用以下语法：(忽略别名)
'ls' # 或 \ls
# 常用的别名：
alias ls='ls --color=auto' # 输出显示为彩色
alias la='ls -Fa'          # 列出所有文件
alias ll='ls -Fls'         # 列出文件详细信息
alias rm='rm -i'           # 删除前需确认
alias cp='cp -i'           # 覆盖前需确认
alias mv='mv -i'           # 覆盖前需确认
alias vi='vim'             # 输入 vi 命令时使用 vim 编辑器


### 资源
free -m # 查看内存使用量和交换区使用量
uptime # 查看系统运行时间、用户数、负载
df -h # 查看各分区使用情况
du -sh <目录名> # 查看指定目录的大小
du -h -d 1
df -hl
grep MemTotal /proc/meminfo # 查看内存总量
grep MemFree /proc/meminfo # 查看空闲内存量
cat /proc/loadavg # 查看系统负载



### 系统
hostname
uname -a # 查看内核/操作系统/CPU信息
cat /etc/issue # 查看ubuntu的内核版本和发行版本号
sudo lsb_release -a # 查看ubuntu的内核版本和发行版本号，更详细
head -n 1 /etc/issue # 查看操作系统版本
cat /proc/cpuinfo # 查看CPU信息
hostname # 查看计算机名
lspci -tv # 列出所有PCI设备
lsusb -tv # 列出所有USB设备
lsmod # 列出加载的内核模块
w
env # 查看环境变量
export # 用来显示和设置环境变量
set -o # 查看当前设置情况
shopt -p # 查看当前设置情况 shopt命令是set命令的一种替代
set # 用来显示shell本地变量
typeset -F # 只列出函数名
declare -F # 只列出函数名



### 磁盘和分区
fdisk -l # 查看所有分区
swapon -s # 查看所有交换分区
hdparm -i /dev/hda # 查看磁盘参数(仅适用于IDE设备)
dmesg | grep IDE # 查看启动时IDE设备检测状况
# mount
mount | column -t # 查看挂接的分区状态
mount -t cifs -o username=Bob,password=123456 //192.168.0.102/Share /usr/local/bin/code
df -h # 查挂载在状态
mount
umount /usr/local/bin/code
sshfs -C -o reconnect oudream@10.31.58.132:/ddd /fff/r132ddd



### 文件系统
/dev/null # 外号叫无底洞，你可以向它输出任何数据，它通吃，并且不会撑着！
/dev/zero # 是一个输入设备，你可你用它来初始化文件。该设备无穷尽地提供0，可以使用任何你需要的数目——设备提供的要多的多。他可以用于向设备或文件写入字符串0。
### dd：用指定大小的块拷贝一个文件，并在拷贝的同时进行指定的转换
dd if=/dev/urandom bs=128 count=1 2>/dev/null | base64 | tr -d "=+/" | dd bs=32 count=1 2>/dev/null
# 参数及注意：指定数字的地方若以下列字符结尾，则乘以相应的数字：b=512；c=1；k=1024；w=2
# if=文件名：输入文件名，缺省为标准输入。即指定源文件。< if=input file >
# of=文件名：输出文件名，缺省为标准输出。即指定目的文件。< of=output file >
# ibs=bytes：一次读入bytes个字节，即指定一个块大小为bytes个字节。
#    obs=bytes：一次输出bytes个字节，即指定一个块大小为bytes个字节。
#    bs=bytes：同时设置读入/输出的块大小为bytes个字节。
# cbs=bytes：一次转换bytes个字节，即指定转换缓冲区大小。
# skip=blocks：从输入文件开头跳过blocks个块后再开始复制。
# seek=blocks：从输出文件开头跳过blocks个块后再开始复制。 注意：通常只用当输出文件是磁盘或磁带时才有效，即备份到磁盘或磁带时才有效。
# count=blocks：仅拷贝blocks个块，块大小等于ibs指定的字节数。
# conv=conversion：用指定的参数转换文件。
#    ascii：转换ebcdic为ascii
#    ebcdic：转换ascii为ebcdic
#    block：把每一行转换为长度为cbs，不足部分用空格填充
#    unblock：使每一行的长度都为cbs，不足部分用空格填充
#    lcase：把大写字符转换为小写字符
#    ucase：把小写字符转换为大写字符
#    swab：交换输入的每对字节
#    noerror：出错时不停止
#    notrunc：不截短输出文件
#     sync：将每个输入块填充到ibs个字节，不足部分用空（NUL）字符补齐。
## 拷贝内存内容到硬盘
dd if=/dev/mem of=/root/mem.bin bs=1024 # (指定块大小为1k)
## 备份与恢复MBR，count=1指仅拷贝一个块；bs=512指块大小为512个字节。
dd if=/dev/hda of=/root/image count=1 bs=512 # 备份磁盘开始的512个字节大小的MBR信息到指定文件：
dd if=/root/image of=/dev/had # 恢复
## 增加swap分区文件大小
dd if=/dev/zero of=/swapfile bs=1024 count=262144   # 第一步：创建一个大小为256M的文件：
mkswap /swapfile                                    # 第二步：把这个文件变成swap文件：
swapon /swapfile                                    # 第三步：启用这个swap文件：
/swapfile    swap    swap    default   0 0          # 第四步：编辑/etc/fstab文件，使在每次开机时自动加载swap文件：



### 网络
lsof -p pid # 查看打开的资源
lsof -p 6317 | wc -l
sudo netstat -anp | grep 3306
sudo lsof -i -P | grep -i "listen"
ifconfig # 查看所有网络接口的属性
iptables -L # 查看防火墙设置
sudo ufw status #（查防火墙状态）
route -n # 查看路由表
netstat -lntp # 查看所有监听端口
netstat -antp # 查看所有已经建立的连接
netstat -s # 查看网络统计信息
ss -ltn # -l, --listening 显示监听状态的套接字 --tcp 仅显示 TCP套接字（sockets） -n --numeric 不解析服务名称
ss -t -a # 显示TCP连接
ss -pl # 查看进程使用的socket
curl ifconfig.me/all
curl ifconfig.me/host
curl ifconfig.me/ua
curl v4.ifconfig.co # returns my ip address near instantly from the command line regardless of where I call it from
ufw disable # 关闭ubuntu的防火墙
apt-get remove iptables # 卸载了iptables



### 运行程序 bash
./rsync.sh &
# 但是如上方到后台执行的进程，其父进程还是当前终端shell的进程，而一旦父进程退出，则会发送hangup信号给所有子进程，
#    子进程收到hangup以后也会退出。如果我们要在退出shell的时候继续运行进程，则需要使用nohup忽略hangup信号，或者setsid将
#    将父进程设为init进程(进程号为1)
nohup ./rsync.sh &
setsid ./rsync.sh &
# 用 screen tmux 运行进程
## 重定向
${command} > file	# 将输出重定向到 file。
${command} < file	# 将输入重定向到 file。
${command} >> file	# 将输出以追加的方式重定向到 file。
n > file	# 将文件描述符为 n 的文件重定向到 file。
n >> file	# 将文件描述符为 n 的文件以追加的方式重定向到 file。
n >& m	# 将输出文件 m 和 n 合并。
n <& m	# 将输入文件 m 和 n 合并。
#   << tag	# 将开始标记 tag 和结束标记 tag 之间的内容作为输入。


### tmux
tmux # 新建一个无名称的会话
tmux new -s demo # 新建一个名称为demo的会话
tmux detach # 断开当前会话，会话在后台运行
tmux a # 默认进入第一个会话
tmux a -t demo # 进入到名称为demo的会话
tmux kill-session -t demo # 关闭demo会话
tmux kill-server # 关闭服务器，所有的会话都将关闭
tmux ls # 查看所有会话
## 在每个tmux session 下，所有命令都以 ctrl+d(C-d) 开始。
# C-b  ?	显示快捷键帮助文档
# C-b  d	断开当前会话
# C-b  D	选择要断开的会话
# C-b  Ctrl+z	挂起当前会话
# C-b  r	强制重载当前会话
# C-b  s	显示会话列表用于选择并切换
# C-b  :	进入命令行模式，此时可直接输入ls等命令
# C-b  c	新建窗口
# C-b  &	关闭当前窗口（关闭前需输入y or n确认）
# C-b  0~9	切换到指定窗口
# C-b  p	切换到上一窗口
# C-b  n	切换到下一窗口
# C-b  w	打开窗口列表，用于且切换窗口
# C-b  ,	重命名当前窗口
# C-b  .	修改当前窗口编号（适用于窗口重新排序）
# C-b  f	快速定位到窗口（输入关键字匹配窗口名称）

# 鼠标设置
touch ~/.tmux.conf
set -g mouse off
tmux rename-session [-t current-name] [new-name]

### screen
screen -S yourname -> 新建一个叫yourname的session
screen -ls -> 列出当前所有的session
screen -r yourname -> 回到yourname这个session
screen -d yourname -> 远程detach某个session
screen -d -r yourname -> 结束当前session并回到yourname这个session
screen -X -S SCREENID kill # Kill Attached Screen in Linux
screen -S SCREENNAME -p 0 -X quit
# 在每个screen session 下，所有命令都以 ctrl+a(C-a) 开始。
# C-a  ? -> 显示所有键绑定信息
# C-a  d -> detach，暂时离开当前session，将目前的 screen session (可能含有多个 windows) 丢到后台执行，并会回到还没进 screen 时的状态，此时在 screen session 里，每个 window 内运行的 process (无论是前台/后台)都在继续执行，即使 logout 也不影响。
# C-a  z -> 把当前session放到后台执行，用 shell 的 fg 命令则可回去。
# C-a  c -> 创建一个新的运行shell的窗口并切换到该窗口
# C-a  n -> Next，切换到下一个 window
# C-a  p -> Previous，切换到前一个 window
# C-a  0..9 -> 切换到第 0..9 个 window
# C-a  [Space] -> 由视窗0循序切换到视窗9
# C-a  C-a -> 在两个最近使用的 window 间切换
# C-a  x -> 锁住当前的 window，需用用户密码解锁
# C-a  w -> 显示所有窗口列表


### lsof
lsof [参数][文件]
# -a  列出打开文件存在的进程
# -c <进程名> 列出指定进程所打开的文件
# -g   列出GID号进程详情
# -d <文件号> 列出占用该文件号的进程
# +d <目录>  列出目录下被打开的文件
# +D <目录>  递归列出目录下被打开的文件
# -n <目录>  列出使用NFS的文件
# -i <条件>  列出符合条件的进程。（4、6、协议、:端口、 @ip ）
# -p <进程号> 列出指定进程号所打开的文件
# -u   列出UID号进程详情
# -h  显示帮助信息
# -v  显示版本信息
lsof /bin/bash # 查看谁正在使用某个文件，也就是说查找某个文件相关的进程
lsof -u username # 列出某个用户打开的文件信息
lsof -u ^root # 列出除了某个用户外的被打开的文件信息
lsof -c mysql # 列出某个程序进程所打开的文件信息
lsof -i udp:55 # 列出谁在使用某个特定的udp端口


### 进程 -A 显示所有进程；-e 等于“-A”; e 显示环境变量；f 显示程序间的关系；-H 显示树状结构；u 指定用户的所有进程
ps -ef # 查看所有进程
ps -efw | grep nginx | xsel  # 显示所有命令，连带命令行
ps -u root # 显示root进程用户信息
ps -A # 显示进程信息
pgrep nginx | xargs ps # 查找进程
ps axuw | head -1; ps axuw | grep nc # 带标题
ps -e | wc -l
ps e -eH # 树状带环境变量
pstree -p <进程号> # 进程树型
# 当前 shell
echo $SHELL
ps -p $$
echo $$
top # 实时显示进程状态
ps -ef f # 查看线程，其实linux没有线程，都是用进程模仿的
# macos
sudo /usr/libexec/stackshot -i -u -p <pid>
echo "thread backtrace all" | lldb -p <pid>
# linux
pstack 7013
# 通过pid查看占用端口
netstat -nap | grep 进程pid
# 例：通过nginx进程查看对应的端口号
ps -ef | grep nginx
netstat -nap | grep nginx-pid
# 例：查看8081号端口对应的进程名
netstat -nap | grep 8081



### pmap 命令用于报告进程的内存映射关系，是Linux调试及运维一个很好的工具
pmap <选项> (参数) pid
# -x 显示扩展格式；
# -d 显示设备格式；
# -q 不显示头尾行；
# -V 显示指定版本。
pmap 1315



### ulimit (选项), core文件
# -a 显示目前资源限制的设定；
# -c <core 文件上限 & gt;：设定 core 文件的最大值，单位为区块；
# -d < 数据节区大小 & gt;：程序数据节区的最大值，单位为 KB；
# -f < 文件大小 & gt;：shell 所能建立的最大文件，单位为区块；
# -H 设定资源的硬性限制，也就是管理员所设下的限制；
# -m < 内存大小 & gt;：指定可使用内存的上限，单位为 KB；
# -n < 文件数目 & gt;：指定同一时间最多可开启的文件数；
# -p < 缓冲区大小 & gt;：指定管道缓冲区的大小，单位 512 字节；
# -s < 堆叠大小 & gt;：指定堆叠的上限，单位为 KB；
# -S 设定资源的弹性限制；
# -t <CPU 时间 & gt;：指定 CPU 使用时间的上限，单位为秒；
# -u < 程序数目 & gt;：用户最多可开启的程序数目；
# -v < 虚拟内存大小 & gt;：指定可使用的虚拟内存上限，单位为 KB。
ulimit -a
ulimit -c unlimited # core文件的大小不受限制
ulimit -c 0 # 阻止系统生成core文件
#a) ulimit命令设置后只对一个终端有效，所以另起终端后需要重新设置。
#b) 要在整个系统中生效，可以通过如下方法(当然此方法未必管用和linux版本相关)：
#b.1) 编辑/root/.bash_profile文件，在其中加入：ulimit -S -c unlimited (需要注意的是:不是每个版本的系统都有这个文件(Suse下面就没有)，可以手工创建)
#b.2) 重启系统或者执行:soruce /root/.bash_profile



### ufw apparmor selinux
# apparmor
sudo apparmor_status # 查询当前Apparmor的状态
sudo aa-status # List the current status of apparmor
sudo systemctl stop apparmor
sudo systemctl disable apparmor
# 更改profile文件的状态
sudo enforce <application_name> # 把某个profile置为enforce状态
sudo complain <application_name> # 把某个profile置为complain状态
# 在修改了某个profile的状态后，执行如下命令使之生效：
sudo /etc/init.d/apparmor restart



### macos
dscl . -list /Users
dscl . -list /Groups
dscacheutil -q group
sudo spctl --master-disable



### network
### MAC ADDRESS
第一个是自己的
sudo ifconfig en0 ether a0:99:9b:0f:53:15 ### mac2015
sudo ifconfig en0 ether F0:DE:F1:B4:2A:82 ### oudream thinkpade520
sudo ifconfig en0 ether C0:3F:D5:74:79:4F ### oudream pc
sudo ifconfig en0 ether 28:D2:44:7E:99:E4 ### llb thinkpadt440
sudo ifconfig en0 ether 5C:51:4F:62:C8:6B ### llb thinkpadt440 - wifi
sudo ifconfig en0 ether C0-3F-D5-74-74-71 ### common pc 215


### script / asciinema rec / asciinema auth
script
asciinema <command> -h
asciinema rec demo.json
asciinema rec -t "My git tutorial" # Record terminal and upload it to asciinema.org, specifying title:
asciinema play demo.json
asciinema play https://asciinema.org/a/difqlgx86ym6emrmd8u62yqu8
asciicast2gif -t solarized-dark -s 2 -S 1 118274.json demo.gif
-t：自定义名称，如 asciinema rec -t "run first blade app"
-w：暂停时间最多多少秒，如 asciinema rec -w 2.5 demo.json，录制终端保存到本地，暂停时间最多2.5秒



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


Z.a-135246-a.Z
# export
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8



# host
# hosts所在文件夹：
# Windows 系统hosts位于 C:\Windows\System32\drivers\etc\hosts
# Android（安卓）系统hosts位于 /etc/hosts
# macos（苹果电脑）系统hosts位于 /etc/hosts
# iPhone（iOS）系统hosts位于 /etc/hosts
# Linux系统hosts位于 /etc/hosts
# 绝大多数Unix系统都是在 /etc/hosts

# 修改hosts后生效方法：
# Windows
# 开始 -> 运行 -> 输入cmd -> 在CMD窗口输入
ipconfig /flushdns

# Linux
# 终端输入
sudo rcnscd restart
# 对于systemd发行版，请使用命令
sudo systemctl restart NetworkManager

# macos X终端输入
sudo killall -HUP mDNSResponder
# Android

# 开启飞行模式 -> 关闭飞行模式
# 通用方法
# 拔网线(断网) -> 插网线(重新连接网络)
# 如不行请清空浏览器缓存（老D建议不要使用国产浏览器，请使用谷歌Chrome浏览器）



### shutdown
sudo shutdown -h +60 # macos
sudo shutdown -P +60 # linux
sudo shutdown -P 1:00 # linux


### cmake

cmake . --build "/opt/ddd/ccpp/ccxx/build/cmake" -B"/opt/ddd/ccpp/ccxx/build/cmake-gcc"
cmake . -DCMAKE_BUILD_TYPE=Debug --build "/opt/ddd/ccpp/gcl3/build/cmake" -B"/opt/ddd/ccpp/gcl3/build/cmake-gcc"
cmake . -DCMAKE_BUILD_TYPE=Debug --build . -B"./cmake-gcc"
