#!/usr/bin/env bash

netstat -s | grep "packets received"  # 获得一些连接统计.
netstat -s | grep "packets delivered"

netstat -anp | grep 3306
netstat -nat | grep 3306 # mac
netstat -nat |grep LISTEN # mac
netstat -lntp # 查看所有监听端口
netstat -antp # 查看所有已经建立的连接
netstat -s # 查看网络统计信息
pstack 7013
# 通过pid查看占用端口
netstat -nap | grep pid
# 例：通过nginx进程查看对应的端口号
ps -ef | grep nginx
netstat -nap | grep nginx-pid
# 例：查看8081号端口对应的进程名
netstat -nap | grep 8081

# -l, --listening 显示监听状态的套接字 --tcp 仅显示 TCP套接字（sockets）
# -n --numeric 不解析服务名称
ss -ltn
# 显示TCP连接
ss -t -a
# 查看进程使用的socket
ss -pl



### netstat 命令用于显示各种网络相关信息，如网络连接，路由表，接口状态 (Interface Statistics)，masquerade 连接，
#       多播成员 (Multicast Memberships) 等等。

netstat [参数]
## 参数
# -a (all)显示所有选项，默认不显示LISTEN相关
# -t (tcp)仅显示tcp相关选项
# -u (udp)仅显示udp相关选项
# -n 拒绝显示别名，能显示数字的全部转化成数字。
# -l 仅列出有在 Listen (监听) 的服�兆刺�
#
# -p 显示建立相关链接的程序名
# -r 显示路由信息，路由表
# -e 显示扩展信息，例如uid等
# -s 按各个协议进行统计
# -c 每隔一个固定时间，执行该netstat命令。
#
# 提示：LISTEN和LISTENING的状态只有用-a或者-l才能看到

netstat -a         # 列出所有端口
netstat -at        # 列出所有 tcp 端口
netstat -au        # 列出所有 udp 端口
netstat -l         # 只显示监听端口
netstat -lt        # 只列出所有监听 tcp 端口
netstat -lx        # 只列出所有监听 UNIX 端口
netstat -s         # 显示所有端口的统计信息
netstat -c 1       # 将每隔一秒输出网络信息
netstat -r         # 显示核心路由信息

# 查看连接某服务端口最多的的IP地址
netstat -nat | grep "192.168.1.15:22" |awk '{print $5}'|awk -F: '{print $1}'|sort|uniq -c|sort -nr|head -20

# netstat 也能打印网络接口信息
netstat -ie

# 如果你想看看 http,smtp 或 ntp 服务是否在运行，使用 grep。
netstat -aple | grep ntp


### 根据 IP 查 hostname ( nbtstat(windows) , nmblookup ,
# https://stackoverflow.com/questions/657482/how-to-find-host-name-from-ip-with-out-login-to-the-host/34886671#34886671

# It depends on the context. I think you're referring to the operating system's hostname
# (returned by hostname when you're logged in). This command is for internal names only, so to query
# for a machine's name requires different naming systems. There are multiple systems which use names
# to identify hosts including DNS, DHCP, LDAP (DN's), hostname, etc. and many systems use zeroconf to
# synchronize names between multiple naming systems. For this reason, results from hostname will
# sometimes match results from dig (see below) or other naming systems, but often times they will not
# match.
#
# DNS is by far the most common and is used both on the internet (like google.com. A 216.58.218.142) and at home (mDNS/LLMNR), so here's how to perform a reverse DNS lookup: dig -x <address> (nslookup and host are simpler, provide less detail, and may even return different results; however, dig is not included in Windows).
#
# Note that hostnames within a CDN will not resolve to the canonical domain name (e.g. "google.com"), but rather the hostname of the host IP you queried (e.g. "dfw25s08-in-f142.1e100.net"; interesting tidbit: 1e100 is 1 googol).
#
# Also note that DNS hosts can have more than one name. This is common for hosts with more than one webserver (virtual hosting), although this is becoming less common thanks to the proliferation of virtualization technologies. These hosts have multiple PTR DNS records.
#
# Finally, note that DNS host records can be overridden by the local machine via /etc/hosts. If you're not getting the hostname you expect, be sure you check this file.
#
# DHCP hostnames are queried differently depending on which DHCP server software is used, because (as far as I know) the protocol does not define a method for querying; however, most servers provide some way of doing this (usually with a privileged account).
#
# Note DHCP names are usually synchronized with DNS server(s), so it's common to see the same hostnames in a DHCP client least table and in the DNS server's A (or AAAA for IPv6) records. Again, this is usually done as part of zeroconf.
#
# Also note that just because a DHCP lease exists for a client, doesn't mean it's still being used.
#
# NetBIOS for TCP/IP (NBT) was used for decades to perform name resolution, but has since been replaced by LLMNR for name resolution (part of zeroconf on Windows). This legacy system can still be queried with the nbtstat (Windows) or nmblookup (Linux).

python -c "import socket;print(socket.gethostbyaddr('127.0.0.1'))"

# windows
nbtstat -A 10.100.3.104
ping -a 10.100.3.104

# 在Linux下利用反向DNS协议
# NetBIOS tools ( nbtscan )
nmblookup -A 10.100.3.104
nslookup 10.0.0.5
nslookup # <==进入 nslookup 查询画面
# > 120.114.100.20
# <==执行反解的查询
# > www.ksu.edu.tw
# <==执行正解的查询

# 来看看dns查询过程
dig +trace www.baidu.com
# 查询 112.80.248.73(百度) 反解析,反查
dig -x 112.80.248.73

# 查出 百度的所有重要参数
host -a www.baidu.com
# 强制以 139.175.10.20 这部 DNS 服务器来查询
host linux.vbird.org 139.175.10.20
