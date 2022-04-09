
### e.g.
```shell
gdb ./devel/lib/core_dump_test/core_dump_test ~/.ros/core-core_dump_test-7740
> [Current thread is 1 (Thread 0x7f7ae02ca780 (LWP 7740))]
> (gdb) bt
```



### 查询 core dump
```shell
ulimit -c

```


### 在/etc/profile中加入以下一行，这将允许生成coredump文件
```shell
ulimit -c unlimited

```


### 在rc.local中加入以下一行，这将使程序崩溃时生成的coredump文件位于/data/coredump/目录下:
### rc.local在不同的环境，存储的目录可能不同，susu下可能在/etc/rc.d/rc.local
```shell
mkdir /userdata/coredump
echo /userdata/coredump/core.%e.%p> /proc/sys/kernel/core_pattern

```


### gdb 
### 添加gdb调试信息
- 在编译ROS进程的CMakelist.txt中添加下面命令，使编译产生的执行文件包含gdb调试信息。
```cmake
SET(CMAKE_BUILD_TYPE "Debug")  
SET(CMAKE_CXX_FLAGS_DEBUG "$ENV{CXXFLAGS} -O0 -Wall -g -ggdb")
SET(CMAKE_CXX_FLAGS_RELEASE "$ENV{CXXFLAGS} -O3 -Wall")
```
- CMAKE_CXX_FLAGS_DEBUG中的编译选项解释：
```text
-O0 关闭所有代码优化选项
-Wall 开启大部分告警提示
-g 包含调试信息
-ggdb 在可执行文件中包含可供gdb使用的调试信息
```
- CMAKE_CXX_FLAGS_RELEASE 中的编译选项解释：
```text
-O3 开启第三级别优化，在-O2基础上增加产生inline函数、使用寄存器等优化技术
```


