#!/usr/bin/env bash

### etc 环境变量配置文件加载优先级，三个阶段：系统运行、用户登录、软件运行
# linux
/etc/environment    /etc/profile    ~/.bash_profile    ~/.bashrc    /etc/bashrc
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



### git
git submodule add https://github.com/chaconinc/DbConnector
git clone --recursive https://github.com/chaconinc/MainProject
git submodule update --remote DbConnector
git submodule update --remote



### svn
# svn checkout path # 1、将文件checkout到本地目录（path是服务器上的目录） 简写：svn co
svn checkout svn://192.168.1.1/pro/domain /ddd/localpath
# svn add file # 2、往版本库中添加新的文件
svn add test.php # (添加test.php)
svn add *.php # (添加当前目录下所有的php文件)
# svn commit -m "LogMessage" [-N] [--no-unlock] PATH # 3、将改动的文件提交到版本库 (如果选择了保持锁，就使用--no-unlock开关) 简写：svn ci
svn commit -m "add test file for my test" test.php
# svn lock -m "LockMessage" [--force] PATH # 4、加锁/解锁
svn lock -m "lock test file" test.php
svn unlock PATH
# svn update -r m path # 5、更新到某个版本 简写：svn up
svn update # 如果后面没有目录，默认将当前目录以及子目录下的所有文件都更新到最新版本。
svn update -r 200 test.php # (将版本库中的文件test.php还原到版本200)
svn update test.php # (更新，于版本库同步。如果在提交的时候提示过期的话，是因为冲突，需要先update，修改文件，然后清除svn resolved，最后再提交commit)
# 1）svn status path # 6、查看文件或者目录状态（目录下的文件和子目录的状态，正常状态不显示）【?：不在svn的控制中；M：内容被修改；C：发生冲突；A：预定加入到版本库；K：被锁定】
# 2）svn status -v path # (显示文件和子目录状态) 简写：svn st
# 第一列保持相同，第二列显示工作版本号，第三和第四列显示最后一次修改的版本号和修改人。
# 注：svn status、svn diff和 svn revert这三条命令在没有网络的情况下也可以执行的，原因是svn在本地的.svn中保留了本地版本的原始拷贝。
# svn delete path -m "delete test fle" # 7、删除文件 简写：svn (del, remove, rm)
svn delete svn://192.168.1.1/pro/domain/test.php -m "delete test file" # 或者直接svn delete test.php 然后再svn ci -m 'delete test file‘，推荐使用这种
# svn log path # 8、查看日志
svn log test.php # 显示这个文件的所有修改记录，及其版本号的变化
# svn info path # 9、查看文件详细信息
svn info test.php
# svn diff path # 10、比较差异 (将修改的文件与基础版本比较) 简写：svn di
svn diff test.php
# svn diff -r m:n path # (对版本m和版本n比较差异)
svn diff -r 200:201 test.php
# svn merge -r m:n path # 11、将两个版本之间的差异合并到当前文件
svn merge -r 200:205 test.php #（将版本200与205之间的差异合并到当前文件，但是一般都会产生冲突，需要处理一下）
svn help # 12、SVN 帮助
svn help ci



### nginx
nginx -c "/ddd/web/nginx/conf-hello-svg/nginx.conf"
nginx -t -c "/ddd/web/nginx/conf-hello-svg/nginx.conf" # 只测试配置文件



### java
export JAVA_HOME=/usr/lib/jvm/java-8-oracle
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export HADOOP_HOME=/usr/local/hadoop
export PATH=$PATH:$HADOOP_HOME/bin



### cmake
cmake . -G "Xcode" --build "/ddd/communication/protobuf/protobuf/cmake" -B"/ddd/communication/protobuf/protobuf/cmake-xcode"



### grpc
# hellostreamingworld -> helloworld -> route_guide
CMAKE_CURRENT_BINARY_DIR=/ddd/middle/hello-protobuf-grpc/cmake-build-debug/grpc-hellostreamingworld
hw_proto_path=/ddd/middle/hello-protobuf-grpc/grpc-helloworld/protos
_GRPC_CPP_PLUGIN_EXECUTABLE=/usr/local/bin/grpc_cpp_plugin
hw_proto=/ddd/middle/hello-protobuf-grpc/grpc-helloworld/protos/hellostreamingworld.proto

protoc --grpc_out "${CMAKE_CURRENT_BINARY_DIR}" --cpp_out "${CMAKE_CURRENT_BINARY_DIR}" -I "${hw_proto_path}" --plugin=protoc-gen-grpc="${_GRPC_CPP_PLUGIN_EXECUTABLE}" "${hw_proto}"

Official GitHub mirror: github.com/justinfrankel/licecap



### gcc
./configure --build=i386-linux --host=arm-linux --target=mipsel-linux --prefix=$(pwd)/_install
export LD_LIBRARY_PATH=/.../bin_d:$LD_LIBRARY_PATH



