
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


### 解决 ProXmoX VE升级 apt-get update 报错的问题 （就 2 步） 
- 编辑 /etc/apt/sources.list， 打开后在最下面添加：
```shell
deb http://download.proxmox.com/debian buster pve-no-subscription
```
- 编辑 /etc/apt/sources.list.d/pve-enterprise.list，注释掉： deb https://enterprise.proxmox.com/debian/pve buster pve-enterprise


### 
- 查看虚拟机列表
```shell
qm list
```
- 重启虚拟机
```shell
qm reboot <vmid>
```
- 创建虚拟机
```shell
qm create <vmid> --name <vm_name> --memory <memory_size> --net0 <model=virtio,bridge=vmbr0> --virtio0 <storage_pool:disk_image>
```
- 启动虚拟机
```shell
qm start <vmid>
```
- 停止虚拟机
```shell
qm stop <vmid>
```
- 删除虚拟机
```shell
qm destroy <vmid>
```
- 迁移虚拟机
```shell
qm migrate <vmid> <target_node>
```
- 修改虚拟机磁盘大小
```shell
qm resize <vmid> virtio0 <new_size>
```
- 备份虚拟机
```shell
vzdump
```

### Command Line Interface
- https://pve.proxmox.com/pve-docs/
```shell
ha-manager # High Availability

pct # Proxmox Container Toolkit

pveam # Container Images

pveceph # Deploy Hyper-Converged Ceph Cluster

pvecm # Cluster Manager

pvenode # Proxmox Node Management

pveperf # Proxmox VE Benchmark Script

pvesh # Shell interface for the Proxmox VE API

pvesm # Proxmox VE Storage

pvesr # Storage Replication

pvesubscription # Subscription Management

pveum # User Management

qm # QEMU/KVM Virtual Machines

qmrestore # Restore Virtual Machines

vzdump # Backup and Restore
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


### docker
```shell
apt-get update
apt-get install ca-certificates curl gnupg

install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
  
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin  
```