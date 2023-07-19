#!/usr/bin/env bash

# 有时我们需要RPM包中的某个文件，如何解压RPM包呢？
rpm2cpio xxx.rpm | cpio -div

rpm -ql containerd.io.x86_64
rpm -ql docker-ce.x86_64
rpm -ql docker-ce-cli.x86_64
rpm -ql docker-ce-rootless-extras.x86_64


# 安装 example.rpm 包并在安装过程中显示正在安装的文件信息及安装进度；
rpm -ivh example.rpm
# 卸载 tomcat4 软件包
rpm -e tomcat4
# 查看 tomcat4 是否被安装；
rpm -qa | grep tomcat4
# 列出软件包安装的文件
rpm -ql mysql-shell-8.0.20-1.el7.x86_64
# 查询系统中指定文件所属的软件包
rpm -qf /usr/bin/mysql
#   mysql-community-server-minimal-5.7.30-1.el7.x86_64
# 升级 example.rpm 软件包
rpm -Uvh example.rpm
# RPM 的其他附加命令
--force     # 强制操作 如强制安装删除等；
--requires  # 显示该包的依赖关系；
--nodeps    # 忽略依赖关系并继续操作；


rpm
	-i 安装
		--test 仅测试，不安装
		--nodeps 忽略依赖性
		--replacepkgs 重复安装已安装过的包，文件覆盖
		--replacefiles 将要安装包的部分文件与其他已安装的包文件冲突，可继续安装
		--noscripts：不执行程序包脚本
			%pre: 安装前脚本； --nopre
			%post: 安装后脚本； --nopost
			%preun: 卸载前脚本； --nopreun
			%postun: 卸载后脚本；  --nopostun
		--oldpackage 已装新的，再装旧的
		--force 等同于--replacepkgs  --replacefiles  --oldpackage
	-U 更新 如果装的有旧的，则升级，如果未装旧的，则安装新的。
	-F 更新 如果装的有旧的，则升级，如果未装旧的，不安装新的。
	-v 详细信息
	-vv 更详细信息 *
	-h 显示进度
	-ivh 安装并详细显示进度 ***
	-q 查询
		-qa 查询安装的所有包 ***
			rpm -qa scr*
			rpm -qa |grep ^scr
		-qf 查询指定的文件由哪一个rpm包提供（文件用路径表示） ***
		-qp 指定未安装的rpm包
		-q --provides 软件包名   查看指定的软件包提供了哪些能力
			可以使用-a 显示当前系统中由已安装过的包提供的所有能力
		-q --whatprovides webserver 查看指定的能力由哪一个软件包提供
		-q --whatrequires CAPABILITY 查询指定的CAPABILITY被哪个包所依赖
		-qR 软件包名 查看指定的软件包依赖哪些能力
		-qc 软件包名 查看配置文件
		-qd 软件包名 查看帮助文档
		-ql 软件包名 查看该软件包所提供的所有文件 ***
		-qi 软件包名 查看软件包的信息
		-q --scripts 软件包名 查看软件包的安装脚本
	-V 查看指定包所提供的文件是否发生过改变  ***
			S file Size differs
			M Mode differs (includes permissions and file type)
			5 digest (formerly MD5 sum) differs
			D Device major/minor number mismatch
			L readLink(2) path mismatch
			U User ownership differs
			G Group ownership differs
			T mTime differs
			P capabilities differ
	-K|checksig  rpmfile  检查包的完整性和签名
		--nosignature: 不检查来源合法性
		--nodigest：不检查包完整性

