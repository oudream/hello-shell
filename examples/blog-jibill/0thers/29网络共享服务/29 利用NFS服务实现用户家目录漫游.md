@[TOC](目录)


# 利用NFS服务实现用户家目录漫游

1. 实验环境：
NFS服务器：192.168.99.103
客户端A：192.168.99.101
客户端B：192.168.99.102

<table><td bgcolor='orange'> NFS服务器：192.168.99.103 </td></table>

1. 创建用户wang
```sh
[103]$ useradd wang
```

2. 安装nfs工具
```sh
[103]$ yum -y install nfs-utils
```
3. 修改配置
```sh
[103]$ vim /etc/exports.d/test.exports
    /home/wang *(rw,anonuid=1000,anongid=1000,all_squash)
```
3. 启动服务
```sh
[103]$ systemctl restart nfs-server
```
4. 每次修改完后，只需要加载配置文件就可以了，用这条命令
```sh
[103]$ exportfs -r
```

<table><td bgcolor='orange'> 客户端A：192.168.99.101 </td></table>

1. 这边也要创建用户
```sh
[101]$ useradd wang
```
2. 安装NFS工具
```sh
[101]$ yum -y install nfs-utils
```
3. 查看NFS服务器共享的目录
```sh
[101]$ showmount -e 192.168.99.103
Export list for 192.168.99.103:
/home/wang *(rw,anonuid=1000,anongid=1000,all_squash)
```
4. 挂载
```sh
[101]$ mount 192.168.99.103:/home/wang /home/wang
```
5. 切换用户
```sh
[101]$ su - wang
```
6. 在wang家目录上创建个文件，可以写，
```sh
[wang@localhost ~]$ touch 101
[wang@localhost ~]$ ls
101
```

<table><td bgcolor='orange'> 客户端B：192.168.99.102 </td></table>

1，2，3，4和客户端A一模一样

5. 切换用户
```sh
[102]$ su - wang
```
6. 创建个文件，并看看有没有客户端101上创建的文件
```sh
[wang@localhost ~]$ touch 102
[wang@localhost ~]$ ls
101 102
```

<table><td bgcolor='orange'> 客户端A：192.168.99.101 </td></table>

下面实现autofs自动挂载
1. 要先安装autofs
```sh
[101]$ yum -y install autofs
```
2. 在主配置文件添加这条
```sh
[101]$ cat /etc/auto.master
...
  8 /-   /etc/auto.master.d/auto.home.wang
...
```

3. 在子配置文件`/etc/auto.master.d/auto.home.wang`
```sh
[101]$ cat /etc/auto.master.d/auto.home.wang
/home/wang  -fstype=nfs,rw  192.168.99.103:/home/wang
```


