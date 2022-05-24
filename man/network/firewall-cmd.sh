
# https://wangchujiang.com/linux-command/c/firewall-cmd.html

firewall-cmd --state
firewall-cmd --get-active-zones # 查看当前区域
firewall-cmd --set-default-zone=home # 设置为家庭区域
firewall-cmd --get-zone-of-interface=eth0 # 设备置当前区域的接口
firewall-cmd --permanent --zone=internal --change-interface=enp03s # 永久修改网络接口enp03s为内部区域（internal）
firewall-cmd --list-all
firewall-cmd --permanent --add-port=9000/tcp
firewall-cmd --reload

# 安装firewalld 防火墙
yum install firewalld

# 开启服务
systemctl start firewalld.service

# 关闭防火墙
systemctl stop firewalld.service

# 开机自动启动
systemctl enable firewalld.service

# 关闭开机制动启动
systemctl disable firewalld.service

### firewall-cmd
# 查看状态
firewall-cmd --state

# 获取活动的区域
firewall-cmd --get-active-zones

# 获取所有支持的服务
firewall-cmd --get-service

# 在不改变状态的条件下重新加载防火墙
firewall-cmd --reload

# 启用某个服务
# 临时
firewall-cmd --zone=public --add-service=https
# 永久
firewall-cmd --permanent --zone=public --add-service=https

# 开启某个端口
# 永久
firewall-cmd --permanent --zone=public --add-port=8080-8081/tcp
firewall-cmd --permanent --zone=public --add-port=5036/tcp
# 临时
firewall-cmd --zone=public --add-port=8080-8081/tcp

# 使用命令加载设置
firewall-cmd --reload

# 查看开启的端口和服务
# 服务空格隔开 例如 dhcpv6-client https ss
firewall-cmd --permanent --zone=public --list-services
# 端口空格隔开 例如 8080-8081/tcp 8388/tcp 80/tcp
firewall-cmd --permanent --zone=public --list-ports

# 设置某个ip 访问某个服务
firewall-cmd --permanent --zone=public --add-rich-rule="rule family="ipv4" source address="192.168.0.4/24" service name="http" accept" ip 192.168.0.4/24 访问 http

# 删除上面设置的规则
firewall-cmd --permanent --zone=public --remove-rich-rule="rule family="ipv4" source address="192.168.0.4/24" service name="http" accept"

# 检查设定是否生效
iptables -L -n | grep 21
# ACCEPT     tcp  --  0.0.0.0/0            0.0.0.0/0            tcp dpt:21 ctstate NEW

# 执行命令
firewall-cmd --list-all
# 显示：
#  public (default)
#    interfaces:
#    sources:
#    services: dhcpv6-client ftp ssh
#    ports:
#    masquerade: no
#    forward-ports:
#    icmp-blocks:
#    rich rules:

# 查询服务的启动状态
firewall-cmd --query-service ftp
#   yes

firewall-cmd --query-service ssh
#   yes

firewall-cmd --query-service samba
#   no

firewall-cmd --query-service http
#   no

# 自行加入要开放的 Port
firewall-cmd --add-port=3128/tcp
firewall-cmd --list-all
#  public (default)
#    interfaces:
#    sources:
#    services: dhcpv6-client ftp ssh
#    ports: 3128/tcp
#    masquerade: no
#    forward-ports:
#    icmp-blocks:
#    rich rules:
#
