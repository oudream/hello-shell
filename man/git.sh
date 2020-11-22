#!/usr/bin/env bash


git update-index --chmod=+x path/to/file


# 下述命令其实相当于 git fetch + git merge
git pull origin master


git status # 运行git status命令查看本地修改
git remote -v # git查看远程仓库地址命令


### diff
git diff readme.txt # 看看更改的地方（difference）
git diff branch1..branch2 #
git diff k73ud^..dj374 # 比较两不同的提交，Show diff between commits
# And if you need to get only files names (e.g. to copy hotfix them manually):
git diff k73ud dj374 --name-only
# And you can get changes applied to another branch:
git diff k73ud dj374 > my.patch
git apply my.patch

# git fetch 指令是下载远程仓库最新内容，不做合并
# git reset 指令把HEAD指向master最新版本
git fetch --all
git reset --hard origin/master
git pull //可以省略
# How do I undo the most recent local commits in Git? : https://stackoverflow.com/questions/927358/how-do-i-undo-the-most-recent-local-commits-in-git
git reset HEAD~


###
# git pull使用给定的参数运行git fetch，并调用git merge将检索到的分支头合并到当前分支中。
# 使用--rebase，它运行git rebase而不是git merge。
# git pull <远程主机名> <远程分支名>:<本地分支名>
# 要取回origin主机的next分支，与本地的master分支合并，需要写成下面这样 -
git pull origin next:master


### Git 培训实战
# https://heis.gitee.io/git-training/#5credentialhelperselector-


###
echo "# wwwroot" >> README.md
git init
git add README.md
git commit -m "first commit"
git remote add origin https://github.com/oudream/wwwroot.git
git push -u origin master

git remote add origin https://github.com/oudream/wwwroot.git
git push -u origin master

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
# error : git submodule add https://github.com/maonx/vimwiki-assets.git --recursive
# 子模块的递归克隆要先 submodule add, 再用以下的命令
git submodule update --init --recursive
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
git rm --cached "referto/pytorch-book"
git rm -r --cached pytorch-book
rm -rf "pytorch-book"
# 删除.gitmodules文件中相关子模块信息
#[submodule "assets"]
#  path = assets
#  url = https://github.com/maonx/vimwiki-assets.git
# 删除.git/config中的相关子模块信息
# [submodule "assets"]
#   url = https://github.com/maonx/vimwiki-assets.git
# 删除.git文件夹中的相关子模块文件
rm -rf .git/modules/springBoot_atguigu

# 只克隆最新的提交记录
git clone <remote-address> --depth 1

# 只克隆单个分支的最新一次提交
# git clone --branch <branch_name> <remote-address> --depth 1

# 子模块的提交
#cd path/to/submodule
cd 3rd/ccxx
git add .
git commit -m "update by submodule 2"
git push origin HEAD:master


### 用户名 密码
# 设置记住密码（默认15分钟）：
git config --global credential.helper cache
# 2、如果想自己设置时间，可以这样做：
git config credential.helper 'cache --timeout=3600'

# 长期存储密码：
git config --global credential.helper store
# 当git push的时候输入一次用户名和密码就会被记录
# 参考
man git | grep -C 5 password
man git-credential-store
#
git config credential.helper store
git push http://example.com/repo.git
#       Username: <type your username>
#       Password: <type your password>
#       [several days later]
#       [your credentials are used automatically]
# 这样保存的密码是明文的，保存在用户目录~的.git-credentials文件中
file ~/.git-credentials
cat  ~/.git-credentials


#【Git黑科技】git 删除远程分支上的某次commit
# https://blog.csdn.net/jinzhencs/article/details/77897738
# 回退版本
git reset --hard commitId
git push -f
# 删除某一次commit
git rebase -i "commit id"^ # 注意^不能少 意思是包含本次要删除的commit
#    然后出现交互界面 (vi的界面）
dd  # 删除最上面的(就是你要删除的目标commit)
:wq # 保存即可
# 然后
git push -f


# filename-too-long-in-git-for-windows: https://stackoverflow.com/questions/22575662/filename-too-long-in-git-for-windows
git config --system core.longpaths true