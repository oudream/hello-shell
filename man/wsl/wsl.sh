#!/usr/bin/env bash

# https://docs.microsoft.com/zh-cn/windows/wsl/about
# 原理：
# https://www.imbajin.com/Win10%E7%9A%84Linux%E5%AD%90%E7%B3%BB%E7%BB%9F%E5%AE%9E%E7%8E%B0%E5%8E%9F%E7%90%86/
# https://docs.docker.com/docker-for-windows/wsl/


# 时间序列数据库
# https://www.infoq.cn/article/database-timestamp-01
# https://zhuanlan.zhihu.com/p/29367404


拷貝/etc/passwd 這個文件到用戶自身的家目錄下（如yts用戶的家目錄為/home/yts）
在自家目錄下創建名為『my_homework』的目錄
將剛才拷貝到自家目錄下的passwd文件，連同屬性一併拷貝到名為『my_homework』的目錄中去，
分別命名為passwd，以及passwd_bak（兩個文件）
使用vim編輯器對『my_homework』目錄下的passwd文件進行編輯：
1.找出所有1001的字符串，修改為1000
2.找出自己的用戶名，並將最後的/bin/bash修改為/sbin/nologin
3.保存並且推出
4.輸入history命令，將先前的操作歷史進行截圖，上交作業。

備註：/home這個目錄雖然可以直接翻譯為家目錄，但是正常情況下（文件功能劃分），如果沒有特殊說明，家目錄，指的是/home目錄下的用戶家目錄。
（下面的可以不閱讀）
因為在用戶被創建後，在/home目錄下會同時創建該用戶的默認對應家目錄文件夾，除此之外/home目錄下不做其他文件夾和文件操作（包括創建），所以/home目錄準確來說是所有用戶的家目錄的集合。比如目前我給同朋們創建的測試用戶，都會在/home目錄下有對應的一個文件夾作為各自用戶的家目錄。（知識拓展：/root是root用戶的特殊家目錄，作為超級用戶，root的家目錄不在/home目錄下，而是/root[暗中观察]，我保存了一些腳本在那裡，沒事別亂搞我這個目錄，以免rm我的課件了）