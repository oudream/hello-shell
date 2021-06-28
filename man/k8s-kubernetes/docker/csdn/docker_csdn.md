[toc]

# 1. docker
> 官网：docker.io

容器，是一种工具，如同箱子，可以放入想要的东西、物品，方便我们运输、存储。IT技术中的容器也是如此。

容器技术是虚拟化、云计算、大数据后的一门新兴的新技术，容器技术提高了硬件资源利用率、 方便了企业的业务快速横向扩容、 实现了业务宕机自愈功能，因此未来数年会是一个容器愈发流行的时代， 这是一个对于IT 行业来说非常有影响和价值的技术，而对于 IT 行业的从业者来说， 熟练掌握容器技术无疑是一个很有前景的行业工作机会。

容器技术最早出现在 freebsd 叫做 jail。

## 1.1. 什么是docker

首先 Docker 是一个在 2013 年开源的应用程序并且是一个基于 go 语言编写是一个开源的 PAAS 服务(Platform as a Service， 平台即服务的缩写)， go 语言是由google 开发， docker 公司最早叫 dotCloud 后由于 Docker 开源后大受欢迎就将公司改名为 Docker Inc， 总部位于美国加州的旧金山。

Docker 是基于 linux 内核实现， Docker 最早采用 LXC 技术(LinuX Container 的简写， LXC 是 Linux 原生支持的容器技术， 可以提供轻量级的虚拟化， 可以说 docker 就是基于 LXC 发展起来的，提供 LXC 的高级封装，发展标准的配置方法)， 而虚拟化技术 KVM(Kernelbased Virtual Machine) 基于模块实现， Docker 后改为自己研发并开源的 runc 技术运行容器。

Docker 相比虚拟机的交付速度更快， 资源消耗更低， Docker 采用客户端/服务端架构，使用远程 API 来管理和创建 Docker 容器，其可以轻松的创建一个轻量级的、 可移植的、自给自足的容器， docker 的三大理念是 build(构建)、ship(运输)、 run(运行)， Docker 遵从 apache 2.0 协议，并通过（namespace 及cgroup 等）来提供容器的资源隔离与安全保障等，所以 Docke 容器在运行时不需要类似虚拟机（空运行的虚拟机占用物理机 6-8%性能）的额外资源开销，因此可以大幅提高资源利用率,总而言之 Docker 是一种用了新颖方式实现的轻量级虚拟机.类似于 VM 但是在原理和应用上和 VM 的差别还是很大的，并且 docker的专业叫法是应用容器(Application Container)

## 1.2. Docker 的组成：
Docker 主机(Host)： 一个物理机或虚拟机，用于运行 Docker 服务进程和容器。
Docker 服务端(Server)： Docker 守护进程， 运行 docker 容器。
Docker 客户端(Client)： 客户端使用 docker 命令或其他工具调用 docker API。
Docker 仓库(Registry): 保存镜像的仓库，类似于 git 或 svn 这样的版本控制系
Docker 镜像(Images)： 镜像可以理解为创建实例使用的模板。
Docker 容器(Container): 容器是从镜像生成对外提供服务的一个或一组服务。

> 官方仓库: https://hub.docker.com/

**Docker组成**
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190911173554977.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

## 1.3. Docker 对比虚拟机：
资源利用率更高： 一台物理机可以运行数百个容器，但是一般只能运行数十个虚拟机。

开销更小： 不需要启动单独的虚拟机占用硬件资源。
启动速度更快： 可以在数秒内完成启动。

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190911173530785.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

使用虚拟机是为了更好的实现服务运行环境隔离， 每个虚拟机都有独立的内核，虚拟化可以实现不同操作系统的虚拟机， 但是通常一个虚拟机只运行一个服务， 很明显资源利用率比较低且造成不必要的性能损耗， 我们创建虚拟机的目的是为了运行应用程序，比如 Nginx、 PHP、 Tomcat 等 web 程序， 使用虚拟机无疑带来了一些不必要的资源开销，但是容器技术则基于减少中间运行环节带来较大的性能提升。

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190911173537784.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

