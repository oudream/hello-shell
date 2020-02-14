#!/usr/bin/env bash

# reboot to rescue base on Finnix

# Finnix Finnix是一个基于Debian的完全独立的可启动Linux救援LiveCD。它对于安装和修改硬盘驱动器，分区，重建启动记录，
#    挽救现有系统等非常有用。
# Finnix基于Linux内核3.0和x86，默认情况下包括数百个系统管理员软件包，全部小于400 MB，压缩成160MB小型可引导ISO映像。

# By default, your disks are not mounted when your Linode boots into Rescue Mode. However,
#    you can manually mount a disk under Rescue Mode to perform system recovery and maintenance
#    tasks. Run the mount command, replacing /dev/sda with the location of the disk you want to
#    mount:

mount -o barrier=0 /dev/sda
# Disks that contain a single filesystem will have mount points under /media in
#    the rescue environment’s /etc/fstab file. To view the directories on the disk,
#    enter the following command:

ls /media/sda

# Then to create the chroot, you need to mount the temporary filesystems:
cd /media/sda
mount -t proc proc proc/
mount -t sysfs sys sys/
mount -o bind /dev dev/
mount -t devpts pts dev/pts/

# Chroot to your disk:
chroot /media/sda /bin/bash


# 修复文件系统
# 在Finnix上修复文件系统非常简单明了。如上所述引导至Finnix，并运行以下命令：
# 上面的命令将修复您的根文件系统并传递“yes”标志以自动修复文件系统而无需进一步输入。
fsck -y /dev/vda1


# To exit the chroot and get back to Finnix type “exit” :
exit