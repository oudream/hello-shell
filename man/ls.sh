#!/usr/bin/env bash

ls -lR | grep "^d"

### ls
# -X 根据扩展名排序
# -S 根据文件大小排序
# -t 以文件修改时间排序
# -v 根据版本进行排序
# -U 不进行排序;依文件系统原有的次序列出项目
ls -a # –all 列出目录下的所有文件，包括以 . 开头的隐含文件
ls -R # 显示子目录结构
ls -F # 追加文件的类型标识符，具体含义：“*”表示具有可执行权限的普通文件，“/”表示目录，“@”表示符号链接，“|”表示命令管道FIFO，“=”表示sockets套接字。
ls -S # 由大到小排序
ls -Sr # 从小到大排序
ls -t # 从新到旧
ls -tr # 从旧到新
ls -h # –human-readable
ls -T # 长日期格式
ls -lR | grep "^-" | wc -l # 统计目录数量
tree -L 2
find . -maxdepth 1 -type d | while read dir; do count=$(find "$dir" -type f | wc -l); echo "$dir : $count"; done
ls | sed "s:^:`pwd`/:"   # full path
ls | sed "s:^:`pwd`/:" | sed "s/^/$HOSTNAME:/g"
find $PWD -maxdepth 1  | xargs ls -ld