但是，如上图一个宿主机运行了 N 个容器， 多个容器带来的以下问题怎么解决:
1.怎么样保证每个容器都有不同的文件系统并且能互不影响？
2.一个 docker 主进程内的各个容器都是其子进程，那么实现同一个主进程下不同类型的子进程？ 各个进程间通信能相互访问(内存数据)吗？
3.每个容器怎么解决 IP 及端口分配的问题？
4.多个容器的主机名能一样吗？
5.每个容器都要不要有 root 用户？怎么解决账户重名问题？

# 2. Linux Namespace 技术：
namespace 是 Linux 系统的底层概念， 在内核层实现，即有一些不同类型的命名空间被部署在核内， 各个 docker 容器运行在同一个 docker 主进程并且共用同一个宿主机系统内核，各 docker 容器运行在宿主机的用户空间， 每个容器都要有类似于虚拟机一样的相互隔离的运行空间， 但是容器技术是在一个进程内实现运行指定服务的运行环境， 并且还可以保护宿主机内核不受其他进程的干扰和影响， 如文件系统空间、网络空间、进程空间等，目前主要通过以下技术实现容器运行空间的相互隔离：

|隔离类型|功能|系统调用参数|内核版本|
|-------|----|-----------|-------|
|MNT Namespace</br>(mount)| 提供磁盘挂载点和文件系统的隔离能力 |CLONE_NEWNS| Linux 2.4.19
IPC Namespace</br>(Inter-Process Communication)  | 提供进程间通信的隔离能力  | CLONE_NEWIPC |  Linux 2.6.19
UTS Namespace</br>(UNIX Timesharing System)  | 提供主机名隔离能力  | CLONE_NEWUTS |  Linux 2.6.19
PID Namespace</br>(Process Identification)  | 提供进程隔离能力 |  CLONE_NEWPID  | Linux 2.6.24
Net Namespace</br>(network)  | 提供网络隔离能力  | CLONE_NEWNET |  Linux 2.6.29
User Namespace</br>(user)  | 提供用户隔离能力 |  CLONE_NEWUSER |  Linux 3.8

## 2.1. MNT Namespace技术
每个容器都要有独立的根文件系统有独立的用户空间， 以实现在容器里面启动服务并且使用容器的运行环境，即一个宿主机是 ubuntu 的服务器，可以在里面启动一个 centos 运行环境的容器并且在容器里面启动一个 Nginx 服务，此 Nginx运行时使用的运行环境就是 centos 系统目录的运行环境， 但是在容器里面是不能访问宿主机的资源， 宿主机是使用了 chroot 技术把容器锁定到一个指定的运行目录里面。

例如： /var/lib/containerd/io.containerd.runtime.v1.linux/moby/容器 ID

## 2.2. IPC Namespace：
一个容器内的进程间通信， 允许一个容器内的不同进程的(内存、 缓存等)数据访问，但是不能夸容器访问其他容器的数据。

## 2.3. UTS Namespace：
UTS namespace（ UNIX Timesharing System 包含了运行内核的名称、版本、底层体系结构类型等信息）用于系统标识， 其中包含了 hostname 和域名domainname ， 它使得一个容器拥有属于自己 hostname 标识，这个主机名标识独立于宿主机系统和其上的其他容器。

## 2.4. PID Namespace：
Linux 系统中，有一个 PID 为 1 的进程(init/systemd)是其他所有进程的父进程， 那么在每个容器内也要有一个父进程来管理其下属的子进程，那么多个容器的进程通 PID namespace 进程隔离(比如 PID 编号重复、 器内的主进程生成与回收子进程等)

