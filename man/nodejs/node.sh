#!/usr/bin/env bash



### install special version node use apt
# Then for the Latest release (version 12), add this PPA..
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
# For (version 11), run the commands below:
curl -sL https://deb.nodesource.com/setup_11.x | bash -
# To install the LTS release (version 10), use this PPA
curl -sL https://deb.nodesource.com/setup_10.x | bash -
sudo apt install nodejs
node -v
npm -v

### centos
sudo yum uninstall -y nodejs
# 清理yum源缓存并选择最快的源重新生成缓存：
curl -sL https://rpm.nodesource.com/setup_10.x | bash -
sudo yum clean all && sudo yum makecache fast
# 安装编译环境：
sudo yum install -y gcc-c++ make
sudo yum install -y nodejs
node -v


### on linux, debian, ubuntu
sudo apt update
sudo apt install nodejs
# or
NODE_VERSION=v12.16.0
NODE_DISTRO=linux-x64
wget https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz
sudo mkdir -p /usr/local/lib/nodejs
sudo tar -xJvf node-${NODE_VERSION}-${NODE_DISTRO}.tar.xz -C /usr/local/lib/nodejs
# Nodejs to .bashrc
export PATH=/usr/local/lib/nodejs/node-${NODE_VERSION}-${NODE_DISTRO}/bin:$PATH
sed -i "$ a export PATH=/usr/local/lib/nodejs/node-${NODE_VERSION}-${NODE_DISTRO}/bin:"'$PATH' ~/.profile


### on AIX
# How to install Node.js via binary archive on AIX
# Install dependencies
# Node requires both libgcc and libstdc++
# you can get them through yum
yum install libgcc
yum install libstdc++
# or you can download the rpm files and install them manually
wget https://public.dhe.ibm.com/aix/freeSoftware/aixtoolbox/RPMS/ppc-6.1/gcc/libgcc-6.3.0-2.aix6.1.ppc.rpm
wget https://public.dhe.ibm.com/aix/freeSoftware/aixtoolbox/RPMS/ppc-6.1/gcc/libstdcplusplus-6.3.0-2.aix6.1.ppc.rpm
rpm -ivh lib*.rpm
Unzip the binary archive to any directory you wanna install Node, this example uses /opt
cd /opt
wget https://nodejs.org/dist/latest-v10.x/node-v10.17.0-aix-ppc64.tar.gz
NODE_VERSION=v10.17.0
NODE_DISTRO=aix-ppc64
sudo gunzip -c node-${NODE_VERSION}-${NODE_DISTRO}.tar.gz | tar -xvf-
edit /etc/profile and add the following to the bottom
 # Nodejs
export PATH=/opt/node-${NODE_VERSION}-${NODE_DISTRO}/bin:$PATH
# Refresh profile
. /etc/profile



npm install --unsafe-perm node-sass

