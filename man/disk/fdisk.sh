
fdisk -l |grep dev
fdisk /dev/sda
# 输入n 创建新分区
# Command action
#    e   extended
#    p   primary partition (1-4)      #这里可以选择是作为扩展分区还是主分区。这里作为主分区，则选择p

# partx命令用来告诉内核当前磁盘的分区情况
partx /dev/sda

# 查看分区格式
df -TH | grep "^/dev"

# 格式化分区
mkfs.ext4 /dev/sda2

# 临时的
mount /dev/sda2 /opt
# 永久
vim /etc/fstab
#
umount /opt
mount -a

df -h