
### 0 step 注意，只能使用单网卡，配置为电信固定IP（使用两张网卡方式，出错）

### 1 step
```text
**1、桥接网卡配置**

编辑网卡文件

nano /etc/network/interfaces

**2、新建虚拟机**

开通独立IP虚拟机的时候桥接网卡选择vmbr0，NAT虚拟机选择vmbr1，如图所示

Debian和Ubuntu中，网络配置文件通常位于/etc/network/interfaces（文件）或/etc/netplan/目录下。
Debian和Ubuntu的网络配置工具是ifup和ifdown命令，用于手动启用或禁用网络接口。
systemctl status networking.service
systemctl restart networking.service

entOS中，网络配置文件通常位于/etc/sysconfig/network-scripts/目录下，一般情况下，以ifcfg-开头，后面跟着网卡名字，比如ifcfg-eth0。
CentOS则使用ifup和ifdown命令，同时也支持nmcli命令行工具来配置NetworkManager。
systemctl restart network
systemctl restart NetworkManager

```

### 3 step
```shell
./portmap6.sh 192.168.11.109 22 14.21.56.4 5022
./portmap6.sh 192.168.11.109 3389 14.21.56.4 3389

```



### Proxmox VE同时配置NAT共享IP和独立IP虚拟机
- https://zhuanlan.zhihu.com/p/352355271
```text

```
