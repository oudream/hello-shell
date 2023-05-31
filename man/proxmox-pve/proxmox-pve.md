
### Proxmox VE 中文手册 v7.3（不断更新）
- https://pve-doc-cn.readthedocs.io/zh_CN/latest/index.html
### cmd commands
- https://pve.proxmox.com/pve-docs/
### ESXi、PVE、unRaid这三大虚拟系统 
- https://www.proxmox.com/en/

### kill pve
```shell
ps -ef|grep "/usr/bin/kvm -id 100" |grep -v grep
```

### 关闭 Proxmox 数据中心的防火墙
```shell
pvecm fwdisable <datacenter>
pvesh get /datacenters

```

### 静态IP 固定IP static ip
```shell
vim.tiny /etc/network/interfaces
```
```text
auto lo
iface lo inet loopback

iface eno1 inet manual

auto eno2
iface eno2 inet static
    address 14.21.56.4
    netmask 255.255.255.224
    gateway 14.21.56.1
    dns-nameservers 202.96.128.86 202.96.134.133

iface eno2 inet manual

auto vmbr0
iface vmbr0 inet static
        address 10.50.53.206/23
        gateway 10.50.52.1
        bridge-ports eno1
        bridge-stp off
        bridge-fd 0
```
```shell
systemctl restart networking.service
```