
# 扫描IP
nmap -sn 10.50.52.1-255
nmap -sn 10.50.53.1-255
nmap -sn 192.168.2.0/24

nmap -sn 192.169.0.1-255

nmap -p 1-65535 -v 192.168.2.45

yum install nmap

# 扫描1-200号端口
# shellcheck disable=SC2218
nmap -p1-200 10.128.71.1

# -vv 参数表示结果详细输出
nmap -vv 10.132.71.1

# 使用ping方式扫描（不扫描端口）
nmap -sP ip_address

# 路由跟踪
nmap --traceroute  ip_address  

# 扫描一个网段（使用ping）
nmap -sP xx.xx.xx.xx/24 

# 也可以扫描一个网段（使用ping）
nmap -sP 10.1.1.1-255  

# TCP contect()端口扫描
nmap -sT ip_address

# UDP端口扫描
nmap -sU ip_address  

# TCP同步（SYN）端口扫描
nmap -sS ip_address  

# 扫描一个网段使用默认端口扫描，结果同下面脚本
nmap 10.1.1.1/24  

### nmap(选项)(参数)
-O             # 激活操作探测；
-P0            # 值进行扫描，不ping主机；
-PT            # 是同TCP的ping；
-sV            # 探测服务版本信息；
-sP            # ping扫描，仅发现目标主机是否存活；
-ps            # 发送同步（SYN）报文；
-PU            # 发送udp ping；
-PE            # 强制执行直接的ICMPping；
-PB            # 默认模式，可以使用ICMPping和TCPping；
-6             # 使用IPv6地址；
-v             # 得到更多选项信息；
-d             # 增加调试信息地输出；
-oN            # 以人们可阅读的格式输出；
-oX            # 以xml格式向指定文件输出信息；
-oM            # 以机器可阅读的格式输出；
-A             # 使用所有高级扫描选项；
--resume       # 继续上次执行完的扫描；
-P             # 指定要扫描的端口，可以是一个单独的端口，用逗号隔开多个端口，使用“-”表示端口范围；
-e             # 在多网络接口Linux系统中，指定扫描使用的网络接口；
-g             # 将指定的端口作为源端口进行扫描；
--ttl          # 指定发送的扫描报文的生存期；
--packet-trace # 显示扫描过程中收发报文统计；
--scanflags    # 设置在扫描报文中的TCP标志
