
# 1. ceph部署方案
by. 陈即彪

**需求**
----------------------------------------------------------------------------------------
（1）集群各角色节点配置标准化（CPU/MEM/盘/网络）
（2）高可靠（集群高可用、跨AZ部署）
（3）性能（参数最佳实践，包括操作系统参数）
（4）自动化（Ansible Playbook）

> **RGW**
通过 Ceph 的对象网关：RADOS Gateway (简称 RGW)，我们可以实现多站点的配置，最终实现双活数据中心。
**Zone：** 定义了由一个或多个 Ceph 对象网关实例组成的逻辑组。
**Zone Group：** 包含一个或多个 zone。在一个 zone group 中，一个 zone 将会被配置成 master zone。master zone 处理所有 bucket 和 user 的变更。Secondary zone 可以接受 bucket 和 user 操作请求，然后将操作请求重定向到 master zone。如果 master zone 出现故障，secondary zone 将会被提升为 master zone。
**Realm:** 它代表一个全局唯一的命名空间，包含一个或者多个 zone group。但必须要有一个 master zone group。Realm 使用 period 的概念来管理 zone group 和 zone 的配置状态。每次对 Zone group 或 zone 进行变更，都会对 period 做 update 和 commit 操作。每个 Ceph Cluster Map 都会维护它的历史版本。这些版本被称为 epoch。
Period： 每个 period 包含一个独有的 ID 和 epoch。每次提交操作都会使 epoch 递增。每个 realm 都与一个当前的 period 相关联，它保持 zone group 和存储策略的当前配置状态。

## 1.1. 节点硬件配置

### 1.1.1. OSD节点配置
1. 针 IOPS 密集型场景，服务器配置建议如下：
**OSD**：每个 NVMe SSD 上配置四个 OSD（lvm）。
**Controller**：使用 Native PCIe 总线。
**网络**：12osd/万兆口
**内存**：16G + 2G/osd
**CPU**：5c/ssd

2. 针对高吞吐量型，服务器配置建议如下：
**OSD**: HDD/7200转
**网络**：12osd/万兆口
**内存**：16G + 2G/osd
**CPU**：1c/hdd

3. 针对高容量型，服务器配置建议如下：
**OSDs**: HDD/7200转
**网络**：12osd/万兆口
**内存**：16G + 2G/osd
**CPU**：1c/hdd

> CPU中的1C = 1GHz

### 1.1.2. 其它各节点配置
1. **MDS**：4C/2G/10Gbps
2. **Monitor**：2C/2G/10Gbps
3. **Manager**：2C/2G/10Gbps

Bluestore 下：slow、 DB 和 WAL 的配比
slow(SATA):DB(SSD):WAL(NVMe SSD)=100:1:1


## 1.2. 部署方案
1. ceph-deploy
2. ceph-ansible(推荐使用)
官方ansible：https://github.com/ceph/ceph-ansible
使用文档：https://docs.ceph.com/ceph-ansible/master/
stable-4.0 支持ceph版本 nautilus. 要求ansible版本为 v2.8.


---
# 2. ceph集群实践方案

## 2.1. 硬件推荐
> 以1PB为例,高吞吐量型

1. **OSD节点**
数量：21
CPU：16c
内存：64G
网络：10Gbps * 2
硬盘：7200转HDD/4T * 12 （12个OSD + 1个系统）
系统：Ubuntu 18.04

2. **Monitor节点**
数量：3
CPU：2c
内存：2G
网络：10Gbps * 2
硬盘：20G
系统：Ubuntu 18.04

3. **Manager节点**
数量：2
CPU：2c
内存：2G
网络：10Gbps * 2
硬盘：20G
系统：Ubuntu 18.04

4. **MDS(对于cephFS)**
数量：2
CPU：4c
内存：2G
网络：10Gbps * 2
硬盘：20G
系统：Ubuntu 18.04

## 2.2. 性能调优

### 2.2.1. 参数方面
/etc/ceph/ceph.conf

#### 2.2.1.1. 集群全局调优 [global]部分
max open files = 131072
最大的文件描述符数量，设置为 64 的整数倍

osd pool default size = 3
默认的副本数，默认值是 3

osd pool default min size = 1
处于 degraded 状态，仍然提供服务的最小副本数

osd pool default pg num = 128
osd pool default pgp num = 128
设置默认 PG 数量， PG 和 PGP 的个数应保持一致

osd pool default crush rule = 0
当创建一个存储池时，缺省被使用的 CRUSH ruleset，这里设置默认为 rule 0

