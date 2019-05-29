#!/usr/bin/env bash


#1.查看swap分区大小：
free -m
#                 total       used       free     shared    buffers     cached
#    Mem:          2026       1798        228          0         20       1637
#    -/+ buffers/cache:        139       1887
#    Swap:         3294          0       3294
#    [root@oracle ~]#

# 2.创建swap文件:
dd if=/dev/zero of=swapfree bs=32k count=8192  (256MB)
# 或
fdisk /dev/hda 创建一个swap分区

# 3.格式化swap文件:
mkswap swapfree
# 或
mkswap /dev/hda5

# 4.启用swap文件:
swapon /tmp/swapfree
# 或
swapon /dev/hda5

# 5.停止：
swapoff /tmp/swapfree
# 或
swapoff /dev/hda5

# 6.启动时加载:
# 在/etc/fstab文件中，加入下行：
/tmp/swapfree swap swap defaults 0 0

# 7.检查或查看swap
swapon -s

# 8. 方法二(加标签: mkswap -L swap02)
# free -m
# swapon -s # 查看swap
# swapoff -a
# lvcreate -L 2G -n lvswap02 vg_root
# mkswap -L swap02 /dev/mapper/vg_root-lvswap02  # then add new swap to /etc/fstab
# swapon -a
# free -m


# 1  查看swap 空间大小(总计)：
free -m     # 默认单位为k, -m 单位为M

# 2  查看swap 空间(file(s)/partition(s))：
swapon -s
#　　等价于
cat /proc/swaps


# 3.1 添加一个交换分区
#　　步骤如下：
#      a  使用fdisk来创建交换分区（假设 /dev/sdb2 是创建的交换分区）
#      b 使用 mkswap 命令来设置交换分区：
mkswap /dev/sdb2
#      c 启用交换分区：
swapon /dev/sdb2
#      d 写入/etc/fstab,以便在引导时启用：
/dev/sdb2 swap swap defaults 0 0


# 3.2 添加一个交换文件
#　　a  创建大小为512M的交换文件：
dd if=/dev/zero of=/swapfile1 bs=1024k count=512
#　　b 使用 mkswap 命令来设置交换文件：
mkswap /swapfile1
#　　c 启用交换分区：
swapon /swapfile1
#　　d 写入/etc/fstab,以便在引导时启用：
/swapfile1 swap swap defaults 0 0


#4 删除交换空间：
#　　a 禁用交换分区：
swapoff /dev/sdb2
#　　b 从 /etc/fstab 中删除项目；
#　　c 使用fdisk或yast工具删除分区。
