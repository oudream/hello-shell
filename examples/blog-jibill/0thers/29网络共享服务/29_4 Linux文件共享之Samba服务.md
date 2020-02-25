@[TOC](目录)

# SAMBA服务简介
>SMB：Server Message Block服务器消息块，IBM发布，最早是DOS网络文件共享协议
CIFS：common internet file system，微软基于SMB发布
SAMBA：1991年Andrew Tridgell,实现windows和UNIX相通
>>SAMBA的功能：
•共享文件和打印，实现在线编辑
•实现登录SAMBA用户的身份认证
•可以进行NetBIOS名称解析
•外围设备共享
>>计算机网络管理模式：
•工作组WORKGROUP：计算机对等关系，帐号信息各自管理
•域DOMAIN：C/S结构，帐号信息集中管理，DC,AD


## SAMBA介绍
yum安装
```sh
yum -y install samba
```
相关包：
1. `Samba` 提供smb服务
2. `Samba-client` 客户端软件
3. `samba-common` 通用软件
4. `cifs-utils` smb客户端工具
5. `samba-winbind` 和AD相关


相关服务进程：
1. `smbd` 提供smb（cifs）服务 TCP:139,445
2. `nmbd` NetBIOS名称解析 UDP:137,138

主配置文件：`/etc/samba/smb.conf`

帮助参看：`man smb.conf`

语法检查： `testparm [-v] [/etc/samba/smb.conf]`

客户端工具：`smbclient，mount.cifs`


## SAMBA服务器配置
>smb.conf继承了.ini文件的格式，用[ ] 分成不同的部分

1. 全局设置：
[global]  服务器通用或全局设置的部分

2. 特定共享设置：
[homes]   用户的家目录共享
[printers]   定义打印机资源和服务
[sharename]   自定义的共享目录配置

其中：#和;开头的语句为注释，大小写不敏感

宏定义|说明
- | -
%m |客户端主机的NetBIOS名 %M 客户端主机的FQDN
%H| 当前用户家目录路径 %U 当前用户用户名
%g| 当前用户所属组 %h samba服务器的主机名
%L| samba服务器的NetBIOS名 %I 客户端主机的IP
%T| 当前日期和时间 %S 可登录的用户名

## SAMBA服务器全局配置
```sh
[101]$ cat /etc/samba/smb.conf

[global]
#指定工作组名称
    workgroup = SAMBA 

#Security三种认证方式：
#share：匿名(CentOS7不再支持)
#user：samba用户（采有linux用户，samba的独立口令）
#domain：使用DC（DOMAIN CONTROLLER)认证
    security = user

#主机注释信息
    server string   

#指定NetBIOS名，windows可以用这个名字来访问
    netbios name   

#指定服务侦听接口和IP
    interfaces   

#可用“,” ，空格，或tab分隔，默认允许所有主机访问，也可在每个共享独立配置，
#如在[global]设置，将应用并覆盖所有共享设置，也可以用hosts deny来拒绝
    hosts allow = 172.16.0.  .example.com  

#用户独立的配置文件
    config file = /etc/samba/conf.d/%U 

#不同客户机采用不同日志
    Log file = /var/log/samba/log.%m   

#日志级别，默认为0，不记录日志
    log level = 2   

#日志文件达到50K，将轮循rotate,单位KB
    max log size = 50   

#密码数据库格式
    passdb backend = tdbsam

#获取打印机列表
    printing = cups
    printcap name = cups

#自动加载打印机
    load printers = yes

#可以在Windows客户机上使用驱动程序
    cups options = raw
```


## 管理SAMBA用户
1. 把linux帐号加到samba的帐号中
```sh
#-a是添加，不加就是修改密码
[101]$ smbpasswd -a wang
New SMB password:
Retype new SMB password:
Added user wang.
```
也可以这样
```sh
pdbedit -a -u <user>
```

2. 修改用户密码
```sh
smbpasswd <user>
```

3. 删除用户和密码：
```sh
smbpasswd –x <user>
```
也可以这样删除
```sh
pdbedit –x –u <user>
```

