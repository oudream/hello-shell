
# 我在172.2.111.1的路由器（交换机+路由）下的设备（PC机），要访问其它交换机（对方网关192.168.0.245）的设备
# 要在172.2.111.1的路由器上添加一条路由
route add -net 192.168.0.0 netmask 255.255.255.0 gw 192.168.0.245 dev eth0.1

route -vCF

# https://blog.csdn.net/u011857683/article/details/83795435

# route命令用于显示和操作IP路由表

route [-CFvnee]

# 选项
-C    # 显示路由缓存。
-F    # 显示发送信息
-v    # 显示详细的处理信息。
-n    # 不解析名字。
-ee   # 使用更详细的资讯来显示
-V    # 显示版本信息。
-net  # 到一个网络的路由表。
-host # 到一个主机的路由表。


#

route [-v] [-A family] add [-net|-host] target [netmask Nm] [gw Gw] [metric N]
      [mss M] [window W] [irtt I] [reject] [mod] [dyn] [reinstate] [[dev] If]
route [-v] [-A family] del [-net|-host] target [gw Gw] [netmask Nm] [metric N] [[dev] If]
route [-V] [--version] [-h] [--help]

# route {add | del } [-net|-host] [网域或主机] netmask [mask] [gw|dev]

### e.g.
route
#  Kernel IP routing table
#  Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
#  172.16.3.201    192.168.93.1    255.255.255.255 UGH   20     0        0 eth0.1
#  172.16.3.223    192.168.93.1    255.255.255.255 UGH   20     0        0 eth0.1
#  172.17.0.0      *               255.255.0.0     U     0      0        0 docker0
#  192.168.93.0    *               255.255.255.0   U     0      0        0 eth0.1

# 添加一条路由(发往192.168.62这个网段的全部要经过网关192.168.1.1)
route add -net 172.16.3.202 netmask 255.255.255.255 gw 192.168.93.1 dev eth0.1
route -p add -net 172.16.3.202 netmask 255.255.255.255 gw 192.168.93.1 dev eth0.1
