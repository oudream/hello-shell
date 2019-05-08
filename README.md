# cshell
systemctl enable test.service
# 以上命令相当于执行以下命令，把test.service添加到开机启动中
$ sudo ln -s  '/etc/systemd/system/test.service'  '/etc/systemd/system/multi-user.target.wants/test.service' 
--------------------- 
作者：Tab609 
来源：CSDN 
原文：https://blog.csdn.net/luckytanggu/article/details/53467687 
版权声明：本文为博主原创文章，转载请附上博文链接！

wget –no-check-certificate  https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks.sh