4. 查看samba用户列表：
```sh
/var/lib/samba/private/passdb.tdb
#这是一个数据库文件，cat是看不了的
```
查看详细信息
```sh
pdbedit –L –v
```

5. 查看samba服务器状态
```sh
smbstatus
```


## 配置目录共享
>每个共享目录应该有独立的[ ]部分

```sh
#远程网络看到的共享名称
[共享名称]
#注释信息   
    comment   

#所共享的目录路径
    path   

#能否被guest访问的共享，默认no，和guest ok 类似
    public   

#是否允许所有用户浏览此共享,默认为yes,no为隐藏
    browsable

#可以被所有用户读写，默认为no
    writable=yes 

#和writable=yes等价，如与以上设置冲突，放在后面的设置生效，默认只读
    read only=no 

#三种形式：用户，@组名，+组名,用，分隔
#如writable=no，列表中用户或组可读写，不在列表中用户只读
    write list 


#特定用户才能访问该共享，如为空，将允许所有用户，用户名之间用空格分隔
    valid users 
```

## 基于特定用户和组的共享
```sh
[101]$ vim /etc/samba/smb.conf
[share1]
    path = /data/share1
    valid users=wang
    writeable = no
    write list = wang
    browseable = no
```

#SMB客户端访问
UNC路径格式：`\\sambaserver\sharename`

终端下使用smbclient登录服务器
`smbclient -L 192.168.99.101 -U wang`
> cd directory
> get file1
> put file2
smbclient //192.168.99.101/shared -U wang
可以使用-U选项来指定用户%密码，或通过设置和导出USER和PASSWD环境变量来指定


## 挂载CIFS文件系统
1. 首先需要一个cifs工具
```sh
yum -y install cifs-utils
```

2. 手动挂载
```sh
mount -o user=wang,password=magedu //192.168.99.101/shared /mnt/smb
```

3. 开机自动挂载
```sh
[101]$ cat /etc/fstab    #可以用文件代替用户名和密码的输入
//192.168.99.101/share1 /mnt/share1 cifs sec=ntlmssp,credentials=/etc/smb.txt 0 0
#或这么写
//192.168.99.101/share1 /mnt/share1 cifs sec=ntlmssp,username=smbuser1,passowrd=123 0 0 

[101]$ cat /etc/smb.txt
    username=wang
    password=password

[101]$ chmod 600 /etc/smb.txt
```

- - - 

## 实验：实现SMB共享
**一、在samba服务器上安装samba包**
```sh
yum -y install samba
```

**二、创建samba用户和组**
```sh
groupadd -r admins
useradd -s /sbin/nologin -G admins wang
useradd -s /sbin/nologin chen
smbpasswd -a wang
smbpasswd -a chen
```

**三、创建samba共享目录,并设置SElinux**
关了SELinux的话就跳过吧
```sh
mkdir /testdir/smbshare
chgrp admins /testdir/smbshare
chmod 2775 /testdir/smbshare
semanage fcontext -a -t samba_share_t '/testdir/smbshare(/.*)?'
restorecon -vvFR /testdir/smbshare
```

**三、samba服务器配置**
```sh
vim /etc/samba/smb.conf
    [global]
    security = user
    passdb backend = tdbsam
    ...
    [share]
    path = /testdir/smbshare
    write list = @admins

systemctl start smb nmb
systemctl enable smb nmb
firewall-cmd --permanent --add-service=samba
firewall-cmd --reload
```

**samba客户端访问**

1. 安装包
```sh
yum -y install cifs-utils
```

2. 用wang用户挂载smb共享并访问
```sh
mkdir /mnt/wang
mount -o username=wang //smbserver/share /mnt/wang
echo "Hello wang" >/mnt/wang/wangfile.txt
```

3. 用mage用户挂载smb共享并访问
```sh
mkdir /mnt/mage
mount -o username=mage //smbserver/share /mnt/mage
touch /mnt/mage/magefile.txt
```