
### linux
```shell
cd /usr/local/SecoClient
./SecoClient
```

### 下载
- https://forum.huawei.com/enterprise/zh/thread-864167.html

### UniVPN
- https://support.huawei.com/enterprise/zh/bulletins-website/ENEWS2000014193


### QA SecoClient报错接收返回码超时，Windows 无法验证此设备所需的驱动程序的数字签名。
- https://blog.csdn.net/qq_43108964/article/details/118889872
```text
1、此电脑->管理->设备管理器->SVN Adapter 右键禁用
2、进入 C:\Windows\System32\drivers 找到 SVNDrv.sys 文件并删除，删除后复制新的SVNDrv.sys到对应目录
```
