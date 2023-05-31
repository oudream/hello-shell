
# Traffic Control（简称 TC）是 Linux 内核中的一个子系统，用于实现网络流量控制和 QoS（Quality of Service）功能。
# 它提供了一组工具和机制，用于管理和控制网络接口上的数据包流动，并对流量进行限制、调度和处理。

# 带宽限制（Bandwidth Limiting）：TC 可以通过配置流量规则，限制特定网络接口上的带宽使用。它可以控制上传和下载流量的速率，并确保带宽资源的公平分配。
#
# 优先级调度（Priority Scheduling）：TC 可以为不同类型的流量设置优先级，以确保关键流量或高优先级流量的传输具有更高的优先级。这有助于满足特定应用或服务对网络响应时间的要求。
#
# 延迟和丢包模拟（Delay and Packet Loss Simulation）：TC 可以模拟网络延迟和丢包，以测试应用程序或服务在不同网络条件下的性能表现。
#
# 队列管理（Queue Management）：TC 可以管理网络接口上的队列，对入站和出站的数据包进行排队和调度。它可以使用不同的队列算法，如 FIFO、SFQ（Stochastic Fairness Queuing）、HTB（Hierarchical Token Bucket）等。

ip link show

# 带宽限制
tc class add dev eth0 parent 1: classid 1:1 htb rate 10mbit burst 15k
tc qdisc add dev eth0 root handle 1: htb default 10

# 特定流量标记为高优先级
tc filter add dev eth0 parent 1: protocol ip prio 1 u32 match ip src 192.168.0.2 flowid 1:1