#### 2.2.1.2. monitor调优 [mon]部分
mon_osd_down_out_interval = 600
指定 Ceph 在 OSD 守护进程的多少秒时间内没有响应后标记其为“down”或“out”状态。当你的 OSD 节点崩溃、
自行重启或者有短时间的网络故障时，这个选项就派上用场了。你不想让集群在问题出现时就立刻启动数据平衡
（rebalancing），而是等待几分钟观察问题能否解决。

mon_allow_pool_delete = false
要避免 Ceph 存储池的意外删除，请设置这个参数为 false。

mon_osd_min_down_reporters = 3
如果 CephOSD 守护进程监控的 OSDdown 了，它就会向 MON 报告；缺省值为 1，表示仅报告一次。使用这个选
项，可以改变 CephOSD 进程需要向 Monitor 报告一个 down 掉的 OSD 的最小次数。在一个大集群中，建议使用
一个比缺省值大的值， 3 是一个不错的值。

mon osd full ratio = .80
OSD 硬盘使用率达到多少就认为它 full,默认值为.95

mon osd nearfull ratio = .70
OSD 磁盘空间利用率达到多少就认为它太满了，不能再接受回填；默认值为.90

#### 2.2.1.3. OSD 调优 [osd]部分
常用设置

osd data = /var/lib/ceph/osd/ceph-$id
osd mkfs type = xfs
格式化系统类型

osd_mkfs_options_xfs = "-f -i size= 2048"
创建 OSD 的时候， Ceph 将使用这些 xfs 选项来创建 OSD 的文件系统

osd_mount_options_xfs = "rw, noatime, inode64, logbufs= 8, logbsize= 256k, delaylog, allocsize= 4M"
设置挂载文件系统到 OSD 的选项。当 Ceph 挂载一个 OSD 时，下面的选项将用于 OSD 文件系统挂载。 默认值rw,noatime,inode64

osd_max_write_size = 256
OSD 单次写的最大大小，单位是 MB；默认是 90

osd_client_message_size_cap = 1073741824
内存中允许的最大客户端数据消息大小，单位是字节；默认是 100

osd_map_dedup = true
删除 OSD map 中的重复项

osd_op_threads = 16
服务于 Ceph OSD 进程操作的线程个数。设置为 0 可关闭它。调大该值会增加请求处理速率

osd_disk_threads = 4
用于执行像清理（scrubbing）、快照裁剪（snap trimming）这样的后台磁盘密集性 OSD 操作的磁盘线程数量；默认值为 1

osd_disk_thread_ioprio_class = idle
这个可调参数能够改变磁盘线程的I/O调度类型，且只工作在Linux内核CFQ调度器上，可用的值为idle、be或rt
**idle**: 磁盘线程的优先级比OSD的其它线程低，当你想放缓一个忙于处理客户端请求的OSD上的清理处理时，它是很有用的。
**be**：磁盘线程有着和OSD其它进程相同的优先级
**rt**：磁盘线程的优先级比OSD的其它线程高，当清理被迫需要时，须将它配置为优先于客户端操作

osd_disk_thread_ioprio_priority = 0
这个可调参数可以改变磁盘线程的I/O优先级，范围从0(高)到7(低)。如果给定主机的所有OSD都处于优先级idle，它们都在竞争I/O，而且没有太多操作。这个参数可以用来将一个OSD的磁盘线程优先级降为7，从而让别一个优先级为0的OSD尽可能地做清理。工作在CFQ调度器上


#### 2.2.1.4. Filestore 的设置
filestore_merge_threshold = 40
将 libaio 用于异步写日志。需要 journal dio 被置为 true

filestore_split_multiple = 8
子目录在分裂成二级目录之前最大的文件数

filestore_op_threads = 32
并行执行的文件系统操作线程个数

filestore_min_sync_interval = 10
将日志刷到磁盘的最小间隔

filestore_max_sync_interval = 15
将日志刷到磁盘的最大间隔
为了创建一个一致的提交点， filestore 需要停止写操作来执行 syncfs()，也就是从日志中同步数据到数据盘，然后清理日志。更加频繁地同步操作，可以减少存储在日志中的数据量。这种情况下，日志就能充分得到利用。配置一个越小的同步值，越有利于文件系统合并小量的写，提升性能。下面的参数定义了两次同步之间最小和最大的时间周期。

filestore_queue_max_ops = 25000
在阻塞新 operation 加入队列之前， filestore 能接受的最大 operation 数

filestore_queue_max_bytes = 10485760
一个 operation 的最大比特数