### proxy
git config --global http.proxy http://10.31.58.5:1080
git config --global https.proxy https://10.31.58.5:1080
git config --global --unset http.proxy
git config --global --unset https.proxy

http_proxy="http://10.31.58.78:1080/"
https_proxy="https://10.31.58.78:1080/"
no_proxy=localhost,127.0.0.0,127.0.0.1,127.0.1.1,local.home,10.31.58.86,10.31.58.99,10.31.58.101

127.0.0.1,localhost,10.31.58.*,10.32.50.*,10.31.16.*,10.30.0.*,hadoop-master,hadoop-slave1,hadoop-slave2,192.168.99.*

Scheme: https
Proxy Host: www.51netflix.com
Port: 1443

minikube start --docker-env http_proxy=$http_proxy --docker-env https_proxy=$https_proxy --docker-env no_proxy=$no_proxy

### go golang proxy
alias go='http_proxy=http://127.0.0.1:1080/ https_proxy=http://127.0.0.1:1080/ go'
export https_proxy=http://127.0.0.1:1080/
export http_proxy=http://127.0.0.1:1080/
export GO111MODULE=off

### oudream-ubuntu1
cd /fff/shadowsocksr
python3 ./shadowsocks/local.py

#export local_ip=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | head -n 1)
export local_ip=127.0.0.1
export http_proxy=http://${local_ip}:1080
export HTTP_PROXY=$http_proxy
export https_proxy=https://${local_ip}:1080
export HTTPS_PROXY=$https_proxy
#export ftp_proxy=socks5://${local_ip}:1086
export ftp_proxy=socks5://${local_ip}:8118
export FTP_PROXY=${ftp_proxy}
export all_proxy=${ftp_proxy}
export ALL_PROXY=${all_proxy}
export no_proxy=127.0.0.1,localhost,192.168.0.*,192.168.1.*,192.168.99.*,10.31.58.*,10.32.50.*,10.31.16.*,10.30.0.*,hadoop-master,hadoop-slave1,hadoop-slave2
export NO_PROXY=$no_proxy

ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | head -n 1
ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'

$go env
GOPATH="/home/ferghs/gowork:/home/ferghs/gowork/src/project1"
Windows使用分号分割(;)



### docker
# docker-server control
service docker start
systemctl start docker
service docker stop
systemctl stop docker
docker run -t -i ubuntu /bin/bash # start ubuntu in interaction
docker exec -it $ContainerID /bin/bash
docker ps -a
docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $INSTANCE_ID # Get an instance’s IP address
docker inspect --format='{{range .NetworkSettings.Networks}}{{.MacAddress}}{{end}}' $INSTANCE_ID # Get an instance’s MAC address
docker inspect --format='{{.LogPath}}' $INSTANCE_ID # Get an instance’s log path
docker system prune -a # clean cache
docker volume create portainer_data
docker run -d -p 9000:9000 --restart=always --name portainer -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer
# Folder Directory
#~/Library/Containers/com.docker.docker
#/var/lib/docker



### kubernetes
minikube start --docker-env http_proxy=$http_proxy --docker-env https_proxy=$https_proxy --docker-env no_proxy=$no_proxy --docker-env HTTP_PROXY=$http_proxy --docker-env HTTPS_PROXY=$https_proxy --docker-env NO_PROXY=$no_proxy
minikube start --docker-env HTTP_PROXY=$http_proxy --docker-env HTTPS_PROXY=$https_proxy --docker-env NO_PROXY=$no_proxy
minikube ssh

export no_proxy=$no_proxy,$(minikube ip)
export NO_PROXY=$no_proxy

kubectl run hello-minikube --image=k8s.gcr.io/echoserver:1.10 --port=8080
kubectl expose deployment hello-minikube --type=NodePort
kubectl get pod
curl $(minikube service hello-minikube --url)
kubectl delete services hello-minikube
kubectl delete deployment hello-minikube
minikube stop



