
### 用于显示 ELF 文件的信息。
```shell
aarch64-linux-gnu-readelf iRunner -a > info.log
```

### 安装 查看哪些版本可以安装 (gcc-aarch64-linux-gnu)
- /usr/bin/aarch64-linux-gnu-gcc
- /usr/aarch64-linux-gnu/
- /usr/lib/gcc-cross/aarch64-linux-gnu/9/lto-wrapper/
```shell
sudo apt-cache search aarch64

### 安装一个gcc开头的5版本的支持64bit ARM linux的交叉编译工具
sudo apt-get install gcc-5-aarch64-linux-gnu

### 安装一个没有版本号的gcc-aarch64-linux-gnu
sudo apt-get install gcc-aarch64-linux-gnu

### 可以查看里边的版本信息
aarch64-linux-gnu-gcc -v
#root@cyg1pc:/usr/aarch64-linux-gnu# aarch64-linux-gnu-gcc -v
#    Using built-in specs.
#    COLLECT_GCC=aarch64-linux-gnu-gcc
#    COLLECT_LTO_WRAPPER=/usr/lib/gcc-cross/aarch64-linux-gnu/9/lto-wrapper
#    Target: aarch64-linux-gnu
#    Configured with: ../src/configure -v --with-pkgversion='Ubuntu 9.4.0-1ubuntu1~20.04.2' --with-bugurl=file:///usr/share/doc/gcc-9/README.Bugs --enable-languages=c,ada,c++,go,d,fortran,objc,obj-c++,gm2 --prefix=/usr --with-gcc-major-version-only --program-suffix=-9 --enable-shared --enable-linker-build-id --libexecdir=/usr/lib --without-included-gettext --enable-threads=posix --libdir=/usr/lib --enable-nls --with-sysroot=/ --enable-clocale=gnu --enable-libstdcxx-debug --enable-libstdcxx-time=yes --with-default-libstdcxx-abi=new --enable-gnu-unique-object --disable-libquadmath --disable-libquadmath-support --enable-plugin --enable-default-pie --with-system-zlib --without-target-system-zlib --enable-libpth-m2 --enable-multiarch --enable-fix-cortex-a53-843419 --disable-werror --enable-checking=release --build=x86_64-linux-gnu --host=x86_64-linux-gnu --target=aarch64-linux-gnu --program-prefix=aarch64-linux-gnu- --includedir=/usr/aarch64-linux-gnu/include
#    Thread model: posix
#    gcc version 9.4.0 (Ubuntu 9.4.0-1ubuntu1~20.04.2)

#    aarch64-linux-gnu-ar
#    aarch64-linux-gnu-as
#    aarch64-linux-gnu-ld
#    aarch64-linux-gnu-ld.bfd
#    aarch64-linux-gnu-ld.gold
#    aarch64-linux-gnu-nm
#    aarch64-linux-gnu-objcopy
#    aarch64-linux-gnu-objdump
#    aarch64-linux-gnu-ranlib
#    aarch64-linux-gnu-readelf
#    aarch64-linux-gnu-strip

#    aarch64-linux-gnu-ar：
#    用途： 这是 ar 工具的 AArch64 版本。
#    功能： 用于创建和修改存档文件，尤其是静态库。
#    
#    aarch64-linux-gnu-as：
#    用途： 这是 as 汇编器工具的 AArch64 版本。
#    功能： 用于将汇编代码转换为机器代码。
#    
#    aarch64-linux-gnu-ld：
#    用途： 这是 ld 链接器工具的 AArch64 版本。
#    功能： 将目标文件链接成可执行文件或共享库。
#    
#    aarch64-linux-gnu-ld.bfd：
#    用途： 这可能是使用 BFD（Binary File Descriptor）库的 AArch64 版本链接器。
#    功能： 用于处理二进制文件格式的链接器。
#    
#    aarch64-linux-gnu-ld.gold：
#    用途： 这可能是 Gold 链接器的 AArch64 版本。
#    功能： Gold 链接器是一种替代链接器，以更快的链接速度而闻名。
#    
#    aarch64-linux-gnu-nm：
#    用途： 这是 nm 符号列表工具的 AArch64 版本。
#    功能： 用于显示目标文件或二进制文件中的符号。
#    
#    aarch64-linux-gnu-objcopy：
#    用途： 这是 objcopy 目标文件复制工具的 AArch64 版本。
#    功能： 用于复制和转换目标文件。
#    
#    aarch64-linux-gnu-objdump：
#    用途： 这是 objdump 目标文件转储工具的 AArch64 版本。
#    功能： 用于显示有关目标文件的信息。
#    
#    aarch64-linux-gnu-ranlib：
#    用途： 这是 ranlib 工具的 AArch64 版本。
#    功能： 用于生成加速静态库链接的索引。
#    
#    aarch64-linux-gnu-readelf：
#    用途： 这是 readelf ELF 文件读取工具的 AArch64 版本。
#    功能： 用于显示 ELF 文件的信息。
#    
#    aarch64-linux-gnu-strip：
#    用途： 这是 strip 剥离工具的 AArch64 版本。
#    功能： 用于从目标文件中删除符号信息，减小文件大小。
```