filestore_queue_committing_max_ops = 5000
filestore 能提交的 operation 的最大个数

filestore_queue_committing_max_bytes = 10485760000
filestore 能提交的 operation 的最大比特数

**Journal 的设置**
osd_journal_size = 10240
对 HDD 作为日志磁盘， 日志大小应该至少是预期磁盘速度和 filestore 最大同步时间间隔的两倍。如果使用了 SSD日志，最好创建大于 10GB 的日志，并调大 filestore 的最小、最大同步时间间隔。 默认 5120

osd journal = /var/lib/ceph/osd/$cluster-$id/journal
osd journal 位置

journal_max_write_bytes = 1073714824
单次写日志的最大比特数

journal_max_write_entries = 10000
单次写日志的最大条目数

journal_queue_max_ops = 50000
给定时间里，日志队列允许的最大 operation 数

journal_queue_max_bytes = 10485760000
给定时间里，日志队列允许的最大比特数

journal_dio = true
启用 directi/o 到日志。需要将 journal block align 配置为 true

journal_aio = true
启用 libaio 异步写日志。需要将 journal dio 配置为 true

journal_ block_ align = true
日志块写操作对齐。需要配置了 dio 和 aio

#### 2.2.1.5. OSD 调优的设置
osd max write size = 512
OSD 一次可写入的最大值，单位 512MB

osd client message size cap = 2147483648
客户端允许在内存中的最大值，单位 byes

osd deep scrub stride = 131072
在 deep scrub 时，允许读取的字节数，单位 bytes

osd op threads = 8
osd 进程操作的线程数

osd disk threads = 4
osd 密集型操作时的线程

osd map cache size = 1024
osd map 的缓存，单位 MB

osd map cache bl size = 128
osd 进程在内存中的缓存，单位 MB

osd mount options xfs = rw,noexec,nodev,noatime,nodiratime,nobarrier
osd xfs mount 的选项

#### 2.2.1.6. OSD recovery 的设置
如果相比数据恢复（recovery），你更加在意性能，可以使用这些配置，反之亦然。如果 Ceph 集群健康状态不正常，处于数据恢复状态，它就不能表现出正常性能，因为 OSD 正忙于数据恢复。如果你仍然想获得更好的性能，可以降低数据恢复的优先级，使数据恢复占用的 OSD 资源更少。如果想让 OSD 更快速地做恢复，从而让集群快速恢复其状态，你也可以设置以下这些值。

osd_recovery_max_active = 1
某个给定时刻，每个 OSD 上同时进行的所有 PG 的恢复操作（activerecovery）的最大数量

osd_recovery_max_single_start = 1
和 osd_recovery_max_active 一 起 使 用 。 假设我们配置 osd_recovery_max_single_start 为 1 ，osd_recovery_max_active 为 3，那么，这意味着 OSD 在某个时刻会为一个 PG 启动一个恢复操作，而且最多可以有三个恢复操作同时处于活动状态。

osd_recovery_op_priority = 50
用于配置恢复操作的优先级。值越小，优先级越高

osd_recovery_max_chunk = 1048576
数据恢复块的最大值，单位是字节

osd_recovery_threads = 1
恢复数据所需的线程数

#### 2.2.1.7. OSD backfilling（回填）设置
OSD backfilling 设置允许 Ceph 配置回填操作（backfilling operation）的优先级比请求读写更低。

osd_max_backfills = 2
允许进或出单个 OSD 的最大 backfill 数

osd_backfill_scan_min = 8
每个 backfill 扫描的最小 object 数

osd_backfill_scan_max = 64
每个 backfill 扫描的最大 object 数

#### 2.2.1.8. OSD scrubbing（清理）设置
OSD scrubbing对维护数据完整性来说是非常重要的，但是也会降低其性能。可以采用以下配置来增加或减少scrubbing操作

osd_max_scrubs = 1
一个OSD进程最大的并行scrub操作数

osd_scrub_sleep = 1
两个连续的scrub之间的scrub睡眠时间，单位秒

osd_scrub_chunk_min = 1
设置一个OSD执行scrub的数据块的最小个数

osd_scrub_chunk_max = 5
设置一个OSD执行scrub的数据块的最大个数

osd_deep_scrub_stride = 1048576
深层scrub时读大小，单位是字节

osd_scrub_begin_hour = 19
scrub开始的最早时间和end_hour一起定义scrub的时间窗口

osd_scrub_end_hour = 7
scrub执行结束时间

#### 2.2.1.9. 客户端调优 [client]部分
客户端调优参数应该定义在配置文件的[client]部分，通常[clinet]部分存在于客户端节点的配置文件中

