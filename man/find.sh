#!/usr/bin/env bash

# 使用find命令找到大于指定大小的文件：
find / -type f -size +10G
# 排除某个目录
find / -path "/media/xww" -type f -size +10G

### find > datetime < datetime
macos:
touch -t "201802210444" /tmp/start
touch -t "201802210445" /tmp/end
find /usr/local/bin -newer /tmp/start -not -newer /tmp/end
linux:
touch --date "2007-01-01" /tmp/start
touch --date "2008-01-01" /tmp/end
find /data/images -type f -newer /tmp/start -not -newer /tmp/end

find . -iname "*" -type f -exec ln -s /home/oudream/untitled2/{} /fff/a \;

find . -maxdepth 1 -type d | while read dir; do count=$(find "$dir" -type f | wc -l); echo "$dir : $count"; done

# I'm trying to find files with multiple extensions in a shell script
find $DIR -name \*.jpg -o -name \*.png -o -name \*.gif -print

find $PWD -name \*.pyc | while read dir; do rm $dir; done
