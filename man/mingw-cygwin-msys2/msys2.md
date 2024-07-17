
### 下载
- https://www.msys2.org/
```shell
wget https://github.com/msys2/msys2-installer/releases/download/2024-01-13/msys2-x86_64-20240113.exe

# 安装gcc
pacman -S mingw-w64-ucrt-x86_64-gcc

```

### 安装 GTK
- https://www.gtk.org/docs/installations/windows/
```shell
pacman -S mingw-w64-x86_64-gtk4

```

# 使用 CLion + MSYS2 配置 C 语言编程环境
- https://zhuanlan.zhihu.com/p/37908498

# clion
```shell
pacman-key --init
pacman -Syu
pacman -S mingw-w64-x86_64-cmake mingw-w64-x86_64-extra-cmake-modules
pacman -S mingw-w64-x86_64-make
pacman -S mingw-w64-x86_64-gdb
pacman -S mingw-w64-x86_64-toolchain
```

### GTK
```shell

```