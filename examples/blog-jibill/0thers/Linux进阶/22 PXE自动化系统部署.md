@[TOC](本意内容)

# anaconda系统安装程序

>Anaconda是Red Hat Enterprise Linux、CentOS、Fedora等操作系统的安装管理程序。它以Python及C语言写成，以图形的PyGTK和文字的python-newt接口写成。它可以用来自动安装配置，使用户能够以最小的监督运行。
Anaconda安装管理程序应用在RHEL，Fedora和其他一些项目，Anaconda提供纯文字模式和GUI模式，用户可以安装在各种各样的系统。

## 安装程序启动过程
先大概看看系统安装的大致流程
1. MBR：isolinux/boot.cat
2. stage2: isolinux/isolinux.bin
3. 配置文件：isolinux/isolinux.cfg
4. 装载根文件系统，并启动anaconda。

+ anaconda默认启动GUI接口
    + 下图界面时按<kbd>Tab</kbd> 键，可以查看内核参数

    <img src="https://img-blog.csdnimg.cn/20190626160647486.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70" width="70%">

    + 按<kbd>Esc</kbd> 键,**进入`boot:`模式**，就是下面这个界面，记住它。
    + 记住这个boot模式，下面经常要说到

    ```bash
    boot: linux text    #以字符界面运行
    或boot：linux ks=http://192.168.88.1/ #指定kickstart文件
    或boot：rescue   #救援模式
    ```
    <img src="https://img-blog.csdnimg.cn/20190626161347610.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70" width="70%">

## anaconda工作过程
也就是anaconda启动会要干什么 
**Anaconda安装系统分成三个阶段：**
1. 安装前配置阶段
    + 安装过程使用的语言
    + 键盘类型
    + 安装目标存储设备
        + Basic Storage：本地磁盘
        + 特殊设备：iSCSI
    + 设定主机名
    + 配置网络接口
    + 时区
    + 管理员密码
    + 设定分区方式及MBR的安装位置
    + 创建一个普通用户
    + 选定要安装的程序包
2. 安装阶段
    + 在目标磁盘创建分区
    + 执行格式化操作等
    + 将选定的程序包安装至目标位置
    + 安装bootloader和initramfs
3. 图形模式首次启动
    iptables，selinux，core dump

>到了anaconda这个步骤，也是就系统就开始安装了。相信你是已经安装了无数次的linux系统了，在安装系统的时候我们需要各种点点点，其实也就是上面的过程罢了，事实上，上面所提到的内容，其实都写在了kickstart配置文件里面了(下称ks)，把kickstart文件写好了给他，我们就不需要点点点，实现自动化安装系统。

### 手动指定安装源
在安装的时候我们就需要各种rpm包，那这些rpm包是从哪来的呢，如果你是光盘引导的，那么默认就从光盘来的，但是我们也可以不用光盘源，可以自己指定安装源，即你的rpm包从哪得到。
+ 如果想手动指定安装源，在boot模式下：
boot: `linux askmethod`
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190629093734662.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

+ 然后系统就进入安装阶段，到这步的时候就会让你输入安装源了，

