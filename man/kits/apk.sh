#!/usr/bin/env bash

apk add --update alpine-sdk
apk add libffi-dev openssl-dev
apk add cmake git openssh-server vim gdb gdbserver
apk add unixodbc-dev
apk add unixodbc libuuid
apk add nodejs
apk add python3
# qt
#apk add build-essential
apk add qt5-qtbase-dev qt5-qtsvg-dev
apk add qt5-qtbase qt5-qtsvg


RUN apk update && apk add --virtual build-dependencies build-base gcc g++ wget git

RUN apt-get update -y ; apt-get upgrade -y && \
    apt-get install -y apt-utils wget openssh-server telnet vim passwd ifstat unzip iftop htop telnet git \
    samba net-tools lsof rsync gcc g++ cmake build-essential gdb gdbserver \
    unixodbc unixodbc-dev libcurl4-openssl-dev uuid uuid-dev \
    qt5-default libqt5svg5 libqt5svg5-dev qtcreator


add	Add new packages or upgrade packages to the running system
del	Delete packages from the running system
fix	Attempt to repair or upgrade an installed package
update	Update the index of available packages
info	Prints information about installed or available packages
search	Search for packages or descriptions with wildcard patterns
upgrade	Upgrade the currently installed packages
cache	Maintenance operations for locally cached package repository
version	Compare version differences between installed and available packages
index	create a repository index from a list of packages
fetch	download (but not install) packages
audit	List changes to the file system from pristine package install state
verify	Verify a package signature
dot	Create a graphviz graph description for a given package
policy	Display the repository that updates a given package, plus repositories that also offer the package
stats	Display statistics, including number of packages installed and available, number of directories and files, etc.
manifest	Display checksums for files contained in a given package

apk add xxx
apk search xxx # 支持正则
apk info xxx # 查看包的详细信息
apk show # list local package
# 卸载并删除 包
apk del openssh openntp vim

# upgrade命令升级系统已安装的所以软件包（一般包括内核），当然也可指定仅升级部分软件包（通过-u或–upgrade选择指定）。

apk update # 更新最新本地镜像源
apk upgrade # 升级软件
apk add --upgrade busybox # 指定升级部分软件包
# 搜索
apk search # 查找所以可用软件包
apk search -v # 查找所以可用软件包及其描述内容
apk search -v 'acf*' # 通过软件包名称查找软件包
apk search -v -d 'docker' # 通过描述文件查找特定的软件包
# 查看包信息
# info命令用于显示软件包的信息。
apk info # 列出所有已安装的软件包
apk info -a zlib # 显示完整的软件包信息
apk info --who-owns /sbin/lbu # 显示指定文件属于的包