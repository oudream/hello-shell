#!/usr/bin/env bash

### git sumodule
git submodule add https://github.com/maonx/vimwiki-assets.git assets
# git status, 可以看到目录有增加1个文件.gitmodules
git status
# 查看子模块
git submodule
# 更新项目内子模块到最新版本
git submodule update
# 更新子模块为远程项目的最新版本
git submodule update --remote
# 克隆父项目，再更新子模块
# 克隆父项目
git clone https://github.com/maonx/vimwiki-assets.git assets
# 查看子模块
git submodule
# -e33f854d3f51f5ebd771a68da05ad0371a3c0570 assets
# 子模块前面有一个-，说明子模块文件还未检入（空文件夹）。
# 初始化子模块
git submodule init
# 初始化模块只需在克隆父项目后运行一次。
# 更新子模块
git submodule update
# 递归克隆整个项目
# 递归克隆整个项目，子模块已经同时更新了，一步到位。
git clone https://github.com/maonx/vimwiki-assets.git assets --recursive
# 在子模块中修改文件后，直接提交到远程项目分支。
git add .
git ci -m "commit"
git push origin HEAD:master
# 删除子模块
# 删除子模块比较麻烦，需要手动删除相关的文件，否则在添加子模块时有可能出现错误
# 同样以删除assets文件夹为例
# 删除子模块文件夹
git rm --cached assets
rm -rf assets
# 删除.gitmodules文件中相关子模块信息
#[submodule "assets"]
#  path = assets
#  url = https://github.com/maonx/vimwiki-assets.git
# 删除.git/config中的相关子模块信息
# [submodule "assets"]
#   url = https://github.com/maonx/vimwiki-assets.git
# 删除.git文件夹中的相关子模块文件
rm -rf .git/modules/assets