![在这里插入图片描述](https://img-blog.csdnimg.cn/2019062909364741.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

+ 你可以这么指定在Centos 6上

```bash
#DVD drive 
repo=cdrom :device
#Hard Drive 
repo=hd:device/path
#HTTP[s] Server 
repo=http[s]://host/path
#FTP Server 
repo=ftp://username:password@host/path
#NFS Server 
repo=nfs:server:/path
#ISO images on an NFS Server 
repo=nfsiso:server:/path
```

+ 也可以这么指定在Centos 7上

```bash
#Any CD/DVD drive 
inst.repo=cdrom
#Hard Drive 
inst.repo=hd:device:/path
#HTTP[s] Server 
inst.repo=http[s]://host/path
#FTP Server 
inst.repo=ftp://username:password@host/path
#NFS Server 
inst.repo=nfs:[options:]server:/path
```

### 手动指定kickstart文件
+ anaconda的安装方式：
(1) 交互式配置方式：这个模式就是我们普通安装时候的模式了，需要一步一步自己选择
(2) 读`kickstart`配置文件自动完成配置：指定ks文件，就可以不用点点点了

可以这么做：在boot模式下，`linux ks=...`（看下面）
指明kickstart文件的位置

```bash
#DVD drive: 
ks=cdrom:/PATH/TO/KICKSTART_FILE
#Hard drive: 
ks=hd:device:/directory/KICKSTART_FILE
#HTTP server: 
ks=http://host:port/path/to/KICKSTART_FILE
#FTP server: 
ks=ftp://host:port/path/to/KICKSTART_FILE
#HTTPS server: 
ks=https://host:port/path/to/KICKSTART_FILE
#NFS server: 
ks=nfs:host:/path/to/KICKSTART_FILE
```

+ 与网络相关的引导选项：如果你没有DHCP服务的话，你可能需要下面这些选项
ip=IPADDR
netmask=MASK
gateway=GW
dns=DNS_SERVER_IP
ifname=NAME:MAC_ADDR

+ 启动紧急救援模式，也得在boot模式下：
boot: linux rescue

### kickstart配置文件
+ ks文件非常重要，我们创建完kickstart文件后，就像上面那样去指定ks文件：`boot: linux ks=url...`。
+ 包括下面要说的PXE自动化安装、cobbler自动化安装等都会用到。
+ 那kickstart又该怎么编写呢，跳转：[一步一步_kickstart配置文件详解]()

## 制作引导光盘和U盘
+  系统光盘中isolinux目录列表
    1. `solinux.bin`：光盘引导程序，在mkisofs的选项中需要明确给出文件路径，这个文件属于SYSLINUX项目
    2. `isolinux.cfg`：isolinux.bin的配置文件，当光盘启动后（即运行isolinux.bin），会自动去找isolinux.cfg文件
    3. `vesamenu.c32`：是光盘启动后的安装图形界面，也属于SYSLINUX项目，menu.c32版本是纯文本的菜单
    4. `Memtest`：内存检测，这是一个独立的程序
    5. `splash.jgp`：光盘启动界面的背景图
    6. `vmlinuz`是内核映像
    7. `initrd.img`是ramfs (先cpio，再gzip压缩)

**下面就来制作引导光盘和U盘**
这个平时也用得少
1. 创建引导光盘：

```bash
> mkdir –p /app/myiso
> cp -r /misc/cd/isolinux/ /app/myiso/
> vim /app/myiso/isolinux/isolinux.cfg
    initrd=initrd.img text ks=cdrom:/myks.cfg
> cp /root/myks.cfg /app/myiso/
> mkisofs -R -J -T -v --no-emul-boot --boot-load-size 4 --boot-info-table -V "CentOS 6.9 x86_64 boot" -b isolinux/isolinux.bin -c isolinux/boot.cat -o /root/boot.iso /app/myiso/
```
注意：以上相对路径都是相对于光盘的根，和工作目录无关

2. 创建U盘启动盘
dd if=/dev/sr0 of=/dev/sdb

3. 命令：mkisofs

[OPTION]| 意义
-|-
`-o `|指定映像文件的名称。
`-b `|指定在制作可开机光盘时所需的开机映像文件。
`-c `|制作可开机光盘时，会将开机映像文件中的 no-eltorito-catalog 全部内容作成一个文件。
`-no-emul-boot `|非模拟模式启动。
`-boot-load-size 4 `|设置载入部分的数量
`-boot-info-table `|在启动的图像中现实信息
`-R 或 -rock `|使用 Rock RidgeExtensions
`-J 或 -joliet `|使用 Joliet 格式的目录与文件名称
`-v 或 -verbose `|执行时显示详细的信息
`-T 或 -translation-table `|建立文件名的转换表，适用于不支持 Rock Ridge Extensions 的系统上

# DHCP服务
>DHCP: （Dynamic Host Configuration Protocol）动态主机配置协议
局域网协议；UDP协议

+ 主要用途：
    1. 用于内部网络和网络服务供应商自动分配IP地址给用户
    2. 用于内部网络管理员作为对所有电脑作集中管理的手段
+ 使用场景
    1. 自动化安装系统
    2. 合理分配IP地址

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190620205826308.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)
+ DHCP报文
客户端---DISCOVER--->服务器
客户端<---OFFER---服务器
客户端---REQUES--->服务器
客户端<---ACK---服务器
**以上是获取IP的过程；**
客户端<---NAK---服务器：通知用户无法分配合适的IP地址
客户端---DECLINE--->服务器：指示地址已被使用
客户端---RELEASE--->服务器：放弃网络地址和取消剩余的租约时间
客户端---INFORM--->服务器：客户端如果需要从DHCP服务器端获取更为详细的配置信息，则发送nform报文向服务器进行请求，极少用到

