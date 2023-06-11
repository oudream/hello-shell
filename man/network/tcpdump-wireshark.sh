#!/usr/bin/env bash

tcpdump -i vmbr1 host 192.168.11.110 and port 4001 -v -w 110.pcap
tcpdump -i any -n -nn host 172.17.0.1 and port 15623 -w ./$(date +%Y%m%d%H%M%S).pcap

tcpdump port 2404 -w ./$(date +%Y%m%d%H%M%S).pcap

tcpdump port 2402 -w ./$(date +%Y%m%d%H%M%S).pcap


# compile and install
# https://pkgs.org/download/tcpdump
# http://www.tcpdump.org/index.html
# https://github.com/the-tcpdump-group/tcpdump
# https://github.com/the-tcpdump-group/libpcap


tcpdump [ -AbdDefhHIJKlLnNOpqStuUvxX# ] [ -B buffer_size ]
        [ -c count ]
        [ -C file_size ] [ -G rotate_seconds ] [ -F file ]
        [ -i interface ] [ -j tstamp_type ] [ -m module ] [ -M secret ]
        [ --number ] [ -Q in|out|inout ]
        [ -r file ] [ -V file ] [ -s snaplen ] [ -T type ] [ -w file ]
        [ -W filecount ]
        [ -E spi@ipaddr algo:secret,...  ]
        [ -y datalinktype ] [ -z postrotate-command ] [ -Z user ]
        [ --time-stamp-precision=tstamp_precision ]
        [ --immediate-mode ] [ --version ]
        [ expression ]

# tcpdump 默认只会截取前 96 字节的内容，要想截取所有的报文内容，可以使用 -s number， number
#    就是你要截取的报文字节数，如果是 0 的话，表示截取报文全部内容。
#
# -n 表示不要解析域名，直接显示 ip。
# -nn 不要解析域名和端口
# -X 同时用 hex 和 ascii 显示报文的内容。
# -XX 同 -X，但同时显示以太网头部。
# -S 显示绝对的序列号（sequence number），而不是相对编号。
# -i any 监听所有的网卡
# -v, -vv, -vvv：显示更多的详细信息
# -c number: 截取 number 个报文，然后结束
# -A： 只使用 ascii 打印报文的全部数据，不要和 -X 一起使用。截取 http 请求的时候可以用
sudo tcpdump -nSA port 80


# 监听所有端口，直接显示 ip 地址。
tcpdump -nS

# 显示更详细的数据报文，包括 tos, ttl, checksum 等。
tcpdump -nnvvS

# 显示数据报的全部数据信息，用 hex 和 ascii 两列对比输出。
tcpdump -nnvvXS

# 过滤器也可以简单地分为三类：type, dir 和 proto。
# Type 让你区分报文的类型，主要由 host（主机）, net（网络） 和 port（端口） 组成。src 和 dst 也可以用来过滤报文的源地址和目的地址。

# host: 过滤某个主机的数据报文
tcpdump host 1.2.3.4
# src, dst: 过滤源地址和目的地址
tcpdump src 2.3.4.5
tcpdump dst 3.4.5.6
# net: 过滤某个网段的数据，CIDR 模式
tcpdump net 1.2.3.0/24
# proto: 过滤某个协议的数据，支持 tcp, udp 和 icmp。使用的时候可以省略 proto 关键字。
tcpdump icmp
# port: 过滤通过某个端口的数据报
tcpdump port 3389
# src/dst, port, protocol: 结合三者
tcpdump src port 1025 and tcp
tcpdump udp and src port 53

# port 范围
tcpdump portrange 21-23
# 数据报大小，单位是字节
tcpdump less 32
tcpdump greater 128
tcpdump > 32
tcpdump <= 128

# 输出到文件
# -w 选项用来把数据报文输出到文件，比如下面的命令就是把所有 80 端口的数据导入到文件
sudo tcpdump -w capture_file.pcap port 80
# -r 可以读取文件里的数据报文，显示到屏幕上。
tcpdump -nXr capture_file.pcap host web30
# NOTE：保存到文件的数据不是屏幕上看到的文件信息，而是包含了额外信息的固定格式 pcap，需要特殊的软件来查看，
# 使用 vim 或者 cat 命令会出现乱码。

# 过滤的真正强大之处在于你可以随意组合它们，而连接它们的逻辑就是常用的 与/AND/&& 、 或/OR/|| 和 非/not/!。
# 源地址是 10.5.2.3，目的端口是 3389 的数据报
tcpdump -nnvS src 10.5.2.3 and dst port 3389
# 从 192.168 网段到 10 或者 172.16 网段的数据报
tcpdump -nvX src net 192.168.0.0/16 and dat net 10.0.0.0/8 or 172.16.0.0/16
# 从 Mars 或者 Pluto 发出的数据报，并且目的端口不是 22
tcpdump -vv src mars or pluto and not dat port 22

# 对于比较复杂的过滤器表达式，为了逻辑的清晰，可以使用括号。不过默认情况下，tcpdump 把 () 当做特殊的字符，所以必须使用单引号 ' 来消除歧义：
tcpdump -nvv -c 20 'src 10.0.2.4 and (dat port 3389 or 22)'

# 此外，上面的三条数据还是 tcp 协议的三次握手过程，第一条就是 SYN 报文，这个可以通过 Flags [S] 看出。下面是常见的 TCP 报文的 Flags:
# [S]： SYN（开始连接）
# [.]: 没有 Flag
# [P]: PSH（推送数据）
# [F]: FIN （结束连接）
# [R]: RST（重置连接）
# 而第二条数据的 [S.] 表示 SYN-ACK，就是 SYN 报文的应答报文。

# 打印所有进入或离开sundown的数据包.
tcpdump host sundown

# 也可以指定ip,例如截获所有210.27.48.1 的主机收到的和发出的所有的数据包
tcpdump host 210.27.48.1

# 打印helios 与 hot 或者与 ace 之间通信的数据包
tcpdump host helios and \( hot or ace \)

# 截获主机210.27.48.1 和主机210.27.48.2 或210.27.48.3的通信
tcpdump host 210.27.48.1 and \ (210.27.48.2 or 210.27.48.3 \)

# 打印ace与任何其他主机之间通信的IP 数据包, 但不包括与helios之间的数据包.
tcpdump ip host ace and not helios

# 如果想要获取主机210.27.48.1除了和主机210.27.48.2之外所有主机通信的ip包，使用命令：
tcpdump ip host 210.27.48.1 and ! 210.27.48.2

# 截获主机hostname发送的所有数据
tcpdump -i eth0 src host hostname

# 监视所有送到主机hostname的数据包
tcpdump -i eth0 dst host hostname


# 打印TCP会话中的的开始和结束数据包, 并且数据包的源或目的不是本地网络上的主机.(nt: localnet, 实际使用时要真正替换成本地网络的名字))
tcpdump 'tcp[tcpflags] & (tcp-syn|tcp-fin) != 0 and not src and dst net localnet'

# 打印所有源或目的端口是80, 网络层协议为IPv4, 并且含有数据,而不是SYN,FIN以及ACK-only等不含数据的数据包.(ipv6的版本的表达式可做练习)
tcpdump 'tcp port 80 and (((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0)'
# (nt: 可理解为, ip[2:2]表示整个ip数据包的长度, (ip[0]&0xf)<<2)表示ip数据包包头的长度(ip[0]&0xf代表包中的IHL域, 而此域的单位为32bit, 要换算

# 成字节数需要乘以4,　即左移2.　(tcp[12]&0xf0)>>4 表示tcp头的长度, 此域的单位也是32bit,　换算成比特数为 ((tcp[12]&0xf0) >> 4)　<<　２,　
# 即 ((tcp[12]&0xf0)>>2).　((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0　表示: 整个ip数据包的长度减去ip头的长度,再减去
# tcp头的长度不为0, 这就意味着, ip数据包中确实是有数据.对于ipv6版本只需考虑ipv6头中的'Payload Length' 与 'tcp头的长度'的差值, 并且其中表达方式'ip[]'需换成'ip6[]'.)

# 打印长度超过576字节, 并且网关地址是snup的IP数据包
tcpdump 'gateway snup and ip[2:2] > 576'

# 打印所有IP层广播或多播的数据包， 但不是物理以太网层的广播或多播数据报
tcpdump 'ether[0] & 1 = 0 and ip[16] >= 224'
# 打印除'echo request'或者'echo reply'类型以外的ICMP数据包( 比如,需要打印所有非ping 程序产生的数据包时可用到此表达式 .
# (nt: 'echo reuqest' 与 'echo reply' 这两种类型的ICMP数据包通常由ping程序产生))
tcpdump 'icmp[icmptype] != icmp-echo and icmp[icmptype] != icmp-echoreply'



### wireshark
# install on ubuntu
sudo add-apt-repository ppa:wireshark-dev/stable 
sudo apt update
sudo apt -y install wireshark
wireshark --version
