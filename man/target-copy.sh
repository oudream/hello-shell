#!/usr/bin/env bash

# 1. cp
# Linux下目录的合并以及文件的覆盖
# 现在有两个目录，一个是没有经过修改的叫做old,一个是经过修改的，叫做new，现在要把new里面的文件合并到old里面，并且覆盖old里面的同名旧文件，那么可以执行如下的命令。
cp -frap new/* old/
# 命令的解释如下：
# -f 强制覆盖，不用询问yes/no，（-i 是默认的，也就是交互方式，会询问是否进行覆盖）
# -r 递归复制，包括目录
# -a 做一个备份。我们也可以不使用这个参数，先手动备份整个old目录
# -p 保持新文件的属性不变

# 2. rsync
# 当然，除了使用 cp 命令，还可以使用 rsync 命令进行目录的合并操作。
rsync -a new/* old/

