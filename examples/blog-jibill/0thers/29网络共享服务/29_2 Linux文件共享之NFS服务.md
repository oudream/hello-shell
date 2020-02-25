
@[TOC](目录)

# NFS服务
>NFS：Network File System 网络文件系统，基于内核的文件系统。Sun公司开发，通过使用NFS，用户和程序可以像访问本地文件一样访问远端系统上的文件，基于RPC（Remote Procedure Call Protocol远程过程调用）实现
>RPC采用C/S模式，客户机请求程序调用进程发送一个有进程参数的调用信息到服务进程，然后等待应答信息。在服务器端，进程保持睡眠状态直到调用信息到达为止。当一个调用信息到达，服务器获得进程参数，计算结果，发送答复信息，然后等待下一个调用信息，最后，客户端调用进程接收答复信息，获得进程结果，然后调用执行继续进行
>NFS优势：节省本地存储空间，将常用的数据,如home目录,存放在NFS服务器上且可以通过网络访问，本地终端将可减少自身存储空间的使用

## NFS文件系统
![](https://img-blog.csdnimg.cn/20190726222134313.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

## NFS工作原理
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190726222141787.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

## NFS各个版本的对比
NFS v2 | NFS v3 | NFS v4
- | - | -
只支持32位文件传输，最大文件数4G|支持64位文件传输|CentOS7默认很使用NFSv4版,实现伪根，辅助服务不需要，完全支持kerberos
文件传输尺寸限制在8K | 没有文件尺寸限制 ||
无|V3增加和完善了许多错误和成功信息的返回,对于服务器的设置和管理能带来很大好处|改进了INTERNET上的存取和执行效能,在协议中增强了安全方面的特性
只提供了对UDP协议的支持,在一些高要求的网络环境中有很大限制|增加了对TCP传输协议的支持,有更好的I/O 写性能.|只支持TCP传输,通过一个安全的带内系统，协商在服务器和客户端之间使用的安全性类型,使用字符串而不是整数来表示用户和组标识符


# NFS服务介绍
>软件包：nfs-utils
Kernel支持：nfs.ko
端口：2049(nfsd), 其它端口由portmap(111)分配

配置文件：`/etc/exports`,`/etc/exports.d/*.exports`
CentOS7不支持同一目录同时用nfs和samba共享，因为使用锁机制不同

相关软件包：rpcbind（必须），tcp_wrappers
CentOS6开始portmap进程由rpcbind代替

NFS服务主要进程： | 说明
- | -
rpc.nfsd | 最主要的NFS进程，管理客户端是否可登录
rpc.mountd| 挂载和卸载NFS文件系统，包括权限管理
rpc.lockd  | 非必要，管理文件锁，避免同时写出错
rpc.statd | 非必要，检查文件一致性，可修复文件

日志：/var/lib/nfs/


## NFS配置文件
路径： `/etc/exports`
导出的文件系统的格式：
`/dir 主机1(opt1,opt2) 主机2(opt1,opt2)...`

1. `#`开始为注释
2. 主机格式：
•单个主机：ipv4，ipv6，FQDN
•IP networks：两种掩码格式均支持:172.18.0.0/16
•wildcards：主机名通配，例如*.magedu.com，IP不可以
•netgroups：NIS域的主机组，@group_name
•anonymous：表示使用*通配所有客户端
3. 每个条目指定目录导出到的哪些主机，及相关的权限和选项
默认选项：(ro,sync,root_squash,no_all_squash)
•`ro`,`rw`  只读和读写
•`async`  异步，数据变化后不立即写磁盘，性能高
•`sync`   同步，数据在请求时立即写入共享
•`no_all_squash` 保留共享文件的UID和GID
•`all_squash`    所有远程用户(包括root)都变成nfsnobody
•`root_squash`   远程root映射为nfsnobody,UID为65534，
•`no_root_squash`  远程root映射成root用户
•`anonuid=`和`anongid=`  指明匿名用户映射为特定用户UID和组GID，而非nfsnobody,可配合all_squash使用

示例：`/data/nfsdir1   192.168.99.0/24(sync,rw,root_squash,all_squash)`


## NFS配置示例
注意`[101]$`开头是主机 192.168.99.101，`[102]$`开头的是主机192.168.99.102
1. 修改配置
```sh
[101]$ cat /etc/exports
/data/nfsdir1 *(rw)
```

2. 加载生效并查看
```sh
[101]$ exportfs -r
#查看条目
[101]$ exportfs -v
/data/nfsdir1   <world>(sync,wdelay,hide,no_subtree_check,sec=sys,rw,secure,root_squash,no_all_squash)
```

3. 用102这台主机挂载下
```sh
[102]$ mkdir /mnt/nfs1
[102]$ mount 192.168.99.101:/data/nfsdir1 /mnt/nfs1
[102]$ df
Filesystem                   1K-blocks    Used Available Use% Mounted on
... ...
192.168.99.101:/data/nfsdir1   5232640  341696   4890944   7% /mnt/nfs1
```

4. 挂载创建个文件，结果发现权限不足
```sh
[102]$ touch 102
touch: cannot touch ‘102’: Permission denied
```

5. 回到101，给这个目录设置FACL
```sh
[101]$ setfacl -m u:nfsnobody:rwx nfsdir1
```

6. 可以看到，所创建的帐号是nfsnobody的
```sh
[102]$ cd /mnt/nfs1 ; touch 102
[102]$ ll
total 4
-rw-r--r-- 1 nfsnobody nfsnobody 0 Jul 27 17:31 102
```

7. 其它是把102主机上的root的映射成了nfsnobody帐号了。这是因为在`exportfs -v`的输出中，有这么一句话"root_squash"，其它主机的root帐号会被压榨权限，压成nfsnobody
```sh
[101]$ exportfs -v
/data/nfsdir1   <world>(sync,wdelay,hide,no_subtree_check,sec=sys,rw,secure,root_squash,no_all_squash)
```
8. 那如果是其它帐号呢，来试试 
```sh
[102]$ su wang

[wang@localhost nfs1]$ touch wang.file
touch: cannot touch ‘wang.file’: Permission denied
[wang@localhost nfs1]$
```
9. 权限不足，这是因为wang帐号的id=1001，无法映射成nfsnobody，只有id=0的root帐号才能映射成nfsnobody，那如果想把所有的帐号都映射成nfsnobody呢？这样做
```sh
[101]$ vim /etc/exports
    /data/nfsdir1 *(rw,all_squash)
[101]$ exportfs -r
```

10. 这样就可以了，所创建的帐号就会被映射成nfsnobody了
```sh
[102]$ su wang

[wang@localhost nfs1]$ touch wang.file
[wang@localhost nfs1]$ ll
-rw-rw-r-- 1 nfsnobody nfsnobody 0 Jul 27 17:45 wang.file
```

11. 那能不能映射成其它帐号呢？
```sh
#一会我们就映射成test1这个帐号
[101]$ useradd test1
#注意，id=1001
[101]$ id test1
uid=1001(test1) gid=1001(test1) groups=1001(test1)

#修改配置
[101]$ cat /etc/exports
    /data/nfsdir1 *(rw,all_squash,anonuid=1001,anongid=1001)
#加载
[101]$ exportfs -r

#设置FACL
[101]$ setfacl -m u:test1:rwx nfsdir1
```

来102试试，为什么显示1001呢，因为102主机上没有id=1001的帐号
```sh
#root帐号
[102]$ touch root1
[102]$ ll
-rw-r--r-- 1      1001      1001 0 Jul 27 17:53 root1

#用wang
[102]$ su wang
[wang@localhost nfs1]$ touch wang2
[wang@localhost nfs1]$ ll
-rw-r--r-- 1      1001      1001 0 Jul 27 17:53 root1
-rw-rw-r-- 1      1001      1001 0 Jul 27 17:54 wang2
```




## NFS其它配置示例
1. 在/etc/exports文件中定义导出目录
```sh
/myshare server.example.com
/myshare *.example.com
/myshare server?.example.com
/myshare server[0-20].example.com
/myshare 172.25.11.10
/myshare 172.25.0.0/16
/myshare 2000:472:18:b51:c32:a21
/myshare 2000:472:18:b51::/64
/myshare *.example.com 172.25.0.0/16
/myshare desktop.example.com(ro)
/myshare desktop.example.com(ro) server[0-20].example.com(rw)
/myshare diskless.example.com(rw,no_root_squash)
```

## NFS工具
1. rpcinfo
```sh
rpcinfo -p hostname
rpcinfo –s hostname   #查看RPC注册程序
```

2. exportfs [OPTIONS]

[OPTIONS] | 说明
- | - 
–v |查看本机所有NFS共享
–r |重读配置文件，并共享目录
–a |输出本机所有共享
–au |停止本机所有共享

3. showmount -e 192.168.99.101  查看某个主机上的NFS
4. mount.nfs 挂载工具

## 客户端NFS挂载
NFS相关的挂载选项：`man 5 nfs`
1. `fg`（默认）前台挂载 | `bg`后台挂载
3. `hard`（默认）持续请求 | `soft` 非持续请求
3. `intr` 和`hard`配合，请求可中断
4. `rsize`和`wsize` 一次读和写数据最大字节数，rsize=32768
5. `_netdev` 无网络不挂载

>基于安全考虑，建议使用nosuid,nodev,noexec挂载选项

示例：
```sh
mount -o rw,nosuid,fg,hard,intr 172.16.0.1:/testdir /mnt/nfs/
```
开机挂载:
```sh
[101]$ cat /etc/fstab 
    172.16.0.1:/public /mnt/nfs nfs defaults 0 0
```