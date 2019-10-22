#!/usr/bin/env bash

# on ubuntu-v18.0.4TLS
# Uninstall old versions
# Older versions of Docker were called docker, docker.io , or docker-engine. If these are installed, uninstall them:

Ou135246Ou

### install docker --- ###

sudo apt-get remove docker docker-engine docker.io containerd runc

sudo apt-get update

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

# Add Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io

# k8s bin
# wget https://storage.googleapis.com/kubernetes-release/release/v1.15.0-rc.1/kubernetes-server-linux-amd64.tar.gz
wget https://storage.googleapis.com/kubernetes-release/release/v1.14.3/kubernetes-server-linux-amd64.tar.gz

echo 'PATH=/fff/kubernetes/server/bin:$PATH' >>/root/.bashrc
source /root/.bashrc

# 关闭 swap 分区
# 如果开启了 swap 分区，kubelet 会启动失败(可以通过将参数 --fail-swap-on 设置为 false 来忽略 swap on)，
#    故需要在每台机器上关闭 swap 分区。同时注释 /etc/fstab 中相应的条目，防止开机自动挂载 swap 分区：
swapon -s # 查
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# 重启机器
shutdown -r 0


### install kubelet kubeadm kubectl --- ###

apt-get update && apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl


### kubeadm init --kubernetes-version=v1.15.0-rc.1
kubeadm init


# Note: This dropin only works with kubeadm and kubelet v1.11+
[Service]
Environment="KUBELET_KUBECONFIG_ARGS=--bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf"
Environment="KUBELET_CONFIG_ARGS=--config=/var/lib/kubelet/config.yaml"
# This is a file that "kubeadm init" and "kubeadm join" generates at runtime, populating the KUBELET_KUBEADM_ARGS variable dynamically
EnvironmentFile=-/var/lib/kubelet/kubeadm-flags.env
# This is a file that the user can use for overrides of the kubelet args as a last resort. Preferably, the user should use
# the .NodeRegistration.KubeletExtraArgs object in the configuration files instead. KUBELET_EXTRA_ARGS should be sourced from this file.
EnvironmentFile=-/etc/sysconfig/kubelet
ExecStart=
ExecStart=/usr/bin/kubelet $KUBELET_KUBECONFIG_ARGS $KUBELET_CONFIG_ARGS $KUBELET_KUBEADM_ARGS $KUBELET_EXTRA_ARGS