

#编译链接库：-lz -lrt -lm -lc都是什么库
#
#-lz      压缩库（Z）
#
#-lrt     实时库（real time）：shm_open系列
#
#-lm     数学库（math），比如log10等
#
#-lc     标准C库（C lib）
#
#-dl     dlopen dlerror dlclose dlsym 等函数的库，是显式加载动态库的动态函数库
#
#-pthread 线程建立函数

# .a库/档案文件是32位还是64位
file <.so file or .a file>
objdump -f libfoo.a | grep ^architecture

# 查看文件：
ar -t *.a
#查看函数、变里：
nm *.a