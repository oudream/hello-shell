#!/usr/bin/env bash

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

