
###
```text
由于图形界面一直安装不上（比如从程序和功能–> 启用或关闭windows功能–>勾选.NetFramework 3.5），返回的错误是：
拒绝访问。
错误代码：0x80070005
因此怀疑是没有权限。于是打开管理员的cmd，输入网上找来的命令安装成功！
```
- 输入以下命令
```shell
DISM /Online /Enable-Feature /FeatureName:NetFx3 /All /LimitAccess /Source:J:\sources\sxs
#/Online 指定在正在运行的操作系统中启用相关功能
#/Enable-Feature /FeatureName:NetFx3 指定启用.NET framework 3.5
#/All 启用.NET framework 3.5的所有父功能
#/LimitAccess 阻止DISM与Windows Update连接
#/Source 指定需要启用功能的位置。随意选择一个window10的iso文件打开，复制其目录下的sources/sxs路径为source路径
```
