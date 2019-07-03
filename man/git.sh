#!/usr/bin/env bash

### --- branch begin: ---
git init
# 初始化空的 Git 仓库于 /fff/tmp/testgit/.git/
touch README
git add README
git config --global user.email "oudream@126.com"
git commit -m 'add README'
# [master （根提交） 05d7386] add README
#    1 file changed, 0 insertions(+), 0 deletions(-)
#    create mode 100644 README
git branch testing
git branch
# * master
#   testing
git checkout testing
# 切换到分支 'testing'
git branch
#   master
# * testing
echo 'hello git' > test.txt
git add .
git commit -m 'add test.txt'
# [testing 681dec0] add test.txt
#  1 file changed, 1 insertion(+)
#  create mode 100644 test.txt
ls
# README test.txt
git checkout master
# 切换到分支 'master'
ls
# README
git checkout testing
# 切换到分支 'testing'
ls
# README test.txt
git checkout master
# 切换到分支 'master'
ls
# README
git merge testing
# 更新 05d7386..681dec0
# Fast-forward
#  test.txt | 1 +
#  1 file changed, 1 insertion(+)
#  create mode 100644 test.txt
ls
# README test.txt
git branch
# * master
#   testing
### --- branch end. ---


git branch testing
git checkout testing

git commit

# 在主线上进行合并操作,选中一个需要合并进来的分支的节点
git checkout master
git merge hotfix
# 在合并的时候，你应该注意到了"快进（fast-forward）"这个词。如果顺着一个分支走下去能够到达另一个分支，那么 Git 在合并两者的时候，
#    只会简单的将指针向前推进（指针右移），因为这种情况下的合并操作没有需要解决的分歧——这就叫做 “快进（fast-forward）”。
# 简单的说,你主线合并操作节点,是合并进来分支的super指针.那么就将两条分支串联起来.类似于变基

# 查看哪些分支(已经/尚未)合并到当前分支
git branch --merged
git branch --no-merged
# 查看所有的分支,分支前的 * 字符：它代表现在检出的那一个分支
git branch -v
# 查看所有的分支提交历史
git log --oneline --decorate --graph --all
# 查看当前所在分支状态的提交历史
git log --oneline --decorate
# 远程分支列表
git ls-remote

# 推送到远端,origin没有什么特殊含义,只是我们远程仓库的名字,通常默认为origin
git push origin testing
# 如果远端上的分支名字不一样,我们可以进行本地到远端的映射
git push origin testing:awesomebranch

# 当一个临时分支使用完成后(idea,hotfix,bug01)应该删除这个分支.
git branch -d hotfix
# error: The branch 'hotfix' is not fully merged.
# If you are sure you want to delete it, run 'git branch -D hotfix'.
# 意思是分支没有合并,但可以使用大写的D强制删除
git branch -D hotfix
# 删除远端的分支
git push origin --delete hotfix
# 当前分支彻底回退到某个版本，本地的源码也会变为上一个版本的内容
git reset --hard 版本号的sha1



#This just creates the branch without checking it out.
git branch justin a9c146a09505837ec03b

# This will create a new branch called 'justin' and check it out.
git checkout -b justin a9c146a09505837ec03b

# If you want only the remote URL, or referential integrity has been broken:
git config --get remote.origin.url

# If you require full ou.tput or referential integrity is intact:
git remote show origin

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

