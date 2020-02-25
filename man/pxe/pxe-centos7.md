### 1. 准备
- centos7 虚拟机；
- centos7 iso文件；


### 2.配置dnsmasq服务和ipxe基本环境
```bash

# 安装需要的包：
yum install -y ipxe-bootimgs dnsmasq
# 创建目录
mkdir /tftpboot
# 适用于 BIOS 硬件
cp /usr/share/ipxe/undionly.kpxe /tftpboot/
# 适用于 EFI 硬件
cp /usr/share/ipxe/ipxe.efi /tftpboot/

```

### 编写一个boot.ipxe文件
```bash

vi /tftpboot/menu/boot.ipxe

```

### 内容如下：

```bash

#!ipxe
menu PXE Boot Options
item shell iPXE shell
item exit  Exit to BIOS
# 默认选择 exit， 延迟10s
choose --default exit --timeout 10000 option && goto ${option}
# 可以切换到shell
:shell
shell
# 退出
:exit
exit

```

### 修改/etc/dnsmasq.conf配置文件

```bash

# 禁用dns
port=0
 
# 监听地址和网口
listen-address=192.168.72.2
interface=ens38
 
# 启动tftp
enable-tftp
tftp-root=/tftpboot
 
# 随机分配地址或者静态分配地址
#dhcp-range=192.168.72.200,192.168.72.250,255.255.255.0
dhcp-range=192.168.72.200,static,255.255.255.0
 
# 配置引导文件
dhcp-vendorclass=BIOS,PXEClient:Arch:00000
dhcp-match=set:ipxe,175
dhcp-boot=tag:!ipxe,tag:BIOS,undionly.kpxe
dhcp-boot=tag:!ipxe,tag:!BIOS,ipxe.efi
dhcp-boot=tag:ipxe,menu/boot.ipxe

# 自定义mac地址和dhcp客户端
dhcp-host=00:0c:29:55:77:75,192.168.72.202,cn2
dhcp-host=00:0c:29:55:77:74,192.168.72.201,cn1,ignore

```

### 启动服务并重启

```bash

systemctl disable firewalld
systemctl enable dnsmasq
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
reboot

```

### 3. 设置CentOS7网络安装
- 安装httpd服务
```bash

yum -y install httpd
systemctl start httpd
systemctl enable httpd

```

- 挂载iso到http服务上
```bash

mkdir -p /var/www/html/media/centos7
mount -t iso9660 /tmp/CentOS7.iso /var/www/html/media/centos7
# 如果是使用dvd挂载的话：
# mount /dev/sr0 /var/www/html/media/centos7

```

### 修改/tftpboot/menu/boot.ipxe如下
```bash

#!ipxe
:start
menu PXE Boot Options
item shell iPXE shell
item centos7-net CentOS 7 installation
item exit  Exit to BIOS
choose --default centos7-net --timeout 10000 option && goto ${option}
:shell
shell
:centos7-net
set server_root http://192.168.72.2/media/centos7
initrd ${server_root}/images/pxeboot/initrd.img
# 这里没有使用ks文件,如果使用ks自动安装的情况
# kernel ${server_root}/images/pxeboot/vmlinuz inst.ks=${server_root}/centos7.ks ip=dhcp ipv6.disable initrd=initrd.img
kernel ${server_root}/images/pxeboot/vmlinuz inst.repo=${server_root}/ ip=dhcp ipv6.disable initrd=initrd.img inst.geoloc=0 devfs=nomount
boot
:exit
exit

```
 
- 重启网络安装即可。

### 4. 其他
下面有两个简单的kickstart文件：

[Centos7.6](./centos7.ks)
[RHEL8.0](./rhel8.ks)