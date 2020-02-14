#!/usr/bin/env bash


open http://man7.org/linux/man-pages/man1/dd.1.html
open "https://zh.wikipedia.org/wiki/Dd_(Unix)"
open https://dev.mysql.com/doc/mysql-apt-repo-quick-guide/en/

# 备份MBR
dd if=/dev/sda of=/app/MBR bs=1 count=512

# 破坏MBR的bootloader
dd if=/dev/zero of=/dev/sda  bs=1 count=64 seek=446

# 备份数据
dd if=/dev/sda of=/app/sda.bak          # 将sda磁盘上的数据备份到/app/sda.bak文件
dd if=/dev/sda | gzip >/app/sda.gz      # 备份/dev/sda全盘数据，并利用gzip 压缩，保存到/app/sda.gz文件

# 恢复数据
dd if=/dev/app/sda.bak of=/dev/sdb      # 将sda备份文件sda.bak恢复到/dev/sdb磁盘
gzip -dc /app/sda.gz | dd of=/dev/sdb   # 将压缩的sda.gz文件恢复到/dev/sdb设备

# 拷贝内存数据到磁盘
dd if=/dev/mem of=/app/men.bak bs=1024  # 将内存中的数据拷贝到/app/mem.bak文件中，以一块1M的单位读取和写入

# 销毁磁盘数据
dd if=/dev/urandom of=/dev/sdb1         # 使用urandom产生的随机数填充覆盖磁盘原数据，即为销毁磁盘数据，执行操作之后，/dev/sdb1将被破坏无法挂载及创建和拷贝等操作都将无法使用

# 测试硬盘写速度
dd if=/dev/zero of=/app/f1 bs=1M count=10000

# 测试硬盘读速度
dd if=/app/f1 bs=64k | dd of=/dev/null

# 修复硬盘
dd=if=/dev/sda of=/dev/sda

# 拷贝iso镜像
dd if=/dev/sr0 of=centos6.iso
cp /dev/sr0 centos6.iso                 # 拷贝光盘数据到centos6.iso文件

# 制作iso镜像
mkisofs -r -o centos.iso /app/centos6   # 将/app/centos6目录打包为iso文件

# 设置系统启动盘
dd if=/dev/sr0 of=/dev/sdd              # /dev/sdd为外接硬盘设备，可做系统启动盘


dd [OPERAND]... OPTION

# Copy a file, converting and formatting according to the operands.
# dd可从标准输入或文件中读取数据，根据指定的格式来转换数据，再输出到文件、设备或标准输出。
# 
#    if=文件名       : 输入文件名，默认为标准输入。即指定源文件。
#    of=文件名       : 输出文件名，默认为标准输出。即指定目的文件。
#    ibs=bytes      : 一次读入bytes个字节，即指定一个块大小为bytes个字节。
#    obs=bytes      : 一次输出bytes个字节，即指定一个块大小为bytes个字节。
#    bs=bytes       : 同时设置读入/输出的块大小为bytes个字节。
#    cbs=bytes      : 一次转换bytes个字节，即指定转换缓冲区大小。
#    skip=blocks    : 从输入文件开头跳过blocks个块后再开始复制。
#    seek=blocks    : 从输出文件开头跳过blocks个块后再开始复制。
#    count=blocks   : 仅拷贝blocks个块，块大小等于ibs指定的字节数。
#    conv=<关键字>   : 关键字可以有以下11种
#                    conversion    用指定的参数转换文件。
#                    ascii         转换ebcdic为ascii
#                    ebcdic        转换ascii为ebcdic
#                    ibm           转换ascii为alternate ebcdic
#                    block         把每一行转换为长度为cbs，不足部分用空格填充
#                    unblock       使每一行的长度都为cbs，不足部分用空格填充
#                    lcase         把大写字符转换为小写字符
#                    ucase         把小写字符转换为大写字符
#                    swab          交换输入的每对字节
#                    noerror       出错时不停止
#                    notrunc       不截短输出文件
#                    sync          将每个输入块填充到ibs个字节，不足部分用空（NUL）字符补齐。
#    --help         : 显示帮助信息
#    --version      : 显示版本信息
