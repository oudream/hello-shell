
# 我在172.2.111.1的路由器（交换机+路由）下的设备（PC机），要访问其它交换机（对方网关192.168.0.245）的设备
# 要在172.2.111.1的路由器上添加一条路由
route add -net 192.168.0.0 netmask 255.255.255.0 gw 192.168.0.245 dev eth0.1

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

route [-v] [-A family] add [-net|-host] target [netmask Nm] [gw Gw] [metric N]
      [mss M] [window W] [irtt I] [reject] [mod] [dyn] [reinstate] [[dev] If]
route [-v] [-A family] del [-net|-host] target [gw Gw] [netmask Nm] [metric N] [[dev] If]
route [-V] [--version] [-h] [--help]

# route {add | del } [-net|-host] [网域或主机] netmask [mask] [gw|dev]
# 添加一条路由(发往192.168.62这个网段的全部要经过网关192.168.1.1)
route add -net 172.16.3.202 netmask 255.255.255.255 gw 192.168.93.1 dev eth0.1
route -p add -net 172.16.3.202 netmask 255.255.255.255 gw 192.168.93.1 dev eth0.1


### 查询路由信息
route
route -vCF
routel
#          target            gateway          source    proto    scope    dev tbl
  #        default         14.21.56.1                   kernel           vmbr0
  #    14.21.56.0/ 27                      14.21.56.4   kernel     link  vmbr0
  #  192.168.11.0/ 24                    192.168.11.1   kernel     link  vmbr1
  #     14.21.56.4              local      14.21.56.4   kernel     host  vmbr0 local
  #    14.21.56.31          broadcast      14.21.56.4   kernel     link  vmbr0 local
  #     127.0.0.0/ 8            local       127.0.0.1   kernel     host     lo local
  #      127.0.0.1              local       127.0.0.1   kernel     host     lo local
  #127.255.255.255          broadcast       127.0.0.1   kernel     link     lo local
  #   192.168.11.1              local    192.168.11.1   kernel     host  vmbr1 local
  # 192.168.11.255          broadcast    192.168.11.1   kernel     link  vmbr1 local
  #            ::1                                      kernel              lo
  #        fe80::/ 64                                   kernel           vmbr0
  #        fe80::/ 64                                   kernel           vmbr1
  #            ::1              local                   kernel              lo local

# 默认路由（default）指向网关地址 14.21.56.1，通过网络接口 vmbr0。
  #子网 14.21.56.0/27 的数据包被直接连接到本地网络接口 vmbr0。
  #子网 192.168.11.0/24 的数据包被直接连接到本地网络接口 vmbr1。
  #本地地址 14.21.56.4 在本地主机上。
  #广播地址 14.21.56.31 在本地网络接口 vmbr0 上。
  #本地回环地址 127.0.0.0/8 在本地主机上。
  #本地地址 127.0.0.1 在本地主机上。
  #本地回环广播地址 127.255.255.255 在本地回环接口上。
  #本地地址 192.168.11.1 在本地主机上。
  #广播地址 192.168.11.255 在本地网络接口 vmbr1 上。
  #IPv6 地址 ::1 在本地主机上。
  #IPv6 子网 fe80::/64 在网络接口 vmbr0 上。
  #IPv6 子网 fe80::/64 在网络接口 vmbr1 上。
  #IPv6 地址 ::1 在本地主机上。
