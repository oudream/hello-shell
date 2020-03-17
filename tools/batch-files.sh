#!/usr/bin/env bash


### 批量修改文件名
# 将 book01.txt、paper02.txt 改为 book-01.txt、paper-02.txt
for file in `ls | grep .txt`
do
    newfile=`echo $file | sed 's/\([a-z]\+\)\([0-9]\+\)/\1-\2/'`
    mv $file $newfile
done

# 文件名包含空格的解决方法: 要解决这个问题，我们可以将 IFS（内部字段分隔符）设置为换行符 \n
IFS=$'\n'

#    fname=${files:0:2}
#    bname=${files:0-4}
#    filename="麦子学院d2-"$fname$bname
#    mv $files $filename
# for filename in `find .`
# for filename in `find $PWD`
for filename in `find .`
do
    echo $filename
    fullfile=$filename
    fullname="${fullfile##*/}"
    dir="${fullfile%/*}"
    extension="${fullname##*.}"
    filename="${fullname%.*}"
    echo $dir , $fullname , $filename , $extension
    echo "----"
done

for fullfile in `ls | grep .mp4`
do
    fullname="${fullfile##*/}"
    dir="${fullfile%/*}"
    extension="${fullname##*.}"
    filename="${fullname%.*}"
    echo $dir , $fullname , $filename , $extension
    echo "----"
    mv $fullfile "麦子学院d3-${filename}.${extension}"
done


# 使用 find 获取文件列表
for file in `find . -size +1M -name "*_*.txt" -o -name "*_*.jpg"`
do
 newfile=`echo $file | sed 's/\([a-z]\+\)_\([0-9]\+\)./\2-\1./'`
 mv $file $newfile
done
