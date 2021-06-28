
### ubuntu-18.04 root登录图形界面 
- https://blog.csdn.net/xiongchun11/article/details/80606106
```text
默认安装Ubuntu18.04都是不允许以root用户进行登录的，想要以root用户进行登录需要进行一些操作，主要是以下几个步骤：
第一步：以普通用户登录系统，创建root用户的密码
在终端输入命令：sudo passwd root
然后输入你要设置的密码，这样就完成了设置root用户密码的步骤

默认安装Ubuntu16.04的文件： /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf
第二步：修改文件/usr/share/lightdm/lightdm.conf.d/50-unity-greeter.conf文件，增加两行：
greeter-show-manual-login=true
all-guest=false
保存

第三步：进入/etc/pam.d目录，修改gdm-autologin和gdm-password文件
vi gdm-autologin
注释掉auth required pam_succeed_if.so user != root quiet_success这一行，保存
vi gdm-password
注释掉 auth required pam_succeed_if.so user != root quiet_success这一行，保存

第四步：修改/root/.profile文件
vi /root/.profile
将文件末尾的mesg n || true这一行修改成tty -s&&mesg n || true， 保存

第五步：重启系统，输入root用户名和密码，登录系统。
```


```text
auto 
```

### Could not resolve 'mirrors.aliyun.com'
- 1.vim /etc/resolv.conf在文件后面添加：
nameserver 8.8.8.8
nameserver 8.8.4.4
sudo /etc/init.d/networking restart