#!/usr/bin/env bash

# 删除文件名不以jpg结尾的文件：
rm -rf !(*jpg)

# 删除文件名以jpg或png结尾的文件：
rm -rf *@(jpg|png)