# https://archlinux.pkgs.org/rolling/archlinux-community-aarch64/

### 使用导出与PATH设置的方法来交叉编译

### cmake
# https://cmake.org/cmake/help/latest/manual/cmake-toolchains.7.html#cross-compiling-for-linux

### openwrt
- https://openwrt.org/zh/docs/guide-developer/crosscompile


export PATH=$PATH:/opt/openwrt-gcc-8.3.0/bin/

export CC=aarch64-openwrt-linux-musl-gcc
export CXX=aarch64-openwrt-linux-musl-g++
export AR=aarch64-openwrt-linux-musl-ar
export RANLIB=aarch64-openwrt-linux-musl-ranlib
export STAGING_DIR=/opt/openwrt-gcc-8.3.0

#
aarch64-openwrt-linux-musl-addr2line*
aarch64-openwrt-linux-musl-ar*
aarch64-openwrt-linux-musl-as*
aarch64-openwrt-linux-musl-c++*
aarch64-openwrt-linux-musl-c++filt*
aarch64-openwrt-linux-musl-cpp*
aarch64-openwrt-linux-musl-elfedit*
aarch64-openwrt-linux-musl-g++*
aarch64-openwrt-linux-musl-gcc*
aarch64-openwrt-linux-musl-gcc-8.3.0*
aarch64-openwrt-linux-musl-gcc-ar*
aarch64-openwrt-linux-musl-gcc-nm*
aarch64-openwrt-linux-musl-gcc-ranlib*
aarch64-openwrt-linux-musl-gcov*
aarch64-openwrt-linux-musl-gcov-dump*
aarch64-openwrt-linux-musl-gcov-tool*
aarch64-openwrt-linux-musl-gdb*
aarch64-openwrt-linux-musl-gprof*
aarch64-openwrt-linux-musl-ld*
aarch64-openwrt-linux-musl-ld.bfd*
aarch64-openwrt-linux-musl-nm*
aarch64-openwrt-linux-musl-objcopy*
aarch64-openwrt-linux-musl-objdump*
aarch64-openwrt-linux-musl-ranlib*
aarch64-openwrt-linux-musl-readelf*
aarch64-openwrt-linux-musl-size*
aarch64-openwrt-linux-musl-strings*
aarch64-openwrt-linux-musl-strip*


### sqlite
wget https://www.sqlite.org/2021/sqlite-autoconf-3360000.tar.gz
tar zxvf sqlite-autoconf-3360000.tar.gz
cd sqlite-autoconf-3360000
aarch64-openwrt-linux-musl-gcc -o sqlite3 shell.c sqlite3.c -ldl -lpthread -lm


### openssl
# cmake https://blog.csdn.net/weixin_43117602/article/details/115339416
# https://blog.csdn.net/wang_jing_kai/article/details/88619606
./Configure linux-aarch64 --cross-compile-prefix=aarch64-openwrt-linux-musl- --prefix=/opt/openwrt-gcc-8.3.0 shared
