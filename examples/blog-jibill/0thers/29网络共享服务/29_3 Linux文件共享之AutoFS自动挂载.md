@[TOC](目录)

# autofs自动挂载
>可使用autofs按需要挂载NFS共享，在空闲时自动卸载

1. yum安装方法`yum install autofs`
2. 系统管理器指定由`/etc/auto.master`自动挂载器守护进程控制的挂载点
3. 自动挂载监视器访问这些目录并按要求挂载文件系统
4. 文件系统在失活的指定间隔5分钟后会自动卸载
5. 为所有导出到网络中的NFS启用特殊匹配 -host 至“browse”
6. 参看帮助：man 5 autofs
7. 支持含通配符的目录名
    `*` server:/export/&

## 神奇目录
之前说到的光盘自动的神奇目录`/misc/cd`这个目录，只要进入这个目录就自动挂载光盘，这是怎么做到的呢
1. 在配置文件里有这么一句
```sh
[101]$ cat /etc/auto.master
...
/misc   /etc/auto.misc
...
#dirname     #子配置文件位置
```

2. 那这个子配置里面写了啥，看看
```sh
[101]$ cat /etc/auto.misc
...
cd   -fstype=iso9660,ro,nosuid,nodev :/dev/cdrom
...
#basename   -fstype=类型,选项    挂载的源
```

**还有一个神奇目录**
想要临时访问远程主机上的共享，不用挂载，直接进入/net/目录下加你要访问的远程IP的主机
```sh
[101]$ cd /net/192.168.99.103

[101]$ ls
data  home
```

这是因为在配置文件里，有这么一句话
```sh
[101]$ cat /etc/auto.master
...
    /net   -hosts
...
```

## 绝对路径与相对路径
1. 相对路径
像上面神奇目录那样的写法就是相对路径的写法
```sh
#把dirname写在/etc/auto.master下
/misc    /etc/auto.misc
```
还可以这么写，`*`表示任意的字符串，后面的`&`表示前面`*`，
```sh
*   -fstype=nfs,rw   192.168.99.103:/home/&
```

但写相对路径，会有一个问题，`/misc`下的所有目录都会消失。 这是因为`/misc`下的目录都由autofs接管。
```sh
[101]$ ls /home
wang
```
家目录下还有其它的用户，但是却看不到了。

怎么解决呢？用绝对路径

2. 绝对路径
master配置文件加上这条
```sh
[101]$ cat /etc/auto.master
/-   /etc/auto.master.d/auto.home.wang
```
在你写的子配置文件写
```sh
[101]$ cat /etc/auto.master.d/auto.home.wang
/home/wang  -fstype=nfs,rw  192.168.99.103:/home/wang
```

记得写完重启服务
```sh
systemctl restart autofs
```
