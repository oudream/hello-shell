# cshell
systemctl enable test.service
# 以上命令相当于执行以下命令，把test.service添加到开机启动中
$ sudo ln -s  '/etc/systemd/system/test.service'  '/etc/systemd/system/multi-user.target.wants/test.service' 

wget –no-check-certificate  https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks.sh

#
https://github.com/fengyuhetao/shell
https://github.com/chaoqing/abs-guide-cn

