
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


fdisk /dev/sdb
mkfs -t ext4 /dev/sdb1
mkdir -p /mnt/sdb1
mount -t ext4 /dev/sdb1 /mnt/sdb1
echo /dev/sdb1 /mnt/sdb1 ext4 defaults 1 2 >> /etc/fstab

fdisk /dev/sdc
mkfs -t ext4 /dev/sdc1
mkdir -p /mnt/sdc1
mount -t ext4 /dev/sdc1 /mnt/sdc1
echo /dev/sdc1 /mnt/sdc1 ext4 defaults 1 2 >> /etc/fstab


Disk /dev/sda: 953.87 GiB, 1024209543168 bytes, 2000409264 sectors
Disk model: MTFDDAK1T0TDL-1A
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disklabel type: gpt
Disk identifier: B3BF0E2E-5483-459B-AE42-E39201DFA7F8

Device       Start        End    Sectors   Size Type
/dev/sda1       34       2047       2014  1007K BIOS boot
/dev/sda2     2048    2099199    2097152     1G EFI System
/dev/sda3  2099200 2000409230 1998310031 952.9G Linux LVM

Partition 1 does not start on physical sector boundary.


Disk /dev/sdb: 1.82 TiB, 2000398934016 bytes, 3907029168 sectors
Disk model: ST2000DM008-2UB1
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disklabel type: gpt
Disk identifier: 201E1D0D-C26B-4B04-8602-0C1649DED642

Device       Start        End    Sectors  Size Type
/dev/sdb1       34       2047       2014 1007K BIOS boot
/dev/sdb2     2048    1050623    1048576  512M EFI System
/dev/sdb3  1050624 3907029134 3905978511  1.8T Solaris /usr & Apple ZFS

Partition 1 does not start on physical sector boundary.


Disk /dev/sdc: 1.82 TiB, 2000398934016 bytes, 3907029168 sectors
Disk model: ST2000DM008-2UB1
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disklabel type: gpt
Disk identifier: B991EEF5-CE7D-4FB0-94FD-D468EC255531

Device       Start        End    Sectors  Size Type
/dev/sdc1       34       2047       2014 1007K BIOS boot
/dev/sdc2     2048    1050623    1048576  512M EFI System
/dev/sdc3  1050624 3907029134 3905978511  1.8T Solaris /usr & Apple ZFS

Partition 1 does not start on physical sector boundary.

