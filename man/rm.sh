#!/usr/bin/env bash

# 注意 注意 注意 打开extglob模式，才能運行以下
shopt -s extglob
# 删除文件名不以jpg结尾的文件：
rm -rf !(*jpg)

# 删除文件名以jpg或png结尾的文件：
rm -rf *@(jpg|png)