#!/usr/bin/env bash

# https://linux.die.net/man/1/ssh

scp -i yours.pem  xxxxxxx@awsec2ip:/path/to/file
chmod 600 yours.pem

# 查看ssh用户登录日志/var/log/secure
tail -20 /var/log/secure
last                      # 查看最近登录日志
less /var/log/messages    # 查看最近系统操作信息
cat /etc/hosts.allow      #
cat /etc/hosts.deny       # 配置文件限定ip登录

# 打开调试模式
ssh -v 192.168.0.103
# 把服务端的 X11 应用程序显示到客户端计算机上
ssh -X oudream@10.31.58.75 xclock
ssh -Y oudream@10.31.58.75 xclock
# 打开授权 auth -A
ssh -AXY root@35.239.31.154
# 访问特定端口
ssh -p 2222 root@127.0.0.1

# sftp
sftp get -r /usr/local/hadoop/tmp /ddd/hadoop/hadoop-3.1.0

# scp
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


# restart ssh
# How to restart the SSHD daemon in Debian / Ubuntu Linux
# Type the systemctl command:
sudo systemctl restart ssh
#
# CentOS / RHEL / Fedora / Redhat Linux Restart SSHD server
sudo systemctl restart sshd
#
# Restating the SSHD daemon on FreeBSD Unix
/etc/rc.d/sshd restart
# OR
service sshd restart
#
# OpenBSD Unix restart the SSHD service
/etc/rc.d/sshd restart
# OR
/etc/rc.d/sshd restart
#
# Solaris 10 command
svcadm disable ssh
svcadm enable ssh
#
# Solaris version 9 and older users, try:
/etc/init.d/sshd stop
/etc/init.d/sshd start
#
# AIX Unix command
stopsrc -s sshd
startsrc -s sshd
#
# HP-UX Unix command
# To restart sshd daemon on HP-UX, first stop it and again start it as follows:
/sbin/init.d/secsh stop
/sbin/init.d/secsh start


### 免密码登录
cat >> /etc/hosts <<EOF
192.168.5.32 twant32
192.168.5.108 twant108
192.168.5.109 twant109
192.168.5.110 twant110
192.168.5.111 twant111
EOF
### ssh login with no password
ssh-keygen -t rsa
ssh-copy-id root@twant32
ssh-copy-id root@twant108
ssh-copy-id root@twant109
ssh-copy-id root@twant110
ssh-copy-id root@twant111
# cat ~/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys


### 远程执行，获取返回值
result=`ssh root@twant108 "ps -ef | grep nginx | grep -v grep"`
if [ -z "$result" ];then
  echo "no kill"
else
  echo "kill"
  ssh root@10.77.42.99 'ps -ef | grep nginx | grep -v grep | awk "{print \$2}" | xargs kill -9 && wait'
fi


### ssh-keygen 用于：生成、管理和转换认证密钥
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
ssh-keygen -t rsa # 此时在本机上生成如下一个公钥和一个私钥文件：
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


# config
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
sudo service restart ssh
sudo systemctl restart ssh.service

# 如果你没有服务器端管理权限， 在客户端进行设置也可以实现, 只要在/etc/ssh/ssh_config文件里加两个参数就行了
TCPKeepAlive yes
ServerAliveInterval 300
# 前一个参数是说要保持连接，后一个参数表示每过5分钟发一个数据包到服务器表示“我还活着”
# 如果你没有root权限，修改或者创建~/.ssh/ssh_config也是可以的
ssh -o TCPKeepAlive=yes -o ServerAliveInterval=300 pswzyu@nuihq.com -p 12345678



# X11 客户端选项
# https://linux.die.net/man/5/ssh_config
        ForwardX11 yes
        ForwardX11Trusted yes
        XAuthLocation /opt/X11/bin/xauth
        ServerAliveInterval 60
        ForwardX11Timeout 596h

### xauth
# Rename the existing .Xauthority file by running the following command
mv .Xauthority old.Xauthority
# xauth with complain unless ~/.Xauthority exists
touch ~/.Xauthority
# only this one key is needed for X11 over SSH
xauth generate :0 . trusted
# generate our own key, xauth requires 128 bit hex encoding
xauth add ${HOST}:0 . $(xxd -l 16 -p /dev/urandom)
# To view a listing of the .Xauthority file, enter the following
xauth list


# ssh-agent 会启动一个进程在内存里保存这些私钥。之后每次登录时，ssh 客户端都会跟 ssh-agent 请求是否有
#           目标主机的私钥；如果有，ssh 客户端便能直接登录目标主机。
# 通过 ssh-agent bash 或者 eval `ssh-agent` （这里是shell 的命令替换符）来启动。
ssh-agent bash
eval `ssh-agent`

# ssh-add命令是把专用密钥添加到ssh-agent的高速缓存中。该命令位置在/usr/bin/ssh-add。
ssh-add [-cDdLlXx] [-t life] [file...]ssh-add -s pkcs11ssh-add -e pkcs11
# 选项
-D        # 删除ssh-agent中的所有密钥.
-d        # 从ssh-agent中的删除密钥
-e pkcs11 # 删除PKCS#11共享库pkcs1提供的钥匙。
-s pkcs11 # 添加PKCS#11共享库pkcs1提供的钥匙。
-L        # 显示ssh-agent中的公钥
-l        # 显示ssh-agent中的密钥
-t life   # 对加载的密钥设置超时时间，超时ssh-agent将自动卸载密钥
-X        # 对ssh-agent进行解锁
-x        # 对ssh-agent进行加锁



# 1、把专用密钥添加到 ssh-agent 的高速缓存中：
ssh-add ~/.ssh/id_dsa
# 2、从ssh-agent中删除密钥：
ssh-add -d ~/.ssh/id_xxx.pub
# 3、查看ssh-agent中的密钥：
ssh-add -l



PermitRootLogin yes
PasswordAuthentication yes
ChallengeResponseAuthentication no
UsePAM yes
X11Forwarding yes
X11DisplayOffset 10
PrintMotd no
AcceptEnv LANG LC_*
#Subsystem       sftp    /usr/lib/openssh/sftp-server
Subsystem       sftp    /usr/lib/ssh/sftp-server
UseDNS no
ClientAliveInterval 120
UseDNS no


Port 22221 #工作中需要设定到1万以上的端口，避免被扫描出来。
PermitRootLogin no #如果不是超大规模的服务器，为了方便我们可以暂时开启root远程登录
PubkeyAuthentication yes #开启公钥认证模式
AuthorizedKeysFile .ssh/authorized_keys #公钥放置位置
PasswordAuthentication no #为了安全我们关闭服务器的密码认证方式
GSSAPIAuthentication no #关闭GSSAPI认证，极大提高ssh连接速度
UseDNS no #关闭DNS反向解析，极大提高ssh连接速度


/usr/sbin/sshd >>/root/sshd_out.txt 2>>/root/sshd_err.txt
PermitEmptyPasswords yes
PasswordAuthentication yes


### Problem with "Warning: No xauth data; using fake authentication data for X11 forwarding."
Thanks for Help. I added on client configuration file /etc/ssh/ssh_config this 3 line :
XAuthLocation /usr/bin/xauth
ForwardX11 yes
ForwardX11Trusted yes
