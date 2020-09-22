
### install in ubuntu
# 1.安装samba
sudo apt-get install samba
# 2.修改samba的配置文件
sudo vi /etc/samba/smb.conf

cat >> /etc/samba/smb.conf <<EOF
[share1]
path=/home
public=no
writable=yes
valid user=oudream

[share2]
path=/opt
public=no
writable=yes
valid user=oudream
EOF

# 3.添加用户和密码：
sudo smbpasswd -a oudream
# 根据提示输入密码

# 4.在windows->计算机，点击映射网络驱动器；输入\\192.168.1.102\share(请根据自己的ip和共享文件夹标识调整)。
# 此时，就可以在windows上看到linux共享的文件夹了。