## 2.5. Net Namespace：
每一个容器都类似于虚拟机一样有自己的网卡、 监听端口、 TCP/IP 协议栈等，Docker 使用 network namespace 启动一个 vethX 接口，这样你的容器将拥有它自己的桥接 ip 地址，通常是 docker0，而 docker0 实质就是 Linux 的虚拟网桥,网桥是在 OSI 七层模型的数据链路层的网络设备，通过 mac 地址对网络进行划分，并且在不同网络直接传递数据。

## 2.6. User Namespace：
各个容器内可能会出现重名的用户和用户组名称， 或重复的用户 UID 或者GID， 那么怎么隔离各个容器内的用户空间呢？User Namespace 允许在各个宿主机的各个容器空间内创建相同的用户名以及相同的用户 UID 和 GID， 只是会把用户的作用范围限制在每个容器内，即 A 容器和 B 容器可以有相同的用户名称和 ID 的账户，但是此用户的有效范围仅是当前容器内， 不能访问另外一个容器内的文件系统，即相互隔离、互补影响、 永不相见。

---
# 3. Linux控制组
Linux control groups：
在一个容器，如果不对其做任何资源限制，则宿主机会允许其占用无限大的内存空间， 有时候会因为代码 bug 程序会一直申请内存，直到把宿主机内存占完， 为了避免此类的问题出现， 宿主机有必要对容器进行资源分配限制，比如CPU、内存等， Linux Cgroups 的全称是 Linux Control Groups， 它最主要的作用，就是限制一个进程组能够使用的资源上限，包括 CPU、内存、磁盘、网络带宽等等。此外，还能够对进程进行优先级设置，以及将进程挂起和恢复等操作。

## 3.1. cgroups 具体实现
**blkio**：块设备 IO 限制。
**cpu**：使用调度程序为 cgroup 任务提供 cpu 的访问。
**cpuacct**：产生 cgroup 任务的 cpu 资源报告。
**cpuset**：如果是多核心的 cpu，这个子系统会为 cgroup 任务分配单独的 cpu 和内存。
**devices**：允许或拒绝 cgroup 任务对设备的访问。
**freezer**：暂停和恢复 cgroup 任务。
**memory**：设置每个 cgroup 的内存限制以及产生内存资源报告。
**net_cls**：标记每个网络包以供 cgroup 方便使用。
**ns**：命名空间子系统。
**perf_event**：增加了对每 group 的监测跟踪的能力，可以监测属于某个特定的 group 的所有线程以及运行在特定 CPU 上的线程

查看系统 cgroups：
```bash
ll /sys/fs/cgroup/
```
有了以上的 chroot、 namespace、 cgroups 就具备了基础的容器运行环境，但是还需要有相应的容器创建与删除的管理工具、 以及怎么样把容器运行起来、容器数据怎么处理、怎么进行启动与关闭等问题需要解决， 于是容器管理技术出现了


# 4. 容器管理工具：
目前主要是使用 docker， 早期有使用 lxc。

## 4.1. LXC
**LXC**： LXC 为 Linux Container 的简写。可以提供轻量级的虚拟化，以便隔离进程和资源， 官方网站： https://linuxcontainers.org/

1. Ubuntu 安装 lxc:
```bash
# apt install lxc lxd
Reading package lists... Done
Building dependency tree
Reading state information... Done
lxd is already the newest version (3.0.3-0ubuntu1~18.04.3).
lxc is already the newest version (3.0.3-0ubuntu1~18.04.1).
```
2. 检查内核对 lcx 的支持状况，必须全部为 lcx
```bash
# lxc-checkconfig 
# lxc-create -t 模板名称 -n lcx-test
# lxc-create -t download --name alpine12 -- --dist alpine --release 3.9 --arch amd64
Setting up the GPG keyring
Downloading the image index
Downloading the rootfs
Downloading the metadata
The image cache is now ready
Unpacking the rootfs
---
You just created an Alpinelinux 3.9 x86_64 (20190630_13:00) container.
```
> 命令备注：
> -t 模板: -t 选项后面跟的是模板，模式可以认为是一个原型，用来说明我们需要一个什么样的容器(比如容器里面需不需要有 vim, apache 等软件)．模板实际上就是一个脚本文件(位于/usr/share/lxc/templates 目录)，我们这里指定 download 模板(lxc-create 会调用 lxcdownload 脚本，该脚本位于刚说的模板目录中)是说明我们目前没有自己模板，需要下载官方的模板
> --name 容器名称： 为创建的容器命名
> -- : --用来说明后面的参数是传递给 download 脚本的，告诉脚本需要下载什么样的模板
> --dist 操作系统名称：指定操作系统
> --release 操作系统: 指定操作系统，可以是各种 Linux 的变种
> --arch 架构： 指定架构，是 x86 还是 arm，是 32 位还是 64 位