+ 续租
`50% `：租赁时间达到50%时来续租，刚向DHCP服务器发向新的DHCPREQUEST请求。如果dhcp服务没有拒绝的理由，则回应DHCPACK信息。当DHCP客户端收到该应答信息后，就重新开始新的租用周期
`87.5%`：如果之前DHCP Server没有回应续租请求，等到租约期的7/8时，主机以广播形式发送请求。
 

+ DHCP服务必须基于LAN，先到先得的原则


## DHCP实现
1. 先安装dhcp
```bash
yum -y install dhcp
```

配置文件可以查看帮助：`man 5 dhcpd.conf`
2. 配置文件`/etc/dhcp/dhcpd.conf`。一开始是空的配置文件，要自己写，如果不想写，可以cp模板文件来修改。 
```bash
[root@Magedu ~]$ cp /usr/share/doc/dhcp-4.2.5/dhcpd.conf.example /etc/dhcp/dhcpd.conf

[root@Magedu ~]$ vim /etc/dhcp/dhcpd.conf
#其中全局语句块和subnet语句块均可使配置生效，subnet语句块优先级高于全局语句块：
#全局语句块：
# option definitions common to all supported networks...
#指定获取主机域后缀：
option domaim-name "wxlinux.com"
#指定DNS，可选
option domain-name-servers 114.114.114.114,8.8.8.8
#结合生产环境，ip越充足，租期越大越好
default-least-time 86400
#最大租期时间.
max-lease-time 100000
#subnet语句块：
# This is a very basic subnet declaration.
subnet 192.168.88.0 netmask 255.255.255.0 {
#指定ip地址范围
range 192.168.88.100 192.168.88.200;
#指定网关
option routers 192.168.88.1;
# 指明引导文件名称
filename "pxelinux.0";
#提供引导文件的服务器IP地址
next-server 192.168.1.100;
}
```
检查配置文件语法：service dhcpd configtest

+ 地址分配记录
`/var/lib/dhcpd/dhcpd.leases`

+ Linux DHCP协议的实现程序：dhcp, dnsmasq（dhcp,dns）

+ 命令：dhclient
自动获取的IP信息： /var/lib/dhclient



- - - 

# TFTP服务
>TFTP：Trivial File Transfer Protocol ，是一种用于传输文件的简单高级协议，是文件传输协议（FTP）的简化版本。用来传输比文件传输协议（FTP）更易于使用但功能较少的文件。端口69

## FTP和TFTP的区别
1. 安全性区别
    + FTP支持登录安全，具有适当的身份验证和加密协议，在建立连接期间需要与FTP身份验证通信
    + TFTP是一种开放协议，缺乏安全性，没有加密机制，与TFTP通信时不需要认证
2. 传输层协议的区别
    + FTP使用TCP作为传输层协议
    + TFTP使用UDP作为传输层协议
3. 使用端口的区别
    + FTP使用2个端口：TCP端口21，是个侦听端口；TCP端口20或更高TCP端口1024以上用于源连接
    + TFTP仅使用一个具有停止和等待模式的端口：端口69/udp