```shell
sudo apt-get install gcc-aarch64-linux-gnu
#    Reading package lists... Done
#    Building dependency tree
#    Reading state information... Done
#    The following package was automatically installed and is no longer required:
#      gir1.2-goa-1.0
#    Use 'sudo apt autoremove' to remove it.
#    The following additional packages will be installed:
#      binutils-aarch64-linux-gnu cpp-9-aarch64-linux-gnu cpp-aarch64-linux-gnu gcc-10-cross-base
#      gcc-9-aarch64-linux-gnu gcc-9-aarch64-linux-gnu-base gcc-9-cross-base libasan5-arm64-cross
#      libatomic1-arm64-cross libc6-arm64-cross libc6-dev-arm64-cross libgcc-9-dev-arm64-cross libgcc-s1-arm64-cross
#      libgomp1-arm64-cross libitm1-arm64-cross liblsan0-arm64-cross libstdc++6-arm64-cross libtsan0-arm64-cross
#      libubsan1-arm64-cross linux-libc-dev-arm64-cross
#    Suggested packages:
#      binutils-doc gcc-9-locales cpp-doc gcc-9-doc flex bison gdb-aarch64-linux-gnu gcc-doc
#    The following NEW packages will be installed:
#      binutils-aarch64-linux-gnu cpp-9-aarch64-linux-gnu cpp-aarch64-linux-gnu gcc-10-cross-base
#      gcc-9-aarch64-linux-gnu gcc-9-aarch64-linux-gnu-base gcc-9-cross-base gcc-aarch64-linux-gnu
#      libasan5-arm64-cross libatomic1-arm64-cross libc6-arm64-cross libc6-dev-arm64-cross libgcc-9-dev-arm64-cross
#      libgcc-s1-arm64-cross libgomp1-arm64-cross libitm1-arm64-cross liblsan0-arm64-cross libstdc++6-arm64-cross
#      libtsan0-arm64-cross libubsan1-arm64-cross linux-libc-dev-arm64-cross
#    0 upgraded, 21 newly installed, 0 to remove and 6 not upgraded.
#    Need to get 28.8 MB of archives.
#    After this operation, 114 MB of additional disk space will be used.
#    Do you want to continue? [Y/n] 
```
```shell
#    Setting up gcc-9-aarch64-linux-gnu-base:amd64 (9.4.0-1ubuntu1~20.04.2cross2) ...
#    Setting up binutils-aarch64-linux-gnu (2.34-6ubuntu1.6) ...
#    Setting up cpp-9-aarch64-linux-gnu (9.4.0-1ubuntu1~20.04.2cross2) ...
#    Setting up cpp-aarch64-linux-gnu (4:9.3.0-1ubuntu2) ...
#    Setting up libc6-arm64-cross (2.31-0ubuntu9.9cross1) ...
#    Setting up gcc-9-cross-base (9.4.0-1ubuntu1~20.04.2cross2) ...
#    Setting up gcc-10-cross-base (10.5.0-1ubuntu1~20.04cross1) ...
#    Setting up linux-libc-dev-arm64-cross (5.4.0-110.124cross1) ...
#    Setting up libgcc-s1-arm64-cross (10.5.0-1ubuntu1~20.04cross1) ...
#    Setting up libatomic1-arm64-cross (10.5.0-1ubuntu1~20.04cross1) ...
#    Setting up liblsan0-arm64-cross (10.5.0-1ubuntu1~20.04cross1) ...
#    Setting up libgomp1-arm64-cross (10.5.0-1ubuntu1~20.04cross1) ...
#    Setting up libtsan0-arm64-cross (10.5.0-1ubuntu1~20.04cross1) ...
#    Setting up libc6-dev-arm64-cross (2.31-0ubuntu9.9cross1) ...
#    Setting up libasan5-arm64-cross (9.4.0-1ubuntu1~20.04.2cross2) ...
#    Setting up libstdc++6-arm64-cross (10.5.0-1ubuntu1~20.04cross1) ...
#    Setting up libitm1-arm64-cross (10.5.0-1ubuntu1~20.04cross1) ...
#    Setting up libubsan1-arm64-cross (10.5.0-1ubuntu1~20.04cross1) ...
#    Setting up libgcc-9-dev-arm64-cross (9.4.0-1ubuntu1~20.04.2cross2) ...
#    Setting up gcc-9-aarch64-linux-gnu (9.4.0-1ubuntu1~20.04.2cross2) ...
#    Setting up gcc-aarch64-linux-gnu (4:9.3.0-1ubuntu2) ...
#    Processing triggers for man-db (2.9.1-1) ...
#    Processing triggers for libc-bin (2.31-0ubuntu9.12) ...
```