3. 启动 lxc 容器
```bash
# lxc-start alpine12 
```
4. 进入 lxc 容器
```bash
# lxc-attach alpine12 
```
容器内查看网络
```bash
~ # ifconfig
eth0    Link encap:Ethernet HWaddr 00:16:3E:DF:54:94
        inet addr:10.0.3.115 Bcast:10.0.3.255 Mask:255.255.255.0
        inet6 addr: fe80::216:3eff:fedf:5494/64 Scope:Link
        UP BROADCAST RUNNING MULTICAST MTU:1500 Metric:1
        RX packets:18 errors:0 dropped:0 overruns:0 frame:0
        TX packets:13 errors:0 dropped:0 overruns:0 carrier:0
        collisions:0 txqueuelen:1000
        RX bytes:2102 (2.0 KiB) TX bytes:1796 (1.7 KiB)
lo      Link encap:Local Loopback
        inet addr:127.0.0.1 Mask:255.0.0.0
        inet6 addr: ::1/128 Scope:Host
        UP LOOPBACK RUNNING MTU:65536 Metric:1
        RX packets:0 errors:0 dropped:0 overruns:0 frame:0
        TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
        collisions:0 txqueuelen:1000
        RX bytes:0 (0.0 B) TX bytes:0 (0.0 B)
```
容器内查看内核
```bash
~ # uname -a
Linux alpine12 4.15.0-20-generic #21-Ubuntu SMP Tue Apr 24 06:16:15 UTC 2018
x86_64 Linux
```

lxc 启动容器依赖于模板， 清华模板源：https://mirrors.tuna.tsinghua.edu.cn/help/lxc-images/

但是做模板相对较难， 需要手动一步步创构建文件系统、准备基础目录及可执行程序等，而且在大规模使用容器的场景很难横向扩展， 另外后期代码升级也需要重新从头构建模板，基于以上种种原因便有了 docker。

## 4.2. docker：
Docker 启动一个容器也需要一个外部模板但是较多镜像， docke 的镜像可以保存在一个公共的地方共享使用， 只要把镜像下载下来就可以使用，最主要的是可以在镜像基础之上做自定义配置并且可以再把其提交为一个镜像，一个镜像可以被启动为多个容器。

Docker 的镜像是分层的， 镜像底层为库文件且只读层即不能写入也不能删除数据，从镜像加载启动为一个容器后会生成一个可写层，其写入的数据会复制到容器目录， 但是容器内的数据在删除容器后也会被随之删除。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190911173916329.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

## 4.3. pouch：
> https://www.infoq.cn/article/alibaba-pouch
> https://github.com/alibaba/pouch

## 4.4. Docker 的优势：
**快速部署**： 短时间内可以部署成百上千个应用，更快速交付到线上。高效虚拟化：不需要额外的 hypervisor 支持，直接基于 linux 实现应用虚拟化，相比虚拟机大幅提高性能和效率。

**节省开支**： 提高服务器利用率，降低 IT 支出。

**简化配置**： 将运行环境打包保存至容器，使用时直接启动即可。快速迁移和扩展： 可夸平台运行在物理机、虚拟机、公有云等环境， 良好的兼容性可以方便将应用从 A 宿主机迁移到 B 宿主机， 甚至是 A 平台迁移到 B 平台。

