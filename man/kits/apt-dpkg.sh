#!/usr/bin/env bash


apt-cache search 键词
apt-cache show 软件包名称


apt-cache
open https://debian-handbook.info/browse/zh-CN/stable/sect.apt-cache.html
# apt-cache 命令可显示 APT 内部数据库里的多种信息。这些信息是从 sources.list 文件内聚集不同来源的缓存。
# 于运行 apt update 运作时产生的。
# apt-cache 命令可以做键词软件包搜索 apt-cache search 键词。
# 也能显示软件包标头的可用版本 apt-cache show 软件包名称。
# 这个命令提供软件包说明、其相依性、维护者名称等。
# apt search、apt show、aptitude search、aptitude show 都以同样方式运作。


wget -qO - https://deb.opera.com/archive.key | sudo apt-key add -
wget -qO - https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -



open https://kubernetes.io/zh/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
apt-get update && apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl



open https://linuxize.com/post/how-to-add-apt-repository-in-ubuntu/
# Let’s say you want to install MongoDB from their official repositories.
# First import the repository public key:
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
# Add the MongoDB repository using the command below.
sudo add-apt-repository 'deb [arch=amd64] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse'
# The repository will be appended to sources.list file.
sudo apt install mongodb-org
# If for any reasons you want to remove a previously enabled repository, use the --remove option:
sudo add-apt-repository --remove 'deb [arch=amd64] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse'
#
sudo echo "deb https://download.ceph.com/debian-nautilus/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/ceph.list
#
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

apt-add-repository
add-apt-repository



apt-key
# apt-key命令用于管理Debian Linux系统中的软件包密钥。每个发布的deb包，都是通过密钥认证的，apt-key用来管理密钥
apt-key list          #列出已保存在系统中key。
apt-key add keyname   #把下载的key添加到本地trusted数据库中。
apt-key del keyname   #从本地trusted数据库删除key。
apt-key update        #更新本地trusted数据库，删除过期没用的key
#   Keyring of local trusted keys, new keys will be added here. Configuration Item: Dir::Etc::Trusted.
/etc/apt/trusted.gpg
#   File fragments for the trusted keys, additional keyrings can be stored here (by other packages or the
#   administrator). Configuration Item Dir::Etc::TrustedParts.
/etc/apt/trusted.gpg.d/



### 程序
rpm -qa # 查看所有安装的软件包
## dpkg
dpkg -L unixodbc | xargs -I {} cp {} ~/oudream/1 # 列出 unixodbc 并拷贝到目录……
dpkg -i package.deb #安装包
dpkg -r package #删除包
dpkg -P package #删除包（包括配置文件）
dpkg -L package #列出与该包关联的文件
dpkg -l package #显示该包的版本
dpkg --unpack package.deb #解开 deb 包的内容
dpkg -S keyword #搜索所属的包内容
dpkg -l #列出当前已安装的包
dpkg -c package.deb #列出 deb 包的内容
dpkg --configure package #配置包
# example
dpkg -i package #安装包
dpkg -R /usr/local/src #安装一个目录下面所有的软件包
dpkg --unpack package #解开一个包，如果和-R一起使用，参数可以是一个目录
dpkg --configure package #重新配置和释放软件包
dpkg -r package #删除包
dpkg --merge-avail #合并包
dpkg -P #删除包，包括配置文件
dpkg -A package #从软件包里面读取软件的信息
dpkg --update-avail #替代软件包的信息
dpkg --forget-old-unavail #删除Uninstall的软件包信息
dpkg --clear-avail #删除软件包的Avaliable信息
dpkg -C #查找只有部分安装的软件包信息
dpkg --compare-versions ver1 op ver2 #比较同一个包的不同版本之间的差别
dpkg -b directory [filename] #建立一个deb文件
dpkg -c filename #显示一个Deb文件的目录
dpkg -p package #显示包的具体信息
dpkg -S filename-search-pattern #搜索指定包里面的文件（模糊查询）
dpkg -L package #显示一个包安装到系统里面的文件目录信息
dpkg -s package #报告指定包的状态信息
dpkg -l #显示所有已经安装的Deb包，同时显示版本号以及简短说明
dpkg -L python3-dev



