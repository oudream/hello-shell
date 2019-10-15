#!/usr/bin/env bash

# 注意 +x11 与 +quartz
# 注意 +x11 与 +quartz
# 注意 +x11 与 +quartz
# Add this line to /opt/local/etc/macports/variants.conf
# -x11 +quartz

### 以下以 inkscape 下载，编译为例：
sudo port selfupdate
sudo port install \
     cmake cairo boehmgc gettext libxslt lcms2 boost \
     poppler gsl adwaita-icon-theme gdl3 gtkmm3 libsoup \
     double-conversion \
     gtk-osx-application-gtk3 \
     potrace \
     -x11 +quartz

# 注意
# Now go to the directory and open .ssh folder.
# You'll see a file id_rsa.pub. Open it on notepad. Copy all text from it.
# Go to https://gitlab.com/profile/keys .
git clone --recurse-submodules git@gitlab.com:inkscape/inkscape.git

# And build inkscape
# use a clean MacPorts environment (optional)
LIBPREFIX="/opt/local"
export PATH="$LIBPREFIX/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# where to build and install
PREFIX="$PWD/install-prefix"
mkdir build
cd build

cmake \
    -DCMAKE_PREFIX_PATH="$LIBPREFIX" \
    -DCMAKE_INSTALL_PREFIX="$PREFIX" \
    -DWITH_OPENMP=OFF \
    ..

make install



# 注意，查看以下 gtk3 的安装是带 quartz 还是 x11，
sudo port installed gtk3
# 注意，如果是 x11 先卸载，再安装
sudo port uninstall gtk3
sudo port install gtk3 +quartz

sudo port clean gtk3 +11
sudo port selfupdate
sudo port upgrade outdated
sudo port install gtk3 +quartz



### man
# 升级MacPorts:
sudo port selfupdate

# 列出可用ports软件:
sudo port list

# 搜索带有关键词信息的软件列表:
sudo port search soEware_name

# 搜索到软件的具体名字,就可以用info命令查询所需软件信息:
sudo port info soEware_name

# 用deps命令查看软件依赖性:
sudo port deps soEware_name

# 在安装软件前,用variants命令查看本地可用的已安装软件包:
sudo port variants soEware_name

# 安装软件software_name:
sudo port install soEware_name

# clean命令清理安装过程中的缓存文件,在获取软件失败时也可以使用:
sudo port clean --all soEware_name

# 卸载软件
# 9.1. uninstall命令卸载软件:
sudo port uninstall soEware_name

# 9.2. 递归卸载要卸载的软件所依赖的软件包:
sudo port uninstall --follow-dependencies soEware_name
但这一命令不会卸载那些又依赖其他软件包的软件。

# 9.3. 在卸载软件software_name前,先卸载它所依赖的所有ports可以用以下命令:
sudo port uninstall --follow-dependents

# 9.4. 强制卸载软件,忽略依赖性关系。
sudo port -f uninstall

# 除非你很确定这一动作,否则不要乱尝试。
# contents命令可以查看已经安装的port软件
port contents soEware_name

# 查看已安装软件的信息:
# 11.1. 查看软件software_name的版本、变量、使用状态等信息,如果没有指定port名字,则 默认会列出所有已安装ports的信息:
sudo port installed # show all
sudo port installed soEware_name

# 11.2. 用-v选项查看更多的信息,包括平台、CPU架构等信息:
sudo port -v installed soEware_name

# 查看已安装的ports是否有更新,及列出可升级软件列表:
sudo port outdated

# 这里要注意的是,在使用这个命令之前需要使用selfupdate命令更新MacPort本身。
# 使用upgrade命令升级软件:
# 13.1. 升级软件并且同时升级所依赖的软件包:
sudo port upgrade soEware_name

# 13.2. 升级软件,但不升级依赖包:
sudo port -n upgrade soEware_name

# 13.3. 升级所有可升级软件:
sudo port upgrade outdated

# upgrade命令默认会在升级软件的同时继续保留旧版本。如果希望在升级到新版本的同 时卸载老版本,则执行:
sudo port -u upgrade soEware_name

# dependents命令将报告所查询软件的依赖包情况。
sudo port dependents soEware_name

# MacPorts在安装软件时会同时获取软件的依赖树信息,因此在卸载软件时会报告依赖情 况。
# livecheck命令检查软件software_name是否已经被用户通过下载软件包手动安装了:
sudo port livecheck soEware_name

# 如果要获取更多的信息,可以使用debug模式。这对于MacPorts的维护者相当有用。

