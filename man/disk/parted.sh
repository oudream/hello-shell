### CentOS 7 使用 parted 分区解决大于2T的硬盘

# 硬盘 sdb 进行分区
parted /dev/sdb

#GNU Parted 3.1
#Using /dev/sdb
#Welcome to GNU Parted! Type 'help' to view a list of commands.

# 显示当前分区
(parted) p
#Model: HPE LOGICAL VOLUME (scsi)
#Disk /dev/sdb: 4001GB
#Sector size (logical/physical): 512B/512B
#Partition Table: msdos
#Disk Flags:
#
#Number  Start  End  Size  Type  File system  Flags

# 生成分区表类型
(parted) mklabel gpt

#Warning: The existing disk label on /dev/sdb Do you want to continue?

# 确定
Yes/No? y

# 创建分区
(parted) mkpart

# 输入分区名
Partition name?  []? sdb1

# 输入分区格式
File system type?  [ext2]? ext4

# 起点
Start? 0
# 终点
End? 4001G

#Warning: The resulting partition is not properly aligned for best performance.
Ignore/Cancel? Ignore

# 查看分区，成功
(parted) p
#Model: HPE LOGICAL VOLUME (scsi)
#Disk /dev/sdb: 4001GB
#Sector size (logical/physical): 512B/512B
#Partition Table: gpt
#Disk Flags:
#
#Number  Start   End     Size    File system  Name  Flags
# 1      17.4kB  4001GB  4001GB               sdb1


### 机子：117.141.182.206:10022 
mkfs -t ext4 /dev/sdb1
mkdir -p /mnt/sdb1
mount -t ext4 /dev/sdb1 /mnt/sdb1
echo /dev/sdb1 /mnt/sdb1 ext4 defaults 1 2 >> /etc/fstab

mkfs -t ext4 /dev/sdb2
mkdir -p /mnt/sdb2
mount -t ext4 /dev/sdb2 /mnt/sdb2
echo /dev/sdb2 /mnt/sdb2 ext4 defaults 1 2 >> /etc/fstab

mkfs -t ext4 /dev/sdb3
mkdir -p /mnt/sdb3
mount -t ext4 /dev/sdb3 /mnt/sdb3
echo /dev/sdb3 /mnt/sdb3 ext4 defaults 1 2 >> /etc/fstab

### 机子：117.141.182.206:20022 
mkfs -t ext4 /dev/sda1
mkdir -p /mnt/sda1
mount -t ext4 /dev/sda1 /mnt/sda1
echo /dev/sda1 /mnt/sda1 ext4 defaults 1 2 >> /etc/fstab

mkfs -t ext4 /dev/sda2
mkdir -p /mnt/sda2
mount -t ext4 /dev/sda2 /mnt/sda2
echo /dev/sda2 /mnt/sda2 ext4 defaults 1 2 >> /etc/fstab

