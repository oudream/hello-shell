

ldd app

export LD_LIBRARY_PATH=$PWD

###
ldd --help

# Usage: ldd [OPTION]... FILE...
  --help                  # print this help and exit
  --version               # print version information and exit
  -d, --data-relocs       # process data relocations
  -r, --function-relocs   # process data and function relocations
  -u, --unused            # print unused direct dependencies
  -v, --verbose           # print all information

#  For bug reporting instructions, please see:
#  <http://www.gnu.org/software/libc/bugs.html>.


### arm64 aarch64
# https://stackoverflow.com/questions/6150000/cross-compiler-ldd
arm-none-linux-gnueabi-readelf -a $1 | grep "Shared library:"


###
# https://man.linuxde.net/ldconfig
# https://linux.die.net/man/8/ldconfig
# ldconfig命令编程开发
# ldconfig命令的用途主要是在默认搜寻目录/lib和/usr/lib以及动态库配置文件/etc/ld.so.conf内所列的目录下，
#   搜索出可共享的动态链接库（格式如lib*.so*）,进而创建出动态装入程序(ld.so)所需的连接和缓存文件。缓存文件默认为/etc/ld.so.cache，
#   此文件保存已排好序的动态链接库名字列表，为了让动态链接库为系统所共享，需运行动态链接库的管理命令ldconfig，此执行程序存放在/sbin目录下。
# ldconfig通常在系统启动时运行，而当用户安装了一个新的动态链接库时，就需要手工运行这个命令。
ldconfig -v

ldconfig [-v|--verbose] [-n] [-N] [-X] [-f CONF] [-C CACHE] [-r ROOT] [-l] [-p|--print-cache] [-c FORMAT] [--format=FORMAT] [-V] [-?|--help|--usage] path...
-v # 或--verbose：用此选项时，ldconfig将显示正在扫描的目录及搜索到的动态链接库，还有它所创建的连接的名字。
-n # ：用此选项时,ldconfig仅扫描命令行指定的目录，不扫描默认目录（/lib、/usr/lib），也不扫描配置文件/etc/ld.so.conf所列的目录。
-N # ：此选项指示ldconfig不重建缓存文件（/etc/ld.so.cache），若未用-X选项，ldconfig照常更新文件的连接。
-X # ：此选项指示ldconfig不更新文件的连接，若未用-N选项，则缓存文件正常更新。
-f CONF # ：此选项指定动态链接库的配置文件为CONF，系统默认为/etc/ld.so.conf。
-C CACHE # ：此选项指定生成的缓存文件为CACHE，系统默认的是/etc/ld.so.cache，此文件存放已排好序的可共享的动态链接库的列表。
-r ROOT # ：此选项改变应用程序的根目录为ROOT（是调用chroot函数实现的）。选择此项时，系统默认的配置文件/etc/ld.so.conf，实际对应的为ROOT/etc/ld.so.conf。如用-r /usr/zzz时，打开配置文件/etc/ld.so.conf时，实际打开的是/usr/zzz/etc/ld.so.conf文件。用此选项，可以大大增加动态链接库管理的灵活性。
-l # ：通常情况下,ldconfig搜索动态链接库时将自动建立动态链接库的连接，选择此项时，将进入专家模式，需要手工设置连接，一般用户不用此项。
-p或--print-cache # ：此选项指示ldconfig打印出当前缓存文件所保存的所有共享库的名字。
-c FORMAT 或 --format=FORMAT # ：此选项用于指定缓存文件所使用的格式，共有三种# ：old(老格式)，new(新格式)和compat（兼容格式，此为默认格式）。
-V # ：此选项打印出ldconfig的版本信息，而后退出。
-? 或 --help 或 --usage # ：这三个选项作用相同，都是让ldconfig打印出其帮助信息，而后退出。


nm
# 功能：列出.o、.a、.so中的符号信息，包括符号的值，符号类型及符号名称等。所谓符号，通常指定义出的函数，全局变量等
# 查看静态库或动态库定义了哪些函数
nm -n --defined-only xxxx.a
nm -g -C --defined-only xxxx.so
nm -D xxxx.so

# 显示hello.a 中的未定义符号，需要和其他对象文件进行链接.
nm -u hello.o

# objdump
objdump -tT xxx.so