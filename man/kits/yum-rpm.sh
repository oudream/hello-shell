#!/usr/bin/env bash


yum list installed | grep docker

yum	[options] [command] [package ...]
	repolist [all | enabled | disabled] 列出仓库列表
	clean all 清空缓存
	makecache 构建缓存
	list {available|installed|updates} 显示程序包
		available 只显示未安装的包
		installed 只显示已安装的，@anaconda表示安装操作系统时安装的包
		          installed表示手工通过rpm、yum安装的包
		updates   只显示可更新的包
	install package1 [package2] [...]   安装软件包
	reinstall package1 [package2] [...] 重新安装
	update [package1] [package2] [...]  升级安装包
	downgrade package1 [package2] [...] 降级
	check-update                        检查可用升级
	remove package1 [package2] [...]    卸载安装包
	info                                查看程序包信息
	provides [whatprovides]             查看文件来自于哪个rpm包
	search packagename                  以指定的关键字搜索程序包名及summary信息
	deplist packagename                 查询指定的包依赖哪些能力及所提供的包
	history                             参看yum历史事务记录
		undo  n   卸载第n条记录所对应的安装包
		redo  n   重装第n条记录所对应的安装包
	groupinstall group1 [group2] [...]     安装包组
	groupupdate group1 [group2] [...]      更新包组
	groupremove group1 [group2] [...]      卸载包组
	groupinfo group1 [...]		       查看包组信息


### install
yum -y install epel-release
yum -y install htop

yum list installed
