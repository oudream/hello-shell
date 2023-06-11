# 配置欢迎信息的文件：
```shell
/etc/issue                # 修改该文件后，在服务器上直接登入Linux可以查看到。
/etc/issue.net            # 修改该文件后，telnet登入Linux后，可以查看到。
/etc/motd                 # 修改该文件后，任何用户登入后，都可以看到信息
/etc/ssh/ssh_login_banner # 修改该文件后，ssh登入后可以看到的信息，该文件只自己创建的，见后文
```

### /etc/issue，/etc/issue.net，/etc/motd修改中，可以使用如下符号
```shell
\d 本地端时间的日期；
\l 显示第几个终端机接口；
\m 显示硬件的等级 (i386/i486/i586/i686…)；
\n 显示主机的网络名称；
\o 显示 domain name；
\r 操作系统的版本 (相当于 uname -r)
\t 显示本地端时间的时间；
\s 操作系统的名称；
\v 操作系统的版本
```

### SSH登入修改欢迎信息
```text
修改ssh的配置文件/etc/ssh/sshd_config

vim /etc/ssh/sshd_config

找到如下信息，设置欢迎信息的文件
#no default banner path
Banner /etc/ssh/ssh_login_banner

创建该文件并且编辑该文件
vim /etc/ssh/ssh_login_banner

添加完欢迎信息后，保存退出，并且重启sshd服务器
systemctl restart sshd.service

设置完成后，退出在登入，即可看到相应的信息。
```