### vmware
#https://docs.vmware.com/cn/VMware-Fusion/11/com.vmware.fusion.using.doc/GUID-3E063D73-E083-40CD-A02C-C2047E872814.html
vmrun -T ws start "/opt/VMware/win2k8r2.vmx" nogui
# 启动无图形界面虚拟机
#（-T 是区分宿主机的类型，ws|server|server1|fusion|esx|vc|player，比较常用的是ws、esx和player）
vmrun start "/opt/VMware/win2k8r2.vmx" gui
# 启动带图形界面虚拟机
vmrun stop "/opt/VMware/win2k8r2.vmx" hard | soft
# 强制关闭虚拟机(相当于直接关电源) | 正常关闭虚拟机
vmrun reset "/opt/VMware/win2k8r2.vmx" hard | soft
# 冷重启虚拟机 | 热重启虚拟机
vmrun suspend  "/opt/VMware/win2k8r2.vmx" hard | soft
# 挂起虚拟机（可能相当于休眠）
vmrun pause  "/opt/VMware/win2k8r2.vmx"
# 暂停虚拟机
vmrun unpause  "/opt/VMware/win2k8r2.vmx"
# 停止暂停虚拟机
vmrun list
# 列出正在运行的虚拟机
ps aux | grep vmx
# 另一种查看正在运行虚拟机的方法
vmrun -T ws snapshot "/opt/VMware/win2k8r2.vmx" snapshotName
# 创建一个快照（snapshotName 快照名）
vmrun -T ws reverToSnapshot "/opt/VMware/win2k8r2.vmx" snapshotName
# 从一个快照中恢复虚拟机（snapshotName 快照名）
vmrun -T ws listSnapshots "/opt/VMware/win2k8r2.vmx"
# 列出虚拟机快照数量及名称
vmrun -T ws deleteSnapshot "/opt/VMware/win2k8r2.vmx" snapshotName
# 删除一个快照（snapshotName 快照名）



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



### find
macos:
touch -t "201802210444" /tmp/start
touch -t "201802210445" /tmp/end
find /usr/local/bin -newer /tmp/start -not -newer /tmp/end
linux:
touch --date "2007-01-01" /tmp/start
touch --date "2008-01-01" /tmp/end
find /data/images -type f -newer /tmp/start -not -newer /tmp/end

find . -iname "*" -type f -exec ln -s /home/oudream/untitled2/{} /fff/a \;

find . -maxdepth 1 -type d | while read dir; do count=$(find "$dir" -type f | wc -l); echo "$dir : $count"; done

# I'm trying to find files with multiple extensions in a shell script
find $DIR -name \*.jpg -o -name \*.png -o -name \*.gif -print



### ls
# -X 根据扩展名排序
# -S 根据文件大小排序
# -t 以文件修改时间排序
# -v 根据版本进行排序
# -U 不进行排序;依文件系统原有的次序列出项目
ls -a # –all 列出目录下的所有文件，包括以 . 开头的隐含文件
ls -R # 显示子目录结构
ls -F # 追加文件的类型标识符，具体含义：“*”表示具有可执行权限的普通文件，“/”表示目录，“@”表示符号链接，“|”表示命令管道FIFO，“=”表示sockets套接字。
ls -S # 由大到小排序
ls -Sr # 从小到大排序
ls -t # 从新到旧
ls -tr # 从旧到新
ls -h # –human-readable
ls -T # 长日期格式
ls -lR | grep "^-" | wc -l # 统计目录数量
tree -L 2
find . -maxdepth 1 -type d | while read dir; do count=$(find "$dir" -type f | wc -l); echo "$dir : $count"; done
ls | sed "s:^:`pwd`/:"   # full path
ls | sed "s:^:`pwd`/:" | sed "s/^/$HOSTNAME:/g"
find $PWD -maxdepth 1  | xargs ls -ld



### sort
# sort的工作原理
# sort将文件的每一行作为一个单位，相互比较，比较原则是从首字符向后，依次按ASCII码值进行比较，最后将他们按升序输出。
# -u: 它的作用很简单，就是在输出行中去除重复行
# -r: sort默认的排序方式是升序，如果想改成降序，就加个-r就搞定了。
# -o: sort -r number.txt -o number.txt 把结果写入到原文件中。如果写新文件直接用重定向可就行了。
# -n: 要以数值来排序
# -t: 设定间隔符。sort -n -k 2 -t : facebook.txt
# -f: 会将小写字母都转换为大写字母来进行比较，亦即忽略大小写
# -c: 会检查文件是否已排好序，如果乱序，则输出第一个乱序的行的相关信息，最后返回1
# -C: 会检查文件是否已排好序，如果乱序，不输出内容，仅返回1
# -M: 会以月份来排序，比如JAN小于FEB等等
# -b: 会忽略每一行前面的所有空白部分，从第一个可见字符开始比较。
# -k: ***重点***. sort -t ‘ ‘ -k 1 facebook.txt 按第一个域进行排序
# -k: sort -n -t ‘ ‘ -k 3r -k 2 facebook.txt 按第三个域进行降序排序
# -k选项的具体语法格式
# 要继续往下深入的话，就不得不来点理论知识。你需要了解-k选项的语法格式，如下：
# [ FStart [ .CStart ] ] [ Modifier ] [ , [ FEnd [ .CEnd ] ][ Modifier ] ]
# 这个语法格式可以被其中的逗号（“，”）分为两大部分，Start部分和End部分。
# 先给你灌输一个思想，那就是“如果不设定End部分，那么就认为End被设定为行尾”。这个概念很重要的，但往往你不会重视它。
# Start部分也由三部分组成，其中的Modifier部分就是我们之前说过的类似n和r的选项部分。我们重点说说Start部分的FStart和C.Start。
# C.Start也是可以省略的，省略的话就表示从本域的开头部分开始。之前例子中的-k 2和-k 3就是省略了C.Start的例子喽。
# FStart.CStart，其中FStart就是表示使用的域，而CStart则表示在FStart域中从第几个字符开始算“排序首字符”。
# 同理，在End部分中，你可以设定FEnd.CEnd，如果你省略.CEnd，则表示结尾到“域尾”，即本域的最后一个字符。或者，如果你将CEnd设定为0(零)，也是表示结尾到“域尾”。
sort -t ' ' -k 1.2 facebook.txt # 第二个字母开始进行排序
sort -t ' ' -k 1.2,1.2 -k 3,3nr facebook.txt # 第二个字母进行排序，如果相同的按照员工工资进行降序排序


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