## 4.5. Docker 的缺点：
**隔离性**： 各应用之间的隔离不如虚拟机彻底


# 5. docker的核心技术
## 5.1. 容器规范：
容器技术除了的 docker 之外，还有 coreOS 的 rkt， 还有阿里的 Pouch， 为了保证容器生态的标准性和健康可持续发展， 包括 Linux 基金会、 Docker、微软、红帽谷歌和、 IBM、 等公司在 2015 年 6 月共同成立了一个叫 open container（ OCI）的组织，其目的就是制定开放的标准的容器规范，目前 OCI 一共发布了两个规范，

分别是 runtime spec 和 image format spec，有了这两个规范， 不同的容器公司开发的容器只要兼容这两个规范，就可以保证容器的可移植性和相互可操作性。

## 5.2. 容器 runtime：
runtime 是真正运行容器的地方，因此为了运行不同的容器 runtime 需要和操作系统内核紧密合作相互在支持，以便为容器提供相应的运行环境。

目前主流的三种 runtime：
**Lxc：** linux 上早期的 runtime， Docker 早期就是采用 lxc 作为 runtime。
**runc：**目前 Docker 默认的 runtime， runc 遵守 OCI 规范，因此可以兼容 lxc。
**rkt：** 是 CoreOS 开发的容器 runtime，也符合 OCI 规范，所以使用 rktruntime 也可以运行 Docker 容器。

## 5.3. 容器管理工具：
管理工具连接 runtime 与用户，对用户提供图形或命令方式操作，然后管理工具将用户操作传递给 runtime 执行。
lxc 是 lxd 的管理工具。
Runc 的管理工具是 docker engine， docker engine 包含后台 deamon 和 cli 两部分，大家经常提到的 Docker 就是指的 docker engine。
Rkt 的管理工具是 rkt cli。

## 5.4. 容器定义工具：
容器定义工具允许用户定义容器的属性和内容，以方便容器能够被保存、共享和重建。
**Docker image**：是 docker 容器的模板， runtime 依据 docker image 创建容器。
**Dockerfile**：包含 N 个命令的文本文件，通过 dockerfile 创建出 docker image。
**ACI(App container image)**： 与 docker image 类似， 是 CoreOS 开发的 rkt 容器的镜像格式。

**Registry：**
统一保存镜像而且是多个不同镜像版本的地方， 叫做镜像仓库。
Image registry： docker 官方提供的私有仓库部署工具。
Docker hub： docker 官方的公共仓库， 已经保存了大量的常用镜像，可以方便大家直接使用。
Harbor： vmware 提供的自带 web 界面自带认证功能的镜像仓库，目前有很多公司使用。

## 5.5. 编排工具：
当多个容器在多个主机运行的时候， 单独管理容器是相当复杂而且很容易出错，而且也无法实现某一台主机宕机后容器自动迁移到其他主机从而实现高可用的目的， 也无法实现动态伸缩的功能，因此需要有一种工具可以实现统一管理、动态伸缩、故障自愈、 批量执行等功能， 这就是容器编排引擎。

容器编排通常包括容器管理、调度、集群定义和服务发现等功能。
Docker swarm： docker 开发的容器编排引擎。
Kubernetes： google 领导开发的容器编排引擎，内部项目为 Borg， 且其同时支持docker 和 CoreOS。
Mesos+Marathon： 通用的集群组员调度平台， mesos(资源分配)与 marathon(容器编排平台)一起提供容器编排引擎功能。

# 6. docker的依赖技术：
**容器网络：**
docker 自带的网络 docker network 仅支持管理单机上的容器网络， 当多主机运行的时候需要使用第三方开源网络，例如 calico、 flannel 等。

