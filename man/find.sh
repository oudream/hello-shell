#!/usr/bin/env bash

# 使用find命令找到大于指定大小的文件
find / -type f -size +10G
# 排除某个目录
find / -path "/media/xww" -type f -size +10G
# 查找系统根目录下面的所有文件的内容中包含有function字符串的文件列表
find / | xargs grep function

#
find . -iname "*" -type f -exec ln -s /home/oudream/untitled2/{} /fff/a \;
#
find . -maxdepth 1 -type d | while read dir; do count=$(find "$dir" -type f | wc -l); echo "$dir : $count"; done
#
# I'm trying to find files with multiple extensions in a shell script
find $DIR -name \*.jpg -o -name \*.png -o -name \*.gif -print
#
find $PWD -name \*.pyc | while read dir; do rm $dir; done

find $PWD -name \*.html


#按照文件名查找文件。
-name
#按照文件权限来查找文件。
-perm
#使用这一选项可以使find命令不在当前指定的目录中查找，如果同时使用-depth选项，那么-prune将被find命令忽略。
-prune
#按照文件属主来查找文件。
-user
#按照文件所属的组来查找文件。
-group
#按照文件的更改时间来查找文件， - n表示文件更改时间距现在n天以内，+ n表示文件更改时间距现在n天以前。find命令还有-atime和-ctime 选项，但它们都和-m time选项。
-mtime -n +n
#查找无有效所属组的文件，即该文件所属的组在/etc/groups中不存在。
-nogroup
#查找无有效属主的文件，即该文件的属主在/etc/passwd中不存在。
-nouser
#查找更改时间比文件file1新但比文件file2旧的文件。
-newer file1 ! file2
#查找某一类型的文件，诸如：
-type
#    b - 块设备文件。
#    d - 目录。
#    c - 字符设备文件。
#    p - 管道文件。
#    l - 符号链接文件。
#    f - 普通文件。
#查找文件长度为n块的文件，带有c时表示文件长度以字节计。
-size n：[c]
#：在查找文件时，首先查找当前目录中的文件，然后再在其子目录中查找。
-depth
# ：查找位于某一类型文件系统中的文件，这些文件系统类型通常可以在配置文件/etc/fstab中找到，该配置文件中包含了本系统中有关文件系统的信息。
-fstype
# ：在查找文件时不跨越文件系统mount点。
-mount
# ：如果find命令遇到符号链接文件，就跟踪至链接所指向的文件。
-follow
# ：对匹配的文件使用cpio命令，将这些文件备份到磁带设备中
-cpio


### find > datetime < datetime
macos:
touch -t "201802210444" /tmp/start
touch -t "201802210445" /tmp/end
find /usr/local/bin -newer /tmp/start -not -newer /tmp/end
linux:
touch --date "2007-01-01" /tmp/start
touch --date "2008-01-01" /tmp/end
find /data/images -type f -newer /tmp/start -not -newer /tmp/end

