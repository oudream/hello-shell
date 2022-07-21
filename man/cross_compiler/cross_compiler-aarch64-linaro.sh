# https://archlinux.pkgs.org/rolling/archlinux-community-aarch64/
# https://releases.linaro.org/components/toolchain/binaries

### 使用导出与PATH设置的方法来交叉编译

### cmake
# https://cmake.org/cmake/help/latest/manual/cmake-toolchains.7.html#cross-compiling-for-linux

### openwrt
- https://openwrt.org/zh/docs/guide-developer/crosscompile

### linaro
# https://releases.linaro.org/components/toolchain/binaries/latest-7/aarch64-linux-gnu/
# https://archlinux.org/packages/community/x86_64/aarch64-linux-gnu-gcc/
# https://gcc.gnu.org/onlinedocs/gcc/AArch64-Options.html
# https://gcc.gnu.org/wiki/Building_Cross_Toolchains_with_gcc
wget https://releases.linaro.org/components/toolchain/binaries/latest-7/aarch64-linux-gnu/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu.tar.xz
# 编译C++时，需要安装以下
sudo apt-get install -y gcc-aarch64-linux-gnu
sudo apt-get install -y g++-aarch64-linux-gnu

# /opt/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/lib64/
vim /etc/profile
export PATH=$PATH:/opt/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu/bin/

export CC=aarch64-linux-gnu-gcc
export CXX=aarch64-linux-gnu-g++
export AR=aarch64-linux-gnu-ar
export RANLIB=aarch64-linux-gnu-ranlib
# export host=aarch64-linux-gnu

#
aarch64-linux-gnu-addr2line     aarch64-linux-gnu-gcc-7         aarch64-linux-gnu-gcov-dump     aarch64-linux-gnu-objcopy
aarch64-linux-gnu-ar            aarch64-linux-gnu-gcc-ar        aarch64-linux-gnu-gcov-dump-7   aarch64-linux-gnu-objdump
aarch64-linux-gnu-as            aarch64-linux-gnu-gcc-ar-7      aarch64-linux-gnu-gcov-tool     aarch64-linux-gnu-ranlib
aarch64-linux-gnu-c++filt       aarch64-linux-gnu-gcc-nm        aarch64-linux-gnu-gcov-tool-7   aarch64-linux-gnu-readelf
aarch64-linux-gnu-cpp           aarch64-linux-gnu-gcc-nm-7      aarch64-linux-gnu-gprof         aarch64-linux-gnu-size
aarch64-linux-gnu-cpp-7         aarch64-linux-gnu-gcc-ranlib    aarch64-linux-gnu-ld            aarch64-linux-gnu-strings
aarch64-linux-gnu-dwp           aarch64-linux-gnu-gcc-ranlib-7  aarch64-linux-gnu-ld.bfd        aarch64-linux-gnu-strip
aarch64-linux-gnu-elfedit       aarch64-linux-gnu-gcov          aarch64-linux-gnu-ld.gold
aarch64-linux-gnu-gcc           aarch64-linux-gnu-gcov-7        aarch64-linux-gnu-nm

### zlib | libz
wget https://zlib.net/zlib-1.2.12.tar.gz
./configure --prefix=/opt/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/ --shared
./configure --prefix=/opt/gcc-linaro-arm-linux-gnueabihf-4.7-2013.03/arm-linux-gnueabihf/ --shared
./configure --prefix=/opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/arm-linux-gnueabihf/ --shared
make && make install

### sqlite
wget https://www.sqlite.org/2021/sqlite-autoconf-3360000.tar.gz
tar zxvf sqlite-autoconf-3360000.tar.gz
cd sqlite-autoconf-3360000
aarch64-linux-gnu-gcc -o sqlite3 shell.c sqlite3.c -ldl -lpthread -lz -lm

### Linux-3.10
# https://www.codeleading.com/article/8783336671/
wget https://mirrors.edge.kernel.org/pub/linux/kernel/v4.x/linux-4.10.tar.xz
tar -xf linux-4.10.tar.xz
cd linux-4.10
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- Image