### 用户
# 管理员：root, 0；普通用户：1-65535；系统用户：1-499, 1-999(centos7) 作用：对守护进程获取资源进行权限分配；
#    登录用户:500+, 1000+
# 用户组GID：管理员组：root, 0；系统组：1-499, 1-999(centos7)；普通组：500+, 1000+
# Linux安全上下文：运行中的程序：进程 (process)，以进程发起者的身份运行；
#    进程所能够访问的所有资源的权限取决于进程的发起者的身份；
w # 查看活动用户
id <用户名> # 查看指定用户信息
last # 查看用户登录日志
cut -d: -f1 /etc/passwd # 查看系统所有用户
cut -d: -f1 /etc/group # 查看系统所有组
crontab -l # 查看当前用户的计划任务
# 列出用户信息，文件列表，警告: 不要手动编辑这些文件。有些工具可以更好的处理锁定、避免数据库错误。
cat /etc/shadow	# 保存用户安全信息
cat /etc/passwd	# 用户账户信息
cat /etc/gshadow # 保存组账号的安全信息
cat /etc/group # 定义用户所属的组
cat /etc/sudoers # 可以运行 sudo 的用户
cat /home/* # 主目录
### 用户组名
# adm     类似 wheel 的管理器群组.
# ftp     /srv/ftp/	访问 FTP 服务器.
# games	  /var/games	访问一些游戏。
# log     访问 syslog-ng 创建的 /var/log/ 日志文件.
# http    /srv/http/	访问 HTTP 服务器文件.
# sys     Right to administer printers in CUPS.
# systemd-journal  /var/log/journal/* 以只读方式访问系统日志，和 adm 和 wheel 不同. 不在此组中的用户仅能访问自己生成的信息。
# users   标准用户组.
# uucp    /dev/ttyS[0-9]+, /dev/tts/[0-9]+, /dev/ttyUSB[0-9]+, /dev/ttyACM[0-9]+	串口和 USB 设备，例如猫、手柄 RS-232/串口。
# wheel   管理组，通常用于　sudo　和 su 命令权限。systemd 会允许非　root 的 wheel 组用户启动服务。
### 用户管理 useradd usermod userdel ，useradd 与 usermod 参数一样
useradd [options] login
usermod [OPTION] login
# -u UID: 新UID
# -g GID: 新基本组
# -G GROUP1[,GROUP2,...[,GROUPN]]]：新附加组，原来的附加组将会被覆盖；若保留原有，则要同时使用-a选项，表示append；
# -a（追加到新组时）开关是必不可少的。否则，将从任何组中删除用户
# -s SHELL：新的默认SHELL；
# -c 'COMMENT'：新的注释信息；
# -d HOME: 新的家目录；原有家目录中的文件不会同时移动至新的家目录；若要移动，则同时使用-m选项；
# -l login_name: 新的名字；
# -L: lock指定用户
# -U: unlock指定用户
# -e YYYY-MM-DD: 指明用户账号过期日期；
# -f INACTIVE: 设定非活动期限；
userdel [OPTION] login # -r: 删除用户家目录；
# 例如：
useradd testuser # 创建用户testuser
passwd testuser # 给已创建的用户testuser设置密码
# 说明：新创建的用户会在/home下创建一个用户目录testuser
usermod --help 修改用户这个命令的相关参数
userdel testuser # 删除用户testuser   rm -rf testuser 删除用户testuser所在目录
id user # 查看用户
su <用户名> # 命令行用户切换，su是switch user的缩写，
# 用户组管理： groupadd groupmod groupdel，groupadd 与 groupmod 参数一样
groupadd (选项)(参数) # -g：指定新建工作组的id；-r：创建系统工作组，系统工作组的组ID小于500；
#    -K：覆盖配置文件“/ect/login.defs”； -o：允许添加组ID号不唯一的工作组。
groupadd -g 344 linuxde
groupmod (选项)(参数)
groupdel (参数)
sudo usermod -a -G groupName userName # 增加用户到组，-a（追加）开关是必不可少的。否则，将从任何组中删除用户
# 批量管理用户：
#    成批添加/更新一组账户：newusers
#    成批更新用户的口令：chpasswd
gpasswd -a <用户账号名> <组账号名> # 向标准组中添加用户
usermod -G <组账号名> <用户账号名> # 向标准组中添加用户
gpasswd -d <用户账号名> <组账号名> # 从标准组中删除用户
passwd [<用户账号名>]  # 设置用户口令：
passwd -l <用户账号名> # 禁用用户账户口令
passwd -S <用户账号名> # 查看用户账户口令状态
passwd -u <用户账号名> # 恢复用户账户口令
passwd -d <用户账号名> # 清除用户账户口令
# 口令时效设置：修改 /etc/login.defs 的相关配置参数
# id：显示用户当前的uid、gid和用户所属的组列表
# groups：显示指定用户所属的组列表
# whoami：显示当前用户的名称
# w/who：显示登录用户及相关信息
# newgrp：用于转换用户的当前组到指定的组账号，用户必须属于该组才可以正确执行该命令


### chown chmod 权限

# drwxrwxrwx 是10个空间保持值。你可以忽略第一个，然后有 3组 3。第一集为所有者，第二个集为该组，最后一集为世界。
# 第一个字符表示文件类型。
# - 表示该文件是一个普通文件
# d 表示该文件是一个目录，字母"d"，是dirtectory(目录)的缩写。注意：目录或者是特殊文件，这个特殊文件存放其他文件或目录的相关信息
# l 表示该文件是一个链接文件。字母"l"是link(链接)的缩写，类似于windows下的快捷方式
# b 的表示块设备文件(block)，一般置于/dev目录下，设备文件是普通文件和程序访问硬件设备的入口，是很特殊的文件。没有文件大小，只有一个主设备号和一个辅设备号。一次传输数据为一整块的被称为块设备，如硬盘、光盘等。最小数据传输单位为一个数据块(通常一个数据块的大小为512字节)
# c 表示该文件是一个字符设备文件(character)，一般置于/dev目录下，一次传输一个字节的设备被称为字符设备，如键盘、字符终端等，传输数据的最小单位为一个字节
# p 表示该文件为命令管道文件。与shell编程有关的文件
# s 表示该文件为sock文件。与shell编程有关的文件
# r 表是读 (Read) 、w表示写(Write) 、x表示执行 (eXecute)

chmod [class] [operator] [permission] 文件
chmod ［who］ ［+ | - | =］ ［mode］ 文件名
chmod [ugoa] [+ or -] [rwx] 文件
# 权限范围：u ：目录或者文件的当前的用户；g ：目录或者文件的当前的群组；
#    o ：除了目录或者文件的当前用户或群组之外的用户或者群组；a ：所有的用户及群组
# 权限代号：r ：读权限，用数字4表示；w ：写权限，用数字2表示；x ：执行权限，用数字1表示
#    - ：删除权限，用数字0表示；s ：特殊权限；r=4，w=2，x=1; 若要rw-属性则4+2=6；
chmod u+x，g-w，o todo.txt

chown [选项] 用户或组 文件
- R 递归式地改变指定目录及其下的所有子目录和文件的属组。
chgrp [选项] group filename?
- R 递归式地改变指定目录及其下的所有子目录和文件的属组。

### 服务 Systemd
service --status-all systemctl
systemctl list-units --type=service
chkconfig --list # 列出所有系统服务
chkconfig --list | grep on # 列出所有启动的系统服务
sysv-rc-conf
sudo systemctl set-default multi-user.target # 开机后进入命令行界面：
sudo systemctl set-default graphical.target # 开机后进入图形界面
systemctl list-units --all --type=service --no-pager # List all services
sudo systemctl enable httpd # systemctl enable test.service # 开机启动
sudo systemctl disable httpd # systemctl disable test.service # 开机不启动
sudo systemctl start httpd # 启动服务
sudo systemctl status httpd # 查看服务的状态
sudo systemctl stop httpd.service # 停止服务
sudo systemctl kill httpd.service # 服务停不下来。这时候就不得不"杀进程"了
# 配置文件主要放在 /usr/lib/systemd/system 目录，也可能在 /etc/systemd/system
systemctl cat sshd.service # 查看配置文件
# [Unit] 区块：启动顺序与依赖关系
#    Description 字段给出当前服务的简单描述，Documentation 字段给出文档位置
#    After 和 Before 字段只涉及启动顺序，不涉及依赖关系
#    Wants 字段：表示"弱依赖"关系，Requires 字段则表示"强依赖"关系
# [Service] 区块：启动行为
#    ExecStart 字段：定义启动进程时执行的命令；ExecReload 字段：重启服务时执行的命令; ExecStop 字段：停止服务时执行的命令;
#    ExecStartPre 字段：启动服务之前执行的命令；ExecStartPost 字段：启动服务之后执行的命令；ExecStopPost 字段：停止服务之后执行的命令
#    Type：simple（默认值）：ExecStart字段启动的进程为主进程; oneshot（值）：类似于simple，但只执行一次
#    Restart：no（默认值）：退出后不会重启；always：不管是什么退出原因，总是重启
# [Install] 区块：Install区块，定义如何安装这个配置文件，即怎样做到开机启动。
#    WantedBy：服务组，执行 systemctl enable sshd.service 命令后，就会在 /etc/systemd/system/multi-user.target.wants目录中存放 service 文件。


[Unit]
Description=Frp Server Service
After=systemd-networkd.service network.target sshd.service

[Service]
Type=simple
User=nobody
Restart=on-failure
RestartSec=5s
ExecStart=/bin/bash -c '/fff/frp/frps -c /fff/frp/frps.ini'

[Install]
WantedBy=multi-user.target


[Unit]
Description=Frp Client Service
After=systemd-networkd.service network.target sshd.service

[Service]
Type=simple
User=nobody
Restart=on-failure
RestartSec=5s
ExecStart=/bin/bash -c '/fff/frp/frpc -c /fff/frp/frpc.ini'
ExecReload=/usr/bin/frpc reload -c /etc/frp/frpc.ini

[Install]
WantedBy=multi-user.target


[Unit]
Description=frp deamon
After=network.target network-online.target sshd.service

[Service]
Type=simple
WorkingDirectory=/fff/frp
ExecStart=/bin/bash -c '/fff/frp/frps -c /fff/frp/frps-remote.ini'
ExecStartPre=/bin/sh -c 'until nc -zv 13.112.200.162 7000; do sleep 3; done;'
Restart=always

[Install]
WantedBy=multi-user.target

### Journalctl 查看和操作 Systemd 日志
journalctl -b   # 当前引导的日志, 显示自最近重新引导以来收集的所有日记帐分录。
journalctl --since "2015-01-10" --until "2015-01-11 03:00"
journalctl --since yesterday
journalctl --since 09:00 --until "1 hour ago"
journalctl -u nginx.service --since today # 按单位, 按消息兴趣过滤
journalctl _PID=8088 # 按进程，用户或组ID
journalctl /usr/bin/bash # 按组件路径
journalctl -k # 显示内核消息
journalctl -n 20 # 工作原理完全一样 tail -n
journalctl -f # 要积极跟踪日志，因为他们正在写的。你可能期望tail -f
journalctl --disk-usage # 该杂志目前使用占用的磁盘空间量
sudo journalctl --vacuum-size=1G # 将删除旧条目，直到磁盘上占用的总日志空间为所请求的大小





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



### 程序
rpm -qa # 查看所有安装的软件包
## dpkg
dpkg -L unixodbc | xargs -I {} cp {} ~/oudream/1 # 列出 unixodbc 并拷贝到目录……
dpkg -i package.deb #安装包
dpkg -r package #删除包
dpkg -P package #删除包（包括配置文件）
dpkg -L package #列出与该包关联的文件
dpkg -l package #显示该包的版本
dpkg --unpack package.deb #解开 deb 包的内容
dpkg -S keyword #搜索所属的包内容
dpkg -l #列出当前已安装的包
dpkg -c package.deb #列出 deb 包的内容
dpkg --configure package #配置包
# example
dpkg -i package #安装包
dpkg -R /usr/local/src #安装一个目录下面所有的软件包
dpkg --unpack package #解开一个包，如果和-R一起使用，参数可以是一个目录
dpkg --configure package #重新配置和释放软件包
dpkg -r package #删除包
dpkg --merge-avail #合并包
dpkg -P #删除包，包括配置文件
dpkg -A package #从软件包里面读取软件的信息
dpkg --update-avail #替代软件包的信息
dpkg --forget-old-unavail #删除Uninstall的软件包信息
dpkg --clear-avail #删除软件包的Avaliable信息
dpkg -C #查找只有部分安装的软件包信息
dpkg --compare-versions ver1 op ver2 #比较同一个包的不同版本之间的差别
dpkg -b directory [filename] #建立一个deb文件
dpkg -c filename #显示一个Deb文件的目录
dpkg -p package #显示包的具体信息
dpkg -S filename-search-pattern #搜索指定包里面的文件（模糊查询）
dpkg -L package #显示一个包安装到系统里面的文件目录信息
dpkg -s package #报告指定包的状态信息
dpkg -l #显示所有已经安装的Deb包，同时显示版本号以及简短说明
## apt-get , apt
# apt-get是一条linux命令，适用于deb包管理式的操作系统，主要用于自动从互联网的软件仓库中搜索、安装、升级、卸载软件或操作系统。
apt-get update # 升级安装包相关的命令,刷新可安装的软件列表(但是不做任何实际的安装动作)
apt-get upgrade # 进行安装包的更新(软件版本的升级)
apt-get dist-upgrade # 进行系统版本的升级(Ubuntu版本的升级)；如果系统提示某些软件包会被“保留”而不能被升级，则可以用 apt-get dist-upgrade 命令来升级所有软件包：
do-release-upgrade # Ubuntu官方推荐的系统升级方式,若加参数-d还可以升级到开发版本,但会不稳定
apt-get install [软件名称] # 安装一个新软件包
apt-get remove [软件名称] # 卸载一个已安装的软件包（保留配置文档）
apt-get remove --purge [软件名称] # 卸载一个已安装的软件包（删除配置文档）
apt-get autoremove [软件名称] # 删除包及其依赖的软件包
apt-get autoremove --purge [软件名称] # 删除包及其依赖的软件包+配置文件，比上面的要删除的彻底一点
dpkg --force-all --purge [软件名称] # 有些软件很难卸载，而且还阻止了别的软件的应用，就能够用这个，但是有点冒险。
## 一次性安装
apt-get update -y ; apt-get upgrade -y && \
apt-get install apt-utils wget openssh-server telnet vim passwd ifstat unzip iftop telnet samba net-tools lsof rsync gcc g++ cmake build-essential gdb gdbserver unixodbc unixodbc-dev -y && \
# rm -rf /var/lib/apt/lists/*



### macos
dscl . -list /Users
dscl . -list /Groups
dscacheutil -q group
sudo spctl --master-disable



### network
telnet 192.168.1.1 25
# 如果不嫌多一步可以考虑用CTRL+]键，这时会强制退到telnet命令界面下，再用quit退出就行了，百试百灵。
# 其它就是用CTRL +C或CTRL+D两种方式来强行断开与远程的连接，但能支持这种命令的比较少。
# 最后的方法就是关掉telnet的窗口。
# 监听本地端口
nc -l -p 80   # 开启本机 80 端口 TCP 监听
nc -l -p 80 > /tmp/log
# 扫描端口
nc -zv host.example.com 22           # 扫描 22 端口是否开放
nc -zv host.example.com 22 80 443    # 扫描端口
nc -zv host.example.com 20-30        # 扫描一个范围
nc -zv -w 5 host.example.com 22-443  # -w 表示超时等待 5 秒
# 作为简单的 Web Server
nc -l 8080 < index.html
curl localhost:8080
# ping
until ping -c1 google.com; do sleep 1; done;
until [$(nc -zv 13.112.200.162 7000) == "*succeeded*"]; do sleep 1; done;
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



### remote sftp scp ssh ssh-keygen ssh-copy-id
## SSH 的配置文件在 /etc/ssh/sshd_config 中，你可以看到端口号, 空闲超时时间等配置项。
# 使用-p选项指定端口号, 直接连接并在后面加上要执行的命令就可以了
sudo vim /etc/ssh/sshd_config
# 找到PermitRootLogin prohibit-password一行，改为PermitRootLogin yes
sed -i 's/#PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
# 服务器端的心跳机制，添加 # ClientAliveInterval表示每隔多少秒，服务器端向客户端发送心跳 # 表示上述多少次心跳无响应之后，会认为Client已经断开
ClientAliveInterval 30
ClientAliveCountMax 6
sudo service ssh restart
sftp get -r /usr/local/hadoop/tmp /ddd/hadoop/hadoop-3.1.0
scp -r local_folder remote_username@remote_ip:remote_folder
scp -r /home/space/music/ root@vm-ubuntu1:/home/root/others/ # copy local to remote
scp -r root@vm-ubuntu1:/home/root/others/ /home/space/music/ # copy remote to local
# clipboard
# From a X(7) man page:
cat /fff/tmp/000.txt | ssh -X 10.35.191.11 "DISPLAY=:0.0 pbcopy -i"
ssh -p 56743 oudream@frp1.chuantou.org ls -l
# 另外一个很赞的基于 SSH 的工具叫 sshfs. sshfs 可以让你在本地直接挂载远程主机的文件系统.
# sshfs -o idmap=user user@hostname:/home/user ~/Remote
sshfs -o idmap=user pi@10.42.0.47:/home/pi ~/Pi
# 打开调试模式
ssh -v 192.168.0.103
# 把服务端的 X11 应用程序显示到客户端计算机上
ssh -X oudream@10.31.58.75 xclock

# ssh-keygen 用于：生成、管理和转换认证密钥
# 通常，这个程序产生一个密钥对，并要求指定一个文件存放私钥，同时将公钥存放在附加了".pub"后缀的同名文件中。
#      程序同时要求输入一个密语字符串(passphrase)，空表示没有密语(主机密钥的密语必须为空)。
#      密语和口令(password)非常相似，但是密语可以是一句话，里面有单词、标点符号、数字、空格或任何你想要的字符。
#      好的密语要30个以上的字符，难以猜出，由大小写字母、数字、非字母混合组成。密语可以用 -p 选项修改。
#      丢失的密语不可恢复。如果丢失或忘记了密语，用户必须产生新的密钥，然后把相应的公钥分发到其他机器上去。
#      RSA1的密钥文件中有一个"注释"字段，可以方便用户标识这个密钥，指出密钥的用途或其他有用的信息。
#      创建密钥的时候，注释域初始化为"user@host"，以后可以用 -c 选项修改。
#      密钥产生后，下面的命令描述了怎样处置和激活密钥。可用的选项有：
# -t type:指定要生成的密钥类型，有rsa1(SSH1),dsa(SSH2),ecdsa(SSH2),rsa(SSH2)等类型，较为常用的是rsa类型
# -C comment：提供一个新的注释
# -b bits：指定要生成的密钥长度 (单位:bit)，对于RSA类型的密钥，最小长度768bits,默认长度为2048bits。DSA密钥必须是1024bits
# -f filename:指定生成的密钥文件名字
ssh-keygen -t rsa -p "" # 此时在本机上生成如下一个公钥和一个私钥文件：
cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys
# 执行 # ssh localhost # 可以发现此时无需输入密码
ssh-copy-id -i $HOME/.ssh/id_rsa.pub hadoop@192.168.24.129
ssh-copy-id -i $HOME/.ssh/id_rsa.pub hadoop@192.168.24.130
ssh-copy-id -i ~/.ssh/id_rsa.pub “-p 3330 liujiakun@192.168.3.105“ # 拷贝公钥到服务器上，服务器端ssh的端口(比如为3330)
ssh-keygen -F 222.24.51.147 # 查看是否已经添加了对应主机的密钥
ssh-keygen -R 222.24.51.147 # 删除主机密钥 ~/.ssh/known_hosts
# $HOME/.ssh/identity: 使用SSH协议版本1时，$HOME/.ssh/identity文件包含RSA私钥。
# $HOME/.ssh/identity.pub: 当你使用SSH协议版本一时，$HOME/.ssh/identity.pub文件包含用于进行身份验证的RSA公钥。用户应将其内容复制到用户希望使用RSA身份验证登录的远程系统的$HOME/.ssh/authorized_keys文件中。
# $HOME/.ssh/id_dsa: $HOME/.ssh/id_dsa文件包含用户的协议版本2 DSA身份验证标识。
# $HOME/.ssh/id_dsa.pub: 当您使用SSH协议版本2时，$HOME/.ssh/id_dsa.pub文件包含用于身份验证的DSA公钥。 用户应将其内容复制到用户希望使用DSA身份验证登录的远程系统的$HOME/.ssh/authorized_keys文件中。
# $HOME/.ssh/id_rsa: $HOME/.ssh/id_rsa文件包含用户的协议版本2 RSA身份验证标识。 除了用户之外，任何人都不应该有读取此文件的权限。
# $HOME/.ssh/id_rsa.pub: $HOME/.ssh/id_rsa.pub文件包含用于身份验证的协议版本2 RSA公钥。 应在用户希望使用公钥认证登录的所有计算机上将此文件的内容添加到$HOME/.ssh/authorized_keys。



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


### tar unzip
## .tar
# 解包：
tar xvf FileName.tar
# 打包：
tar cvf FileName.tar DirName
# （注：tar是打包，不是压缩！）

## .gz
# 解压1：
gunzip FileName.gz
# 解压2：
gzip -d FileName.gz
# 压缩：
gzip FileName

## .tar.gz 和 .tgz
# 解压：
tar zxvf FileName.tar.gz
# 压缩：
tar zcvf FileName.tar.gz DirName

## .bz2
# 解压1：
bzip2 -d FileName.bz2
# 解压2：
bunzip2 FileName.bz2
# 压缩：
bzip2 -z FileName

## .tar.bz2
# 解压：
tar jxvf FileName.tar.bz2
# 压缩：
tar jcvf FileName.tar.bz2 DirName

## .bz
# 解压1：
bzip2 -d FileName.bz
# 解压2：
bunzip2 FileName.bz
# 压缩：未知

## .tar.bz
# 解压：
tar jxvf FileName.tar.bz
# 压缩：
# 未知

## .Z
# 解压：
uncompress FileName.Z
# 压缩：
compress FileName

## .tar.Z
# 解压：
tar Zxvf FileName.tar.Z
# 压缩：
tar Zcvf FileName.tar.Z DirName

## .zip
# 解压：
unzip FileName.zip
# 压缩：
zip FileName.zip DirName

## .rar
# 解压：
rar x FileName.rar
# 压缩：
rar a FileName.rar DirName



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



### redis
## on macos
brew install redis
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.redis.plist # Start Redis server via “launchctl”.
launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.redis.plist # Stop Redis on autostart on computer start.
redis-cli shutdown # Stop all the clients. Perform a blocking SAVE if at least one save point is configured. Flush the Append Only File if AOF is enabled. Quit the server.
## on ubuntu
sudo systemctl start redis
sudo systemctl enable redis
sudo systemctl restart redis
sudo systemctl stop redis
