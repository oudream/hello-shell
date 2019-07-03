#!/usr/bin/env bash

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


## apt-get , apt
# apt-get是一条linux命令，适用于deb包管理式的操作系统，主要用于自动从互联网的软件仓库中搜索、安装、升级、卸载软件或操作系统。
apt-get update # 升级安装包相关的命令,刷新可安装的软件列表(但是不做任何实际的安装动作)
apt-get upgrade # 进行安装包的更新(软件版本的升级)
apt-get dist-upgrade # 进行系统版本的升级(Ubuntu版本的升级)；如果系统提示某些软件包会被“保留”而不能被升级，则可以用 apt-get dist-upgrade 命令来升级所有软件包：
do-release-upgrade # Ubuntu官方推荐的系统升级方式,若加参数-d还可以升级到开发版本,但会不稳定
apt-get install [软件名称] # 安装一个新软件包
apt-get remove [软件名称] # 卸载一个已安装的软件包（保留配置文档）
apt-get remove --purge [软件名称] # 卸载一个已安装的软件包（删除配置文档）
apt-get autoremove [软件名称] # 删除包及其依赖的软件包
apt-get autoremove --purge [软件名称] # 删除包及其依赖的软件包+配置文件，比上面的要删除的彻底一点
dpkg --force-all --purge [软件名称] # 有些软件很难卸载，而且还阻止了别的软件的应用，就能够用这个，但是有点冒险。


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