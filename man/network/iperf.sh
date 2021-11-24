#!/usr/bin/env bash

iperf -c 45.77.131.42 -p 20307 -i 1 -t 10
iperf -c hkt.thatseed.org -p 30309 -i 1 -t 10

# iperf  是一个网络性能测试工具
# iperf可以测试TCP和UDP带宽质量。iperf可以测量最大TCP带宽，具有多种参数和UDP特性。iperf可以报告带宽，延迟抖动和数据包丢失。
# install
brew install iperf      # macos
sudo apt install iperf  # ubuntu

# CentOS 7
更新系统&安装wget
yum -y update
yum -y install wget
# 安装Iperf
yum -y install gcc make
cd /tmp
wget https://iperf.fr/download/source/iperf-3.1.3-source.tar.gz
tar zxvf iperf-3.1.3-source.tar.gz
cd iperf-3.1.3
./configure
make
make install
# 设置自动启动
chmod +x /etc/rc.d/rc.local
vi /etc/rc.d/rc.local
# 添加
/usr/local/bin/iperf3 -s -D
# 打开端口：5201
firewall-cmd --zone=public --add-port=5201/tcp --permanent
firewall-cmd --reload

# 运行服务端
iperf -s
# 运行客户端
iperf -c 127.0.0.1 -p 22
# 默认情况下，会使用 TCP 连接，绑定在 5001 端口上，可以从上述结果看到，当前本机的带宽为 30.1 Gbits/sec 。

# 主要参数信息
## 适用于 服务端/客户端
# -f 指定数据显示格式 [k|m|K|M] 分别表示 Kbits、Mbits、KBytes、MBytes，默认是 Mbits
# -l 读写缓冲区的大小，默认是 8K
# -u 使用 udp 协议
# -i 以秒为单位统计带宽值
# -m 显示最大的 TCP 数据段大小
# -p 指定服务端或者客户端的端口号
# -w 指定 TCP 窗口大小
# -B 绑定道指定的主机地址或接口
# -C 兼容旧版本
# -M 设置 TCP 数据包的最大 MTU 值
# -V 传输 IPV6 包
## 适用于 服务端
# -s 以服务器模式启动
# -U 单线程 UDP 模式
# -D 以守护进程模式运行
## 适用于 客服端
# -c 以客户端模式运行，并指定服务端的地址
# -b 指定客户端通过 UDP 协议发送信息的带宽，默认为 1Mbit/s
# -d 同时进行双向传输测试
# -n 指定传输的字节数
# -r 单独进行双向传输测试
# -t 指定 iperf 测试的时间，默认 10s
# -F 指定要传输的文件
# -L 指定一个端口，服务利用这端口与客户端连接
# -P 指定客户端到服务器的连接数，默认是 1
# -T 指定 ttl 值
# 用 -u 参数来指定使用 UDP 协议，需要在 -p 参数之前指定

运行客户端
iperf -c 172.18.142.62 -i 1 -t 10

**UDP 协议测试带宽**
运行服务端
$ iperf -u -s
运行客户端
$ iperf -c 172.18.142.62 -u -i 1 -t 10 -b 30M

