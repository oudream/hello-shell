# git常用操作

## 1、删除远程仓库分支

```bash
git push 远程仓库别名 :远程仓库中的分支
```

## 2、克隆远程仓库指定分支到本地某个文件夹

```bash
git clone <Git_URL> -b <branch_name> <指定目录>
```

## 3、拉取远程仓库指定分支到本地仓库的特定分支

```bash
git fetch <remote_repo_shortname> 远程仓库中分支名:本地分支名
#使用该方式会在本地新建分支，但是不会自动切换到该本地分支，需要手动checkout切换分支。
git remote update ;\
git checkout -b local_branch <remote_repo_shortname>/<remote_branch>
#使用该方式会在本地新建分支，并自动切换到该本地分支。采用此种方法建立的本地分支会和远程分支建立映射关系。
```

## 4、Git代理设置

```bash
# 设置代理
git config --global http.proxy 代理地址
git config --global https.proxy 代理地址

# 取消代理
git config --global --unset http.proxy
git config --global --unset https.proxy

# 查看代理设置
git config --global --get http.proxy
git config --global --get https.proxy
```