rbd_cache = true
启动RBD(RADOS Block Device)缓存

rbd_cache_writethrough_until_flush = true
一开始使用write-through模式，在第一次flush请求被接收后切换到wirteback模式

rbd_concurrent_management_ops = 10 
可以在rbd上执行并发管理操作数

rbd_cache_size = 67108864
rbd缓存大小（字节）

rbd_cache_max_dirty = 50331648
缓存触发writeback时的上限字节数

rbd_cache_target_dirty = 33554432
在缓存开始写数据到后端存储之前，脏数据大小的目标值

rbd_cache_max_dirty_age = 2
在writeback开始之前，脏数据在缓存中存在的秒数

rbd_default_format = 2
使用第二种rbd格式，它已经在librbd和3.11之后的Linux内核版本中被支持，它添加了对克隆的支持，更加容易扩展，未来会支持更多的特性


### 2.2.2. BIOS 层面
a. 启用 vt 和 Hyper-Threading
b. 关闭节能
c. 关闭 NUMA

### 2.2.3. 操作系统调优
调整 I/O 调度算法
对 SSD，建议使用 noop，对机械硬盘建议使用 deadline
```bash
# echo noop >/sys/block/<sda>/queue/scheduler
# echo deadline >/sys/block/<sda>/queue/scheduler
```

调整 I/O 调度的队列深度
```bash
# echo 1024 > /sys/block/<sda>/queue/nr_requests
```

调整预读大小
```bash
# echo "8192" > /sys/block/sda/queue/read_ahead_kb
```

调整进程数量
```bash
# echo "4194303" > /proc/sys/kernel/pid_max
```

调整打开文件的最大数量
```bash
# echo "26234859" > /proc/sys/fs/file-max
```

关闭虚拟内容
```bash
# echo "vm.swappiness=0" >> /etc/sysctl.conf
```

配置 jumbo frames
```bash
# ifconfig ens32 mtu 9000
```
或者修改配置文件
```bash
# vi /etc/sysconfig/network-scripts/ifcfg-ens32

#添加下面两行
MTU=9000
IPV6_MTU=9000
```
第一个是 ipv4 的 mtu，第二个是 ipv6 的 mtu



# 3. ceph集群部署

## 3.1. 准备ansible
ceph-ansible：https://github.com/ceph/ceph-ansible

下载ceph-ansible 4.0.5
```bash
wget https://github.com/ceph/ceph-ansible/archive/v4.0.5.tar.gz
```

解压进入目录
```bash
tar xf v4.0.5.tar.gz
cd ceph-ansible-4.0.5/
```

pip安装所需的包
```bash
pip install -r requirements.txt
```

安装ansible
```bash
sudo add-apt-repository ppa:ansible/ansible
sudo apt update
sudo apt install ansible
```

## 3.2. 准备必要文件
清单、剧本及ceph集群的配置

### 3.2.1. 清单示例
```bash
# vim /etc/ansible/hosts
[mons]
mon1
mon2
mon3

[osds]
osd1
osd2
osd3

[mgrs]
mgr1
mgr2
```

### 3.2.2. 剧本playbook
目录中有个文件`site.yml.sample`是ceph-ansible项目的一个示例剧本
修改这个示例作为正式的剧本
```bash
mv site.yml.sample site.yml
```

ceph-ansible项目通过ceph-validate角色提供配置验证。如果您正在使用所提供的剧本之一，这个角色将在部署的早期运行，以确保您已经给了ceph-ansible正确的配置。此检查仅确保您为集群提供了适当的配置设置，而不是其中的值将生成健康的集群。例如，如果您为monitor_address提供了错误的地址，那么mon仍然无法加入集群。

### 3.2.3. 安装方式
> 安装方式通过变量设置：ceph_origin

**通过ceph_origin变量的值：**
1. **repository**: 意味着您将通过一个新的仓库安装Ceph。下面将在`community`、`rhcs`或`dev`之间进行选择。这些选项将通过ceph_repository变量公开。
2. **distro**: 意味着不会添加单独的repo文件，您将获得包含在Linux发行版中的Ceph的任何版本。
3. **local**: 意味着Ceph的二进制文件将从本地机器复制过来(没有经过很好的测试，由您自己承担风险)

#### 3.2.3.1. 选择repository方式
> ceph_origin 设置了 repository

