#!/usr/bin/env bash



### svn
# svn checkout path # 1、将文件checkout到本地目录（path是服务器上的目录） 简写：svn co
svn checkout svn://192.168.1.1/pro/domain /ddd/localpath
# svn add file # 2、往版本库中添加新的文件
svn add test.php # (添加test.php)
svn add *.php # (添加当前目录下所有的php文件)
# svn commit -m "LogMessage" [-N] [--no-unlock] PATH # 3、将改动的文件提交到版本库 (如果选择了保持锁，就使用--no-unlock开关) 简写：svn ci
svn commit -m "add test file for my test" test.php
# svn lock -m "LockMessage" [--force] PATH # 4、加锁/解锁
svn lock -m "lock test file" test.php
svn unlock PATH
# svn update -r m path # 5、更新到某个版本 简写：svn up
svn update # 如果后面没有目录，默认将当前目录以及子目录下的所有文件都更新到最新版本。
svn update -r 200 test.php # (将版本库中的文件test.php还原到版本200)
svn update test.php # (更新，于版本库同步。如果在提交的时候提示过期的话，是因为冲突，需要先update，修改文件，然后清除svn resolved，最后再提交commit)
# 1）svn status path # 6、查看文件或者目录状态（目录下的文件和子目录的状态，正常状态不显示）【?：不在svn的控制中；M：内容被修改；C：发生冲突；A：预定加入到版本库；K：被锁定】
# 2）svn status -v path # (显示文件和子目录状态) 简写：svn st
# 第一列保持相同，第二列显示工作版本号，第三和第四列显示最后一次修改的版本号和修改人。
# 注：svn status、svn diff和 svn revert这三条命令在没有网络的情况下也可以执行的，原因是svn在本地的.svn中保留了本地版本的原始拷贝。
# svn delete path -m "delete test fle" # 7、删除文件 简写：svn (del, remove, rm)
svn delete svn://192.168.1.1/pro/domain/test.php -m "delete test file" # 或者直接svn delete test.php 然后再svn ci -m 'delete test file‘，推荐使用这种
# svn log path # 8、查看日志
svn log test.php # 显示这个文件的所有修改记录，及其版本号的变化
# svn info path # 9、查看文件详细信息
svn info test.php
# svn diff path # 10、比较差异 (将修改的文件与基础版本比较) 简写：svn di
svn diff test.php
# svn diff -r m:n path # (对版本m和版本n比较差异)
svn diff -r 200:201 test.php
# svn merge -r m:n path # 11、将两个版本之间的差异合并到当前文件
svn merge -r 200:205 test.php #（将版本200与205之间的差异合并到当前文件，但是一般都会产生冲突，需要处理一下）
svn help # 12、SVN 帮助
svn help ci

