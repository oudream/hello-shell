
# https://www.howtoing.com/how-to-install-and-configure-vnc-remote-access-for-the-gnome-desktop-on-centos-7


# 避免一些系统方面的意外错误，最好更新yum到最新，生产环境有业务在运行不建议更新
yum update

# 安装GNOME Desktop图形桌面服务
yum groupinstall "GNOME Desktop"

# 安装vnc
yum install tigervnc-server

# 查看系统运行模式
systemctl get-default

# 切换到桌面运行模式
systemctl set-default graphical.target

# 启动桌面模式
init 5

# 设置桌面运行模式为默认启动模式
ln -sf /lib/systemd/system/graphical.target /etc/systemd/system/default.target

###
# 设置vnc用systemctl来管理(第一个用户vncserver@:1.service,第二个用户vncserver@:2.service,其他以此类推)
cp /lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@:1.service
# 修改vnc用户为root(其他系统用户也可以这样改)
vi /etc/systemd/system/vncserver@:1.service
## or
cat > /etc/systemd/system/vncserver@:1.service <<EOF
[Unit]
Description=Remote desktop service (VNC)
After=syslog.target network.target

[Service]
Type=forking
# Clean any existing files in /tmp/.X11-unix environment
ExecStartPre=/bin/sh -c '/usr/bin/vncserver -kill %i > /dev/null 2>&1 || :'
ExecStart=/usr/sbin/runuser -l root -c "/usr/bin/vncserver %i"
PIDFile=/root/.vnc/%H%i.pid
ExecStop=/bin/sh -c '/usr/bin/vncserver -kill %i > /dev/null 2>&1 || :'

[Install]
WantedBy=multi-user.target
EOF

# 刷新systemctl

systemctl daemon-reload

# 设置vnc密码(第二个用户修改密码，vncpasswd user2,其他以此类推)
vncpasswd

# 修改vnc黑名单限制，否则会出现vnc客户端连接不上的情况(/etc/sysconfig/vncservers)
#  1 # THIS FILE HAS BEEN REPLACED BY /lib/systemd/system/vncserver@.service
#  2 VNCSERVERS="1:root"
#  3 VNCSERVERARGS[1]="-geometry 1024x768 -BlacklistTimeout 0"

# 防火墙放行端口(vnc端口第一个用户5901，创建第二个用户5902，其他以此类推)

firewall-cmd --zone=public --add-port==5900-5905/tcp --permanent

# 防火墙放行vnc服务
firewall-cmd --add-service vnc-server

# 放行好端口和服务，重启防火墙才能生效
firewall-cmd --reload

# 查看端口是否放行成功
firewall-cmd --list-port

# 启动，关闭，重启vnc
systemctl start vncserver@:1.service # 启动
systemctl stop vncserver@:1.service # 关闭
systemctl restart vncserver@:1.service # 重启
systemctl enable vncserver@:1.service # 自启动
systemctl disable vncserver@:1.service # 停止服务
