

# .a库/档案文件是32位还是64位
file <.so file or .a file>
objdump -f libfoo.a | grep ^architecture

# 查看文件：
ar -t *.a
#查看函数、变里：
nm *.a