4. RFC的区别
    + FTP是基于RFC 959文档，带有其他RFC涵盖安全措施；
    + TFTP基于RFC 1350文档
5. 执行命令的区别
    + FTP有许多可以执行的命令（get，put，ls，dir，lcd）并且可以列出目录等
    + TFTP只有5个指令可以执行（rrq，wrq，data，ack，error）

**CentOS 7安装与启动服务**
```bash
yum install tftp
systemctl start tftp
systemctl enable tftp
#安装完毕后，你的主目录就在`/var/lib/tftpboot/`下。

[root]$ tftp 192.168.99.10
tftp> get menu.c32
tftp> 

#上面这个例子就是获取你TFTP服务器下/var/lib/tftpboot/下的文件。前题是你要先知道有什么文件。
```

**CentOS 6安装与启动服务**
```bash
yum install tftp
#xinetd代替了tftp监听端口，所以把xinetd启动就可以了
chkconfig tftp on
chkconfig xinetd on
service xinetd start
#可以看到69端口已经在监听了
[root@localhost init.d]# ss -uapn
State      Recv-Q Send-Q            Local Address:Port              Peer Address:Port
UNCONN     0      0                             *:69                           *:*      users:(("xinetd",24971,5))
UNCONN     0      0                             *:69                           *:*      users:(("xinetd",24904,5))
```
- - -

# PXE介绍
+ PXE：

>Intel公司研发的“Preboot Excution Environment”预启动执行环境
>基于Client/Server的网络模式，支持远程主机通过网络从远端服务器下载映像，并由此支持通过网络启动操作系统

PXE可以引导和安装Windows,linux等多种操作系统

## PXE工作原理
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190629102714765.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)


1. Client向PXE Server上的DHCP发送IP地址请求消息，DHCP检测Client是否合法（主要是检测Client的网卡MAC地址），如果合法则返回Client的IP地址，同时将启动文件pxelinux.0的位置信息一并传送给Client
2. Client向PXE Server上的TFTP发送获取pxelinux.0请求消息，TFTP接收到消息之后再向Client发送pxelinux.0大小信息，试探Client是否满意，当TFTP收到Client发回的同意大小信息之后，正式向Client发送pxelinux.0
3. Client执行接收到的pxelinux.0文件
4. Client向TFTP Server发送针对本机的配置信息文件（在TFTP 服务的pxelinux.cfg目录下），TFTP将配置文件发回Client，继而Client根据配置文件执行后续操作。
5. Client向TFTP发送Linux内核请求信息，TFTP接收到消息之后将内核文件发送给Client
6. Client向TFTP发送根文件请求信息，TFTP接收到消息之后返回Linux根文件系统
7. Client启动Linux内核
8. Client向HTTP下载安装源文件，读取自动化安装脚本


## 实验：PXE自动化安装CentOS 7
1. 安装前准备：关闭防火墙和SELINUX，DHCP服务器静态IP
2. 安装软件包
3. 配置文件共享服务(http服务)
4. 准备kickstart文件
5. 配置tftp服务
6. 配置DHCP服务
7. 准备相关文件
8. 准备启动菜单


**下面就是详细的步骤了：**
> host A ---也就是HTTP/TFTP/DHCP服务器了
0. 在开始之前，先把虚拟机的DHCP服务关了。我这里用的是NAT模式，那我就把NAT模式的DHCP关了。**因为下面我会配置DHCP，不然会冲突的**
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190628210633929.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

