
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
