
# 创建虚拟磁盘映像
dd if=/dev/zero of=/path/to/disk.img bs=1M count=1024
losetup /dev/loop1 /path/to/disk.img

#将文件与 loop 设备关联：
losetup /dev/loop1 /path/to/file.img

#查看 loop 设备的信息：
losetup -a

#释放 loop 设备的关联：
losetup -d /dev/loop1

#挂载文件系统
mount /dev/loop1 /mnt/my_mount_point

#查询谁关联到 /dev/loop1
lsof /dev/loop1

#
 # 用法：
 # losetup [选项] [<回环设备>]
 # losetup [选项] -f | <回环设备> <文件>
 #
 #设置和控制回环设备。
 #
 #选项：
 # -a, --all                     列出所有使用的设备
 # -d, --detach <回环设备>...    断开一台或多台设备
 # -D, --detach-all              断开所有使用的设备
 # -f, --find                    查找第一个未使用的设备
 # -c, --set-capacity <回环设备> 改变设备容量
 # -j, --associated <文件>       列出所有与 <文件> 相关的设备
 # -L, --nooverlap               避免设备间的潜在冲突
 #
 # -o, --offset <数字>           在文件偏移量 <数字> 处开始
 #     --sizelimit <数字>        设备限制为了文件的<数字>个字节
 # -b  --sector-size <num>       set the logical sector size to <num>
 # -P, --partscan                创建带分区的回环设备
 # -r, --read-only               创建只读的回环设备
 #     --direct-io[=<on|off>]    通过 O_DIRECT 打开后备文件
 #     --show                    设置后打印设备名(加 -f 选项)
 # -v, --verbose                 详尽模式
 #
 # -J, --json                    使用 JSON --list 输出格式
 # -l, --list                    列出所有或指定的信息(默认)
 # -n, --noheadings              --list 输出时不打印标题
 # -O, --output <列>           指定 --list 选项要输出的列
 #     --output-all              output all columns
 #     --raw                     使用原生 --list 输出格式
 #
 # -h, --help                    display this help
 # -V, --version                 display version
 #
 #Available output columns:
 #         NAME  回环设备名
 #    AUTOCLEAR  已设置 自动清除 标志
 #    BACK-FILE  设备后备文件
 #     BACK-INO  后备文件 inode 号
 # BACK-MAJ:MIN  后备文件 主:次 设备号
 #      MAJ:MIN  回环设备 主:次 设备号
 #       OFFSET  起始位置偏移
 #     PARTSCAN  已设置 partscan 标志
 #           RO  只读设备
 #    SIZELIMIT  文件的大小限制(字节数)
 #          DIO  通过直接 IO 访问后备文件
 #      LOG-SEC  logical sector size in bytes
 #
 #更多信息请参阅 losetup(8)。