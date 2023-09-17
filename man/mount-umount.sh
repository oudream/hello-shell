#!/usr/bin/env bash

umount /dev/


# 可以将VPS文件系统挂载到本地计算机上，这样您就可以动态地进行更改并将您的服务器的文件
sudo apt-get install sshfs
sudo port install sshfs # macos
# 永久挂载远程文件系统，编辑本地计算机上/etc/fstab文件
sudo nano /etc/fstab
# 增加
sshfs#root@xxx.xxx.xxx.xxx:/ /mnt/droplet
# 等同于
sudo sshfs -o allow_other,defer_permissions root@xxx.xxx.xxx.xxx:/ /mnt/droplet

sshfs -C -o reconnect oudream@10.31.58.132:/ddd /fff/r132ddd


# mount 远程共享文件夹
sudo mount -o username=oudream,password=XXXXX //192.168.169.132/opt/ddd/ccpp/hello-cmake /opt/ddd/ccpp/hello-cmake

sudo mount -t cifs -o username=administrator,password=ygct@12345678 //10.31.58.215/d /eee/215d

sudo mount -t cifs //10.35.191.11/ddd /eee/11d -o username=oudream,password=oudream,nounix,sec=ntlmssp

sudo mount -t cifs //192.168.0.103/ddd /ddd -o username=oudream,password=oudream,nounix,sec=ntlmssp

sudo mount -t cifs //144.202.65.220/fff/ceph /eee/ceph -o username=root,password=XXXXX,nounix,sec=ntlmssp


# mount 215
sudo mount -t cifs -o username=administrator,password=ygct@12345678 //10.31.58.215/d /eee/215d
# mount 11
sudo mount -t cifs //10.35.191.11/ddd /eee/11d -o username=oudream,password=oudream,nounix,sec=ntlmssp
# ssh -X
ssh -X 10.35.191.11 "DISPLAY=:0.0 pbcopy -i"


# mount
mount | column -t # 查看挂接的分区状态
mount -t cifs -o username=Bob,password=123456 //192.168.0.102/Share /usr/local/bin/code
df -h # 查挂载在状态
mount
umount /usr/local/bin/code


# mount命令用于加载文件系统到指定的加载点。此命令的最常用于挂载cdrom，使我们可以访问cdrom中的数据，因为你将光盘插入cdrom中，
#    Linux并不会自动挂载，必须使用Linux mount命令来手动完成挂载。

mount option params

# 选项
# -t type：指定挂载的文件系统类型，一般不用指定，mount 命令能够自行判断。
# -V：显示程序版本；
# -l：显示已加载的文件系统列表；
# -h：显示帮助信息并退出；
# -v：冗长模式，输出指令执行的详细信息；
# -n：加载没有写入文件“/etc/mtab”中的文件系统；
# -r：将文件系统加载为只读模式；
# -a：加载文件“/etc/fstab”中描述的所有文件系统。

# 参数
# 设备文件名：指定要加载的文件系统对应的设备名；
# 加载点：指定加载点目录。

#实例
mount -t auto /dev/cdrom /mnt/cdrom
# mount: mount point /mnt/cdrom does not exist           /mnt/cdrom目录不存在，需要先创建。

cd /mnt
#-bash: cd: /mnt: No such file or directory

# 创建/mnt/cdrom目录
mkdir -p /mnt/cdrom
# 挂载cdrom
mount -t auto /dev/cdrom /mnt/cdrom
# mount: block device /dev/cdrom is write-protected, mounting read-only     挂载成功

# 查看cdrom里面内容
ll /mnt/cdrom