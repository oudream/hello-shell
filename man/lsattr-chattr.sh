
# 1、原因，属组不对，使用chown root:root xxx修复

# 2、没有可执行权限x，ls -lxxx，查看是否有rwx的x权限。
#> -rw-r--r-- 1 root root 364072 Feb 11 2014 iava
# 没有就加上chmod+x/tmp/java

# 3、加上了不可修改的属性lsattr /tmp/java
lsattr -a /root
# ---i--------e-java
# 去掉i属性:chattr -i/tmp/java
chattr -i /root/.ssh

# 4、文件系统问题
mount grep /tmp

#发现有noexec问题

