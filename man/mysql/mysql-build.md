
# MySql 的 Windows 编译，使用 Clion + VC编译器（ Visual Studio 2019 ）

## .step: source code
```shell
# windows
# windows 使用 vc 编译器
# - visual studio 对mysql进行源码级调试 https://www.cnblogs.com/huangxincheng/p/13084736.html
git  clone https://github.com/mysql/mysql-server --recursive D:/ddd/mysql-server
# linux
git  clone https://github.com/mysql/mysql-server --recursive 
```

## .step: boost
- 不用下載，在 cmake 命令后面增加参数
- https://osdn.net/projects/sfnet_boost/downloads/boost/1.73.0/boost_1_73_0.tar.gz/
- 在CLion 的CMake选项中增加
```text
-DDOWNLOAD_BOOST=1 -DWITH_BOOST="d:/ddd/boost/boost1.7"
```

## .step: ssl
- 下載安裝
- https://slproweb.com/products/Win32OpenSSL.html
- https://wiki.openssl.org/index.php/Binaries  
- 修改 OpenSSL-Win64 目錄
```text
            PATHS "${_programfiles}/OpenSSL-Win64" "D:/Software/OpenSSL-Win64/"
```

## .step: bison
- 下载 bison 并把 bison/bin 加到 PATH
- http://gnuwin32.sourceforge.net/packages/bison.htm
- https://www.chriscalender.com/tag/bison-exe/
```shell
bison.exe -y -p MYSQL --output=D:/ddd/mysql-server/sql/sql_yacc.cc --defines=D:/ddd/mysql-server/sql/sql_yacc.h D:/ddd/mysql-server/sql/sql_yacc.yy
bison.exe -y -p MYSQL --output=D:/ddd/mysql-server/sql/sql_hints.yy.cc --defines=D:/ddd/mysql-server/sql/sql_hints.yy.h D:/ddd/mysql-server/sql/sql_hints.yy
```

## .step: utf8 -> Unicode
- 用 Uedit32.exe 修改（Utf8 轉 Unicode）：D:\ddd\mysql-server\cmake-build-debug\scripts\sql_commands_help_data.h
- 用 Uedit32.exe 修改（Utf8 轉 Unicode）：D:\ddd\mysql-server\sql\sql_locale.cc