1. 安装前准备：关闭防火墙和SELINUX，DHCP服务器静态IP。这个就不用多说了吧
2. 安装软件包
```bash
yum -y install httpd system-config-kickstart tftp-server dhcp syslinux 
```
3. 配置文件共享服务(http服务)
这一步是作为系统安装的安装源而提供服务的。
```bash
systemctl enable httpd
systemctl start httpd
mkdir /var/www/html/centos/7
mount /dev/sr0 /var/www/html/centos/7
```
4. 准备kickstart文件
由于篇幅较长，放到了另一个博客来讲：[ 一步一步_kickstart详解]()
注意：生成后的ks文件复制到http目录下备用：
```bash
[root]$ cp 你的ks文件 /var/www/html/ks/ks7.cfg
#注意权限
[root]$ chmod +r /var/www/html/ks/ks7.cfg
```

5. 配置tftp服务
```bash
systemctl enable tftp.socket
systemctl start tftp.socket
```

6. 来配置DHCP服务(port:67)了
```bash
[root]$ vim /etc/dhcp/dhcpd.conf
option domain-name "example.com";
default-lease-time 60000;
max-lease-time 720000;
subnet 192.168.88.0 netmask 255.255.255.0 {
range 192.168.88.1 192.168.88.200;
filename "pxelinux.0";
next-server 192.168.88.2;
}
[root]$ systemctl enable dhcpd
[root]$ systemctl start dhcpd
#启动失败那就是配置文件写得有问题了
```


7. 准备相关文件
一些引导相关的文件，注意路径
```bash
mkdir /var/lib/tftpboot/pxelinux.cfg/
mkdir /var/lib/tftpboot/centos7
#这个是菜单
cp /usr/share/syslinux/{pxelinux.0,menu.c32} /var/lib/tftpboot/
#下面拷贝的是光盘的内容`/misc/cd`就是你挂载光盘的路径，别直接复制哦
cp /misc/cd/isolinux/{vmlinuz,initrd.img} /var/lib/tftpboot/centos7/
cp /misc/cd/isolinux/isolinux.cfg /var/lib/tftpboot/pxelinux.cfg/default

#文件列表如下：
[root]$ tree /var/lib/tftpboot/
├── centos7
│   ├── initrd.img
│   └── vmlinuz
├── menu.c32
├── pxelinux.0
└── pxelinux.cfg
    └── default
```

8. 准备启动菜单
`/var/lib/tftpboot/pxelinux.cfg/default`
```bash
[root]$ Vim /var/lib/tftpboot/pxelinux.cfg/default
default menu.c32
timeout 600
#菜单标题
menu title PXE INSTALL MENU
#下面每一个label都是一个选项
label auto7
menu label Auto Install CentOS 7
kernel vmlinuz
append initrd=initrd.img ks=http://192.168.88.2/ks/ks7.cfg

label manual
menu label Manual Install CentOS 7
kernel vmlinuz
append initrd=initrd.img inst.repo=http://192.168.88.2/centos/7

label local
menu default
menu label ^Boot from local drive
localboot 0xffff
```

9. 可以了，搞一个不带光盘的虚拟机，就可以通过网络来安装了。不过默认是本地启动，还要自己手动选一下。另外，这里强调2个点：
**（1）内存：一定要大于1.5G。一定要大于1.5G。一定要大于1.5G**
**（2）hostA中DHCP分配的哪个网络，就要用哪个网络来启动。比如你用NAT模式做的DHCP，安装系统时也要接NAT模式。**
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190628210938273.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

到这里就是获取到了IP，也从TFTP服务器获取到了菜单，后来就可以选`auto Install Centos 7`就可以开始安装了。

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190628211152332.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

出现了`RTNETLINK answers: File exists`。这个问题，我说啥来的，一定要大于1.5G的内存，否则就起不。

## 实验：PXE自动化安装CentOS 6
1. 安装centos 6和7大同小异，关闭防火墙和SELINUX，DHCP服务器配置静态IP
2. 准备Yum 源和相关目录

```bash
yum -y install httpd system-config-kickstart tftp-server dhcp syslinux 
# 这个目录是为了可以做HTTP的yum源的
mkdir -pv /var/www/html/centos/{6,ks}
mount /dev/sr0 /var/www/html/centos/6
# df看一下挂载下去了没，注意挂载你的centos6的光盘
[root@localhost yum.repos.d]# df
Filesystem     1K-blocks    Used Available Use% Mounted on
...
/dev/sr0         3897932 3897932         0 100% /var/www/html/centos/6
```

