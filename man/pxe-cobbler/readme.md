
[https://search.bilibili.com/all?keyword=pxe%20&from_source=nav_search_new](https://search.bilibili.com/all?keyword=pxe%20&from_source=nav_search_new)  
[https://www.youtube.com/results?search_query=pxe](https://www.youtube.com/results?search_query=pxe)  


[https://www.kancloud.cn/devops-centos/centos-linux-devops/392366](https://www.kancloud.cn/devops-centos/centos-linux-devops/392366)  


本文转自"运维之路

Cobbler是通过将DHCP、TFTP、DNS、HTTP等服务进行集成，创建一个中央管理节点，其可以实现的功能有配置服务，创建存储库，
解压缩操作系统媒介，代理或集成一个配置管理系统，控制电源管理等。 Cobbler的最终目的是实现无需进行人工干预即可安装机器。
在进行进一步的操作之前，我们有必要先了解下pxe和kickstart 。

### PXE概述
预启动执行环境（Preboot eXecution Environment，PXE，也被称为预执行环境)是让计算机通过网卡独立地使用数据设备(如硬盘)
或者安装操作系统。最早是Intel 搞出来的一个东西，更深层次的东西我们不用去管，直接上个图，我们看下其工作原理：

![](./pxe1.png)
![](./pxe2.png)

简单总结一下，  
PXE Client发送广播包请求DHCP分配IP地址DHCP  
Server回复请求，给出IP地址以及Boot  
Server的地址PXE下载引导文件执行引导程序  
总结来说，PXE主要是通过广播的方式发送一个包，并请注获取一个地址，而后交给TFTP程序下载一个引导文件。下面我们来说一下Kickstart。  

### Kickstart 概述
Kickstart 是红帽搞出来的一个东西，我们可以简单理解为一个自动安装应答配置管理程序。通过读取这个配置文件，系统知道怎么去分区，要安装什么包，配什么IP，优化什么内核参数等等。其主要有以下部分组成：  
- Kickstart 安装选项，包含语言的选择，防火墙，密码，网络，分区的设置等；
- %Pre 部分，安装前解析的脚本，通常用来生成特殊的ks配置，比如由一段程序决定磁盘分区等；
- %Package 部分，安装包的选择，可以是 @core 这样的group的形式，也可以是这样 vim-* 包的形式；
- %Post 部分，安装后执行的脚本，通常用来做系统的初始化设置。比如启动的服务，相关的设定等。

### Cobbler简介

- Cobbler概述
Cobbler由python语言开发，是对PXE和Kickstart以及DHCP的封装。融合很多特性，提供了CLI和Web的管理形式。更加方便的实行网络安装。同时，Cobbler也提供了API接口，使用其它语言也很容易做扩展。它不紧可以安装物理机，同时也支持kvm、xen虚拟化、Guest OS的安装。更多的是它还能结合Puppet等集中化管理软件，实现自动化的管理。

- Cobbler的设计方式
Cobbler 的配置结构基于一组注册的对象。每个对象表示一个与另一个实体相关联的实体（该对象指向另一个对象，或者另一个对象指向该对象）。当一个对象指向另一个对象时，它就继承了被指向对象的数据，并可覆盖或添加更多特定信息。以下对象类型的定义为：  
    - 发行版：表示一个操作系统。它承载了内核和 initrd 的信息，以及内核参数等其他数据。  
    - 配置文件：包含一个发行版、一个 kickstart 文件以及可能的存储库，还包含更多特定的内核参数等其他数据。  
    - 系统：表示要配给的机器。它包含一个配置文件或一个镜像，还包含 IP 和 MAC 地址、电源管理（地址、凭据、类型）以及更为专业的数据等信息。  
    - 存储库：保存一个 yum 或 rsync 存储库的镜像信息。  
    - 镜像：可替换一个包含不属于此类别的文件的发行版对象（例如，无法分为内核和 initrd 的对象）。  
基于注册的对象以及各个对象之间的关联，Cobbler 知道如何更改文件系统以反映具体配置。因为系统配置的内部是抽象的，所以您可以仅关注想要执行的操作。Cobbler 对象关系图如下：
![](./cobbler1.png)

Server端：
```
第一步，启动Cobbler服务
第二步，进行Cobbler错误检查，执行cobbler check命令
第三步，进行配置同步，执行cobbler sync命令
第四步，复制相关启动文件文件到TFTP目录中
第五步，启动DHCP服务，提供地址分配
第六步，DHCP服务分配IP地址
第七步，TFTP传输启动文件
第八步，Server端接收安装信息
第九步，Server端发送ISO镜像与Kickstart文件
```

Client端：
```
第一步，客户端以PXE模式启动
第二步，客户端获取IP地址
第三步，通过TFTP服务器获取启动文件
第四步，进入Cobbler安装选择界面
第五步，客户端确定加载信息
第六步，根据配置信息准备安装系统
第七步，加载Kickstart文件
第八步，传输系统安装的其它文件
第九步，进行安装系统  
```

### reference
- [https://www.linuxidc.com/Linux/2018-10/154904.htm](https://www.linuxidc.com/Linux/2018-10/154904.htm)