# https://stackoverflow.com/questions/5576358/vmstat-command-missing
# https://gitlab.com/procps-ng/procps/-/blob/master/INSTALL.md
./mipsel-linux-gcc -v Configured with: ../gcc-4.2.0-20070124/configure --prefix=/opt/toolchains/crosstools_hf-linux-2.6.18.0_gcc-4.2-11ts_uclibc-nptl-0.9.29-20070423_20090508/ --build=mipsel-linux --host=mipsel-linux --target=mipsel-linux-uclibc --with-build-sysroot=/usr/src/redhat/BUILD/build_uClibc --enable-languages=c,c++ --disable-__cxa_atexit --enable-target-optspace --with-gnu-ld --with-float=hard --enable-threads --infodir=/opt/toolchains/crosstools_hf-linux-2.6.18.0_gcc-4.2-11ts_uclibc-nptl-0.9.29-20070423_20090508/info --with-arch=mips32


### apr
# https://www.javaroad.cn/questions/87215
# https://blog.csdn.net/m0_37263637/article/details/78590853
./configure --prefix=/usr/arm-linux-gnueabi/apr --host=arm-linux-gnueabi CC="arm-linux-gnueabi-gcc" CXX="arm-linux-gnueabi-g++"
./configure CC=/home/jw.li/work/toolchain-arm_cortex-a7+vfp_gcc-4.8-linaro_uClibc-0.9.33.2_eabi/bin/arm-openwrt-linux-gcc CXX=/home/jw.li/work/toolchain-arm_cortex-a7+vfp_gcc-4.8-linaro_uClibc-0.9.33.2_eabi/bin/arm-openwrt-linux-g++ --host=arm-openwrt-linux --prefix=/home/jw.li/work/v50/osssdk/apr  ac_cv_file__dev_zero=yes ac_cv_func_setpgrp_void=yes apr_cv_process_shared_works=yes apr_cv_mutex_robust_shared=yes apr_cv_tcp_nodelay_with_cork=yes ap_void_ptr_lt_long=no


### openssl
# https://stackoverflow.com/questions/60821697/how-to-build-openssl-for-arm-linux
# cmake https://blog.csdn.net/weixin_43117602/article/details/115339416
# https://blog.csdn.net/wang_jing_kai/article/details/88619606
./Configure linux-aarch64 --cross-compile-prefix=aarch64-linux-gnu- --prefix=/opt/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/ shared
./Configure linux-aarch64 --cross-compile-prefix=aarch64-linux-gnu- --prefix=/opt/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/ shared
# wget  "https://developer.arm.com/-/media/Files/downloads/gnu-a/9.2-2019.12/binrel/gcc-arm-9.2-2019.12-x86_64-arm-none-linux-gnueabihf.tar.xz?revision=fed31ee5-2ed7-40c8-9e0e-474299a3c4ac&la=en&hash=76DAF56606E7CB66CC5B5B33D8FB90D9F24C9D20" -O gcc-arm-9.2-2019.12-x86_64-arm-none-linux-gnueabihf.tar.xz
# tar Jxf gcc-arm-9.2-2019.12-x86_64-arm-none-linux-gnueabihf.tar.xz -C /opt/arm/9
# ./Configure linux-generic32 --cross-compile-prefix=/opt/arm/9/gcc-arm-9.2-2019.12-x86_64-arm-none-linux-gnueabihf/bin/arm-none-linux-gnueabihf- --prefix=/opt/openssl-1.1.1e --openssldir=/opt/openssl-1.1.1e -static
export PATH=$PATH:/opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin
./Configure linux-generic32 --cross-compile-prefix=arm-linux-gnueabihf- --prefix=/opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/arm-linux-gnueabihf/ shared


### libmodbus
# https://github.com/stephane/libmodbus/issues/297
CC=/opt/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-gcc CXX=/opt/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-g++ ./autogen.sh
CC=/opt/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-gcc CXX=/opt/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-g++ ./configure ac_cv_func_malloc_0_nonnull=yes --host=arm --enable-static --without-documentation