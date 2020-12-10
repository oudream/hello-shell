rem    用法: tracert [-d] [-h maximum_hops] [-j host-list] [-w timeout]
rem                   [-R] [-S srcaddr] [-4] [-6] target_name
rem
rem    选项:
rem        -d                 不将地址解析成主机名。
rem        -h maximum_hops    搜索目标的最大跃点数。
rem        -j host-list       与主机列表一起的松散源路由(仅适用于 IPv4)。
rem        -w timeout         等待每个回复的超时时间(以毫秒为单位)。
rem        -R                 跟踪往返行程路径(仅适用于 IPv6)。
rem        -S srcaddr         要使用的源地址(仅适用于 IPv6)。
rem        -4                 强制使用 IPv4。
rem        -6                 强制使用 IPv6。

rem 通过向目标发送不同 IP 生存时间 (TTL) 值的“Internet 控制消息协议 (ICMP)”回应数据包，Tracert 诊断程序确定到目标所采取的路由。
rem 要求路径上的每个路由器在转发数据包之前至少将数据包上的 TTL 递减 1。数据包上的 TTL 减为 0 时，路由器应该将“ICMP 已超时”的消息发回源系统。
rem
rem Tracert 先发送 TTL 为 1 的回应数据包，并在随后的每次发送过程将 TTL 递增 1，直到目标响应或 TTL 达到最大值，从而确定路由。
rem 通过检查中间路由器发回的“ICMP 已超时”的消息确定路由。某些路由器不经询问直接丢弃 TTL 过期的数据包，这在 Tracert 实用程序中看不到。
rem
rem Tracert 命令按顺序打印出返回“ICMP 已超时”消息的路径中的近端路由器接口列表。如果使用 -d 选项，则 Tracert 实用程序不在每个 IP 地址上查询 DNS。