**以下是 ceph_repository 变量的选项：**
`community`： 从官方社区Ceph仓库 http://download.ceph.com 获取包
`rhcs`： 红帽系统选择此方式
`dev`： 从shaman获取包，一个基于gitbuilder的包系统
`uca`： 从Ubuntu云存档获取包
`custom`： 从特定存储库获取包

1. `ceph_repository` 设置为 `community`
```bash
ceph_repository: community
# 安装源，默认是http://download.ceph.com
ceph_mirror: http://download.ceph.com
# 选择版本
ceph_stable_release: nautilus
```

2. `ceph_repository` 设置为 `rhcs`
略

3. `ceph_repository` 设置为 `dev`
如果ceph_repository被设置为dev，那么您将默认从https://shaman.ceph.com/安装包，这是无法调整的。显然，您可以在ceph_dev_branch的帮助下决定安装哪个分支(默认为“master”)。另外，您可以使用ceph_dev_sha1指定SHA1，默认值为' latest '(在最新构建中)。

4. `ceph_repository` 设置为 `uca`
如果将ceph_repository设置为uca，则默认情况下将从http://ubuntu-cloud.archive.canonical.com/ubuntu安装包，这可以通过调整ceph_stable_repo_uca来更改。您还可以通过调整ceph_stable_openstack_release_uca来决定Ceph包应该来自哪个OpenStack版本。例如，ceph_stable_openstack_release_uca: queens。

5. `ceph_repository` 设置为 `custom`
如果将ceph_repository设置为custom，则默认从所需的存储库安装包。这个存储库是由ceph_custom_repo组成的specifie, e。旅客:ceph_custom_repo: https://server.domain.com/ceph-custom-repo。


#### 3.2.3.2. 选择Distro方式
如果将ceph_origin设置为发行版，则不会添加单独的repo文件，您将获得包含在Linux发行版中的Ceph的任何版本。

#### 3.2.3.3. 选择Local方式
如果ceph_origin设置为local, ceph的二进制文件将从本地机器复制过来(没有经过良好测试，由您自己承担风险)


### 3.2.4. 配置文件
Ceph集群的配置将通过使用Ceph-ansible提供的ansible变量来设置。所有这些选项及其默认值都定义在位于ceph-ansible项目根目录下的`group_vars/`目录中。
Ansible将使用`group_vars/`目录的配置，这是相对于你的库存文件或剧本。在`group_vars/`目录中有许多示例Ansible配置文件，它们通过文件名与每个Ceph守护进程组相关。例如，`osds.yml.sample`包含OSD守护进程的所有默认配置。`all.yml.sample` 文件是一个特殊的`group_vars`文件，它适用于集群中的所有主机。

在最基本的层面上，你必须告诉Ceph -ansible你希望安装Ceph的什么版本，安装的方法，你的集群网络设置和你想如何配置你的OSDs。在开始配置之前，对group_vars/中您希望使用的每个文件进行重命名，使其不包括文件名末尾的.sample，取消对您希望更改的选项的注释，并提供您自己的值。

`group_vars/all.yml`示例
```yaml
ceph_origin: repository
ceph_repository: community
ceph_stable_release: octopus
public_network: "192.168.3.0/24"
cluster_network: "192.168.4.0/24"
monitor_interface: eth1
devices:
  - '/dev/sda'
  - '/dev/sdb'
```

需要在所有安装上更改以下配置选项，但是根据OSD场景选择或集群的其他方面，可能还需要其他选项。
```bash
ceph_origin
ceph_stable_release
public_network
monitor_interface or monitor_address
```
在部署RGW实例时，需要设置radosgw_interface或radosgw_address配置选项


### 3.2.5. `ceph.conf` 配置文件
定义ceph conf所支持的方法是使用ceph_conf_overrides变量。这允许您使用INI格式指定配置选项。这个变量可以用来覆盖已经在ceph conf中定义的部分(参见:`roles/ceph-config/templates/ceph. j2`)，或者提供新的配置选项。

支持ceph conf中的以下部分:
```ini
[global]
[mon]
[osd]
[mds]
[client.rgw.{instance_name}]
```

示例
```yaml
ceph_conf_overrides:
  global:
    foo: 1234
    bar: 5678
  osd:
    osd_mkfs_type: ext4
```

### 3.2.6. OSD Scenario
stable-4.0版本，默认 `osd_scenario` 为`lvm`

https://docs.ceph.com/ceph-ansible/master/osds/scenarios.html#osd-scenario-lvm

# 4. Demos
Vagrant Demo
物理机上部署: https://youtu.be/E8-96NamLDo

Bare metal demo
物理机上部署: https://youtu.be/dv_PEp9qAqg