#!/usr/bin/env bash

# 置文件为空
touch FilePath
:>FilePath # 可以创建空文件，如果file存在，则把file截断为0字节
cat /dev/null > FilePath


# 注意 注意 注意 打开extglob模式，才能運行以下
shopt -s extglob
# 删除文件名不以jpg结尾的文件：
rm -rf !(*jpg)

# 删除文件名以jpg或png结尾的文件：
rm -rf *@(jpg|png)
