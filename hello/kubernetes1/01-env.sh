#!/usr/bin/env bash


### hosts

# 172.16.11.1   oudream-ubuntu1
# 172.16.11.130 vm-ubuntu1
# 172.16.11.131 vm-ubuntu2

cat >> /etc/hosts <<EOF
172.16.11.1 oudream-ubuntu1
172.16.11.130 vm-ubuntu1
172.16.11.131 vm-ubuntu2
EOF


### user
# useradd -m docker
# create user docker and append to group docker
useradd -g docker -m docker



### ssh login with no password
ssh-keygen -t rsa
ssh-copy-id root@oudream-ubuntu1
ssh-copy-id root@vm-ubuntu1
ssh-copy-id root@vm-ubuntu2
# cat ~/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys



### install libs
# apt-get install -y conntrack ipvsadm ntp ipset jq iptables curl sysstat libseccomp
apt-get install -y conntrack ipvsadm ntp ipset jq iptables curl sysstat libseccomp2
#ipvs 依赖 ipset；
#ntp 保证各机器系统时间同步；



### close firewalld and clean iptables
sudo systemctl status firewalld
systemctl stop firewalld
systemctl disable firewalld
iptables -F && iptables -X && iptables -F -t nat && iptables -X -t nat
iptables -P FORWARD ACCEPT



# 关闭 swap 分区
# 如果开启了 swap 分区，kubelet 会启动失败(可以通过将参数 --fail-swap-on 设置为 false 来忽略 swap on)，故需要在每台机器上关闭 swap 分区。同时注释 /etc/fstab 中相应的条目，防止开机自动挂载 swap 分区：
swapon -s # 查
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab



# 关闭 SELinux
# 关闭 SELinux，否则后续 K8S 挂载目录时可能报错 Permission denied：
setenforce 0
sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config




# 加载内核模块
modprobe ip_vs_rr
modprobe br_netfilter

# 优化内核参数
cat > kubernetes.conf <<EOF
net.bridge.bridge-nf-call-iptables=1
net.bridge.bridge-nf-call-ip6tables=1
net.ipv4.ip_forward=1
net.ipv4.tcp_tw_recycle=0
vm.swappiness=0 # 禁止使用 swap 空间，只有当系统 OOM 时才允许使用它
vm.overcommit_memory=1 # 不检查物理内存是否够用
vm.panic_on_oom=0 # 开启 OOM
fs.inotify.max_user_instances=8192
fs.inotify.max_user_watches=1048576
fs.file-max=52706963
fs.nr_open=52706963
net.ipv6.conf.all.disable_ipv6=1
net.netfilter.nf_conntrack_max=2310720
EOF
cp kubernetes.conf  /etc/sysctl.d/kubernetes.conf
sysctl -p /etc/sysctl.d/kubernetes.conf

# 必须关闭 tcp_tw_recycle，否则和 NAT 冲突，会导致服务不通；
# 关闭 IPV6，防止触发 docker BUG；


更新 PATH 变量
将可执行文件目录添加到 PATH 环境变量中：

echo 'PATH=/opt/k8s/bin:$PATH' >>/root/.bashrc
source /root/.bashrc