## apt, apt-get
# apt, apt-get是一条linux命令，适用于deb包管理式的操作系统，主要用于自动从互联网的软件仓库中搜索、安装、升级、卸载软件或操作系统。
apt update # 升级安装包相关的命令,刷新可安装的软件列表(但是不做任何实际的安装动作)
apt upgrade # 进行安装包的更新(软件版本的升级)
apt dist-upgrade # 进行系统版本的升级(Ubuntu版本的升级)；如果系统提示某些软件包会被“保留”而不能被升级，则可以用 apt dist-upgrade 命令来升级所有软件包：
apt install [软件名称] # 安装一个新软件包
apt remove [软件名称] # 卸载一个已安装的软件包（保留配置文档）
apt remove --purge [软件名称] # 卸载一个已安装的软件包（删除配置文档）
apt autoremove [软件名称] # 删除包及其依赖的软件包
apt autoremove --purge [软件名称] # 删除包及其依赖的软件包+配置文件，比上面的要删除的彻底一点
apt list --installed # 列出所有已经安装的包
dpkg --force-all --purge [软件名称] # 有些软件很难卸载，而且还阻止了别的软件的应用，就能够用这个，但是有点冒险。
do-release-upgrade # Ubuntu官方推荐的系统升级方式,若加参数-d还可以升级到开发版本,但会不稳定
apt list #  list packages based on package names
apt search # search in package descriptions
apt show # show package details
apt install # install packages
apt remove # remove packages
apt autoremove # Remove automatically all unused packages
apt update # update list of available packages
apt upgrade # upgrade the system by installing/upgrading packages
apt full#upgrade # upgrade the system by removing/installing/upgrading packages
apt edit#sources # edit the source information file



add-apt-repository [OPTIONS] REPOSITORY
#   add-apt-repository is a script which adds an external APT repository to either  /etc/apt/sources.list  or  a  file  in
#   /etc/apt/sources.list.d/ or removes an already existing repository.
#
#   The options supported by add-apt-repository are:
   -h, --help           # Show help message and exit
   -m, --massive-debug  # Print a lot of debug information to the command line
   -r, --remove         # Remove the specified repository
   -y, --yes            # Assume yes to all queries
   -u,  --update        # After adding the repository, update the package cache with packages from this repository (avoids need to apt-get update)
   -k, --keyserver      # Use a custom keyserver URL instead of the default
   -s, --enable-source  # Allow downloading of the source packages from the repository



## Snap
## Snap安装软件时候，终端会有白色进度条显示下载百分比，非常的人性。
# 其实基础教程应该在实战之前，不过我觉得实战才是最好的学习方法，所以先写了Snap安装软件的方法。相比你现在都已经学会了几个Snap的基本用法了。
#查询已经安装了的软件
sudo snap list
#搜索要安装的Snap软件包
sudo snap find xxxx
#查看Snap软件的更多信息
sudo snap info xxxx
#安装Snap软件包
sudo snap install xxxx
#更换软件安装通道
sudo snap switch –channel=xxxx xxxx
#更新Snap软件包
sudo snap refresh xxxx
#还原到之前版本
sudo snap revert xxxx
#卸载Snap软件
sudo snap remove xxxx
# 有什么snap软件包呢！
# Uappexplorer
# https://uappexplorer.com/snaps


openjdk-11-jre-headless/now 11.0.4+11-1ubuntu2~18.04.3 amd64 [installed,upgradable to: 11.0.5+10-0ubuntu1.1~18.04]
openjdk-8-jdk-headless/now 8u222-b10-1ubuntu1~18.04.1 amd64 [installed,upgradable to: 8u232-b09-0ubuntu1~18.04.1]
openjdk-8-jre/now 8u222-b10-1ubuntu1~18.04.1 amd64 [installed,upgradable to: 8u232-b09-0ubuntu1~18.04.1]
openjdk-8-jre-headless/