**服务发现：**
容器的动态扩容特性决定了容器 IP 也会随之变化， 因此需要有一种机制开源自动识别并将用户请求动态转发到新创建的容器上， kubernetes 自带服务发现功能，需要结合 kube-dns 服务解析内部域名。

**容器监控：**
可以通过原生命令 docker ps/top/stats 查看容器运行状态，另外也可以使heapster/ Prometheus 等第三方监控工具监控容器的运行状态。

**数据管理：**
容器的动态迁移会导致其在不同的 Host 之间迁移，因此如何保证与容器相关的数据也能随之迁移或随时访问，可以使用逻辑卷/存储挂载等方式解决。

**日志收集：**
docker 原生的日志查看工具 docker logs， 但是容器内部的日志需要通过 ELK 等专门的日志收集分析和展示工具进行处理。

---

## 6.1. docker 存储引擎：
目前 docker 的默认存储引擎为 overlay2， 需要磁盘分区支持 d-type 文件分层功能，因此需要系统磁盘的额外支持。

官方文档关于存储引擎的选择文档：
> https://docs.docker.com/storage/storagedriver/select-storage-driver/

Docker 官方推荐首选存储引擎为 **overlay2** 其次为 devicemapper， 但是devicemapper 存在使用空间方面的一些限制， 虽然可以通过后期配置解决，但是官方依然推荐使用 overlay2，以下是网上查到的部分资料：https://www.cnblogs.com/youruncloud/p/5736718.html

> 如果 docker 数据目录是一块单独的磁盘分区而且是 xfs 格式的， 那么需要在格式化的时候加上参数-n ftype=1， 否则后期在启动容器的时候会报错不支持 dtype。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190911174159225.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)
报错界面：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190911174206250.png)

## 6.2. docker 服务进程：
通过查看 docker 进程，了解 docker 的运行及工作方式
1. 查看宿主机进程树
```bash
pstree -p 1
```
2. 查看 containerd 进程关系
有四个进程：
**dockerd：** 被 client 直接访问，其父进程为宿主机的 systemd 守护进程。
**docker-proxy：** 实现容器通信， 其父进程为 dockerd
**containerd：** 被 dockerd 进程调用以实现与 runc 交互。
**containerd-shim：** 真正运行容器的载体， 其父进程为 containerd。

3. containerd-shim 命令使用
```bash
# containerd-shim -h
Usage of containerd-shim:
  -address string
        grpc address back to main containerd
  -containerd-binary containerd publish
        path to containerd binary (used for containerd publish) (default "containerd")
  -criu string
        path to criu binary
  -debug
        enable debug output in logs
  -namespace string
        namespace that owns the shim
  -runtime-root string
        root directory for the runtime (default "/run/containerd/runc")
  -socket string
        abstract socket path to serve
  -systemd-cgroup
        set runtime to use systemd-cgroup
  -workdir string
        path used to storge large temporary data
```

### 6.2.1. 容器的创建与管理过程
**通信流程：**
1. dockerd 通过 grpc 和 containerd 模块通信， dockerd 由 libcontainerd 负责和 containerd 进行交换， dockerd 和 containerd 通信 socket 文件： /run/containerd/containerd.sock。
2. containerd 在 dockerd 启动时被启动， 然后 containerd 启动 grpc 请求监听， containerd 处理 grpc 请求，根据请求做相应动作。
3. 若是 start 或是 exec 容器， containerd 拉起一个 container-shim , 并进行相应的操作。
4. container-shim 别拉起后， start/exec/create 拉起 runC 进程，通过 exit、 control 文件和containerd 通信，通过父子进程关系和 SIGCHLD 监控容器中进程状态。
5. 在整个容器生命周期中， containerd 通过 epoll 监控容器文件，监控容器事件。

![在这里插入图片描述](https://img-blog.csdnimg.cn/2019091117421313.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

### 6.2.2. grpc 简介：
gRPC 是 Google 开发的一款高性能、开源和通用的 RPC 框架，支持众多语言客户端。

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190911174217426.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)