3. 准备kickstart文件
跟上面一样，放到了另一个博客来讲：[ 一步一步_kickstart详解]()
注意：生成后的ks文件复制到http目录下备用：
```bash
#把你生成的ks文件放到HTTP服务器下，
[root]$ cp 你的ks文件 /var/www/html/ks/ks6.cfg
#注意权限，否则安装的过程中应付报错
[root]$ chmod +r /var/www/html/ks/ks6.cfg
```

4. 配置tftp服务（port:69）
```bash
#xinetd代替了tftp监听端口，所以把xinetd启动就可以了
chkconfig tftp on
chkconfig xinetd on
service xinetd start
#可以看到69端口已经在监听了
[root@localhost init.d]# ss -uapn
State      Recv-Q Send-Q            Local Address:Port              Peer Address:Port
UNCONN     0      0                             *:69                           *:*      users:(("xinetd",24971,5))
UNCONN     0      0                             *:69                           *:*      users:(("xinetd",24904,5))
```

5. 配置dhcp服务
```bash
[root]$ cp /usr/share/doc/dhcp-4.1.1/dhcpd.conf.sample /etc/dhcp/dhcpd.conf
[root]$ vim /etc/dhcp/dhcpd.conf
7 option domain-name "magedu.com";
8 option domain-name-servers 192.168.100.1;
...
subnet 192.168.100.0 netmask 255.255.255.0 {
range 192.168.100.1 192.168.100.200;
option routers 192.168.100.1;
filename "pxelinux.0";
next-server 192.168.100.100;
}
[root]$ service dhcpd start
#启动失败那就是配置文件写得有问题了
可以先用`service dhcpd configtest`检查下
```


6. 准备相关的启动文件
```bash
[root]$ mkdir /var/lib/tftpboot/pxelinux.cfg/
[root]$ cp /usr/share/syslinux/pxelinux.0 /var/lib/tftpboot/
[root]$ cp /misc/cd/images/pxeboot/{vmlinuz,initrd.img} /var/lib/tftpboot
[root]$ cp /misc/cd/isolinux/{boot.msg,vesamenu.c32,splash.jpg} /var/lib/tftpboot
[root]$ cp /misc/cd/isolinux/isolinux.cfg /var/lib/tftpboot/pxelinux.cfg/default
```

7. 准备启动菜单文件
```bash
[root]$ vim /var/lib/tftpboot/pxelinux.cfg/default
default vesamenu.c32 指定菜单风格
#prompt 1
timeout 600
display boot.msg
menu background splash.jpg
menu title Welcome to wang CentOS 6
menu color border 0 #ffffffff #00000000
menu color sel 7 #ffffffff #ff000000
menu color title 0 #ffffffff #00000000
menu color tabmsg 0 #ffffffff #00000000
menu color unsel 0 #ffffffff #00000000
menu color hotsel 0 #ff000000 #ffffffff
menu color hotkey 7 #ffffffff #ff000000
menu color scrollbar 0 #ffffffff #00000000
label auto
menu label ^Automatic Install Centos6
kernel vmlinuz
append initrd=initrd.img ks=http://192.168.99.101/ks/ks6.cfg
#注意你这里的KS文件，就是上面复制到HTTP服务器的那个
label local
menu default
menu label Boot from ^local drive
localboot 0xffff

#目录结构如下：
> tree /var/lib/tftpboot/
/var/lib/tftpboot/
├── boot.msg
├── initrd.img
├── pxelinux.0
├── pxelinux.cfg
│   └── default
├── splash.jpg
├── vesamenu.c32
└── vmlinuz
```

8. 搞定。开始来安装系统吧。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190629091339301.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

# cobbler

cobbler放到了单独的一篇：[一步一步_cobbler自动化部署详解]()