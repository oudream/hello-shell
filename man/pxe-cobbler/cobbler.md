
##### Cobbler通过将设置和管理一个安装服务器所涉及的任务集中在一起，从而简化了系统配置。

### 一、Cobbler简介
> Cobbler通过将设置和管理一个安装服务器所涉及的任务集中在一起，从而简化了系统配置。
> 相当于Cobbler封装了DHCP、TFTP、XINTED等服务，结合了PXE、kickstart等安装方法，可以实现自动化安装操作系统，
>并且可以同时提供多种版本，以实现在线安装不同版本的系统。



### 二、相关服务介绍
- 2.1 DHCP(**UDP67**和**UDP68**为正常的DHCP服务端口)：  
DHCP（Dynamic Host Configuration Protocol，动态主机配置协议）是一个局域网的网络协议，使用UDP协议工作， 
主要有两个用途：给内部网络或网络服务供应商自动分配IP地址，给用户或者内部网络管理员作为对所有计算机作中央管理的手段。
DHCP有3个端口，其中**UDP67**和**UDP68**为正常的DHCP服务端口，分别作为DHCP Server和DHCP Client的服务端口；
546号端口用于DHCPv6 Client，而不用于DHCPv4，是为DHCP failover服务，这是需要特别开启的服务，
DHCP failover是用来做“双机热备”的。



- 2.2 TFTP(**TFTP的端口设置为69**)：  
TFTP是一种比较特殊的文件传输协议。相对于FTP和目前经常使用的SFTP，TFTP是基于TCP/IP协议簇，用于进行简单文件传输，提供简单、低开销的传输服务。TFTP的端口设置为69。
相对于常见的FTP，TFTP有两个比较好的优势：
    1. TFTP基于UDP协议，如果环境中没有TCP协议，是比较合适的；
    2. TFTP执行和代码占用内存量比较小；

默认情况下，Linux内部是安装了tftp服务器包的。但是默认是不启动的。



- 2.3 PXE：
> 预启动执行环境（Preboot eXecution Environment，PXE，也被称为预执行环境)提供了一种使用网络接口（Network Interface）启动计算机的机制。这种机制让计算机的启动可以不依赖本地数据存储设备（如硬盘）或本地已安装的操作系统。

PXE当初是作为Intel的有线管理体系的一部分，Intel 和 Systemsoft于1999年9月20日公布其规格(版本2.1)[1]。通过使用像网际协议(IP)、用户数据报协议(UDP)、动态主机设定协定(DHCP)、小型文件传输协议(TFTP)等几种网络协议和全局唯一标识符(GUID)、通用网络驱动接口(UNDI)、通用唯一识别码(UUID)的概念并通过对客户机(通过PXE自检的电脑)固件扩展预设的API来实现目的。



### 三、交互过程分析
cobbler server与裸机（PXE client）交互过程分析：

1. 裸机配置了从网络启动后，开机后会广播包请求DHCP服务器（cobbler server）发送其分配好的一个IP  
2. DHCP服务器（cobbler server）收到请求后发送responese，包括其ip地址  
3. 裸机拿到ip后再向cobbler server发送请求OS引导文件的请求  
4. cobbler server告诉裸机OS引导文件的名字和TFTP server的ip和port  
5. 裸机通过上面告知的TFTP server地址和port通信，下载引导文件  
6. 裸机执行执行该引导文件，确定加载信息，选择要安装的os，期间会再向cobbler server请求kickstart文件和os image  
7. cobbler server发送请求的kickstart和os iamge  
8. 裸机加载kickstart文件  
9. 裸机接收os image，安装该os image  

之后，裸机就不“裸”了，有了自己的os和dhcp分配给其的ip。  

可以通过查看cobbler server所在机器的dhcp服务的相关文件，来查看分配出去的ip和对应的mac地址：

```bash
vi /var/lib/dhcpd/dhcpd.leases
```


四、Cobbler相关
Cobbler使用Python开发，目前实验使用的版本是Cobbler 2.6.11 Released by Jörgen on January 23, 2016



Reference：
- https://blog.csdn.net/yeruby/article/details/51167862
- https://zh.wikipedia.org/wiki/%E9%A2%84%E5%90%AF%E5%8A%A8%E6%89%A7%E8%A1%8C%E7%8E%AF%E5%A2%83
- https://zh.wikipedia.org/wiki/%E5%8A%A8%E6%80%81%E4%B8%BB%E6%9C%BA%E8%AE%BE%E7%BD%AE%E5%8D%8F%E8%AE%AE
- https://zh.wikipedia.org/wiki/%E5%B0%8F%E5%9E%8B%E6%96%87%E4%BB%B6%E4%BC%A0%E8%BE%93%E5%8D%8F%E8%AE%AE
- http://cobbler.github.io/
- http://www.361way.com/cobbler-principle/4328.html
