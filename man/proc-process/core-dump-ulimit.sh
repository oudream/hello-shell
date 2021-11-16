
# 查询 core dump
ulimit -c

# 在/etc/profile中加入以下一行，这将允许生成coredump文件
ulimit -c unlimited

# 在rc.local中加入以下一行，这将使程序崩溃时生成的coredump文件位于/data/coredump/目录下:
# rc.local在不同的环境，存储的目录可能不同，susu下可能在/etc/rc.d/rc.local
mkdir /userdata/coredump
echo /userdata/coredump/core.%e.%p> /proc/sys/kernel/core_pattern
