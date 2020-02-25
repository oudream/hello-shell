@[TOC](目录)

**DAS、SAN 、NAS**
![在这里插入图片描述](https://img-blog.csdnimg.cn/2019072622004490.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)
#存储基础知识---存储网络
1. 直接存储(Direct Attached Storage)。存储设备与主机的紧密相连
•管理成本较低，实施简单
•储时直接依附在服务器上，因此存储共享受到限制
•CPU必须同时完成磁盘存取和应用运行的双重任务，所以不利于CPU的指令周期的优化，增加系统负担

2. 网络连接存储(Network Attached Storage)： 通过局域网在多个文件服务器之间实现了互联，基于文件的协议（ FTP、NFS、SMB/CIFS等 ），实现文件共享
•集中管理数据，从而释放带宽、提高性能
•可提供跨平台文件共享功能
•可靠性较差，适用于局域网或较小的网络

3. 存储区域网络(Storage Area Networks，SAN) 利用高速的光纤网络链接服务器与存储设备，基于SCSI，IP，ATM等多种高级协议，实现存储共享
•服务器跟储存装置两者各司其职
•利用光纤信道来传输数据﹐以达到一个服务器与储存装置之间多对多的高效能、高稳定度的存储环境
•实施复杂，管理成本高

4. 比较

|| DAS | NAS | SAN
- | - | - | -
传输类型| SCSI/FC | IP | IP/FC/SAS
数据类型| 数据块|文件 | 数据块
典型应用 | 任何 | 文件服务器| 数据库应用
优点 | 磁盘与服务器分离<br>便于统一管理|不占用应用服务器资源<br>广泛支持操作系统<br>扩展较容易<br>即插即用，安装简单 | 高扩展性，高可用性，数据集中，易管理
缺点| 连接距离短<br>数据分散，共享困难<br>存储空间利用率不高<br>扩展性有限|不适合存储量大的块级应用<br>数据备份及恢复占用网络带宽|相比NAS成本较高<br>安装和升级比NAS复杂

# 文件传输协议FTP
>File Transfer Protocol 早期的三个应用级协议之一
基于C/S结构
双通道协议：数据和命令连接
数据传输格式：二进制（默认）和文本

两种模式：

1. **主动(PORT style)：服务器主动连接**
命令（控制）：客户端:随机port <= => 服务器:tcp21
数据：客户端:随机port <= => 服务器:tcp20
2. **被动(PASV style)：客户端主动连接**
命令（控制）：客户端:随机port <= => 服务器:tcp21
数据：客户端:随机port <= => 服务器:随机port

+  服务器被动模式数据端口示例：
227 Entering Passive Mode (172,16,0,1,224,59)
服务器数据端口为：224*256+59=57403


## FTP软件介绍
+ FTP服务器：
1. Wu-ftpd，Proftpd，Pureftpd，ServU，IIS
2. `vsftpd`:Very Secure FTP Daemon，CentOS默认FTP服务器
高速，稳定，下载速度是WU-FTP的两倍
ftp.redhat.com数据:单机最多可支持15000个并发

+ 客户端软件：
1. ftp，lftp，lftpget，wget，curl
2. ftp -A ftpserver port  (-A主动模式 –p 被动模式)
3. lftp –u username ftpserver
4. lftpget ftp://ftpserver/pub/file
5. gftp：GUI centos5 最新版2.0.19 (11/30/2008)
6. filezilla，CuteFtp，FlashFXP，LeapFtp
7. 浏览器：ftp://username:password@ftpserver

## FTP服务
+ 状态码：
1XX：信息 125：数据连接打开
2XX：成功类状态 200：命令OK 230：登录成功
3XX：补充类 331：用户名OK
4XX：客户端错误 425：不能打开数据连接
5XX：服务器错误 530：不能登录

+ 用户认证：
    1. 匿名用户：ftp,anonymous
    2. 系统用户：Linux用户,用户/etc/passwd,密码/etc/shadow
    3. 虚拟用户：特定服务的专用用户，独立的用户/密码文件
    4. `nsswitch`:network service switch名称解析框架
    5. `pam`:pluggable authentication module 用户认证
        /lib64/security /etc/pam.d/ /etc/pam.conf

## vsftpd服务
>由vsftpd包提供

1. 用户认证配置文件：/etc/pam.d/vsftpd
2. 服务脚本： `/usr/lib/systemd/system/vsftpd.service`
`/etc/rc.d/init.d/vsftpd`
3. 配置文件：`/etc/vsftpd/vsftpd.conf`
4. 帮助：`man 5 vsftpd.conf`
5. 用户：
匿名用户（映射为系统用户ftp ）共享文件位置：/var/ftp
系统用户共享文件位置：用户家目录
虚拟用户共享文件位置：为其映射的系统用户的家目录


## vsftpd服务配置
### 1. 端口
1. 命令端口
```sh
listen_port=21
```
2. 主动模式端口
```sh
connect_from_port_20=YES  #主动模式端口为20
ftp_data_port=20 #（默认） 指定主动模式的端口
```
3. 被动模式端口范围
```sh
linux #客户端默认使用被动模式
windows #客户端默认使用主动模式
pasv_min_port=6000 #0为随机分配
pasv_max_port=6010
```
4. 使用当地时间
```sh
use_localtime=YES  #使用当地时间（默认为NO，使用GMT）
```

### 2. 用户
1. 匿名用户
```sh
anonymous_enable=YES #支持匿名用户
no_anon_password=YES #(默认NO) 匿名用户略过口令检查
anon_upload_enable=YES  #匿名上传，注意:文件系统权限
anon_mkdir_write_enable=YES  #匿名建目录
anon_world_readable_only  #(默认YES)只能下载全部读的文件
anon_umask=0333  #指定匿名上传文件的umask，默认077
anon_other_write_enable=YES  #可删除和修改上传的文件
#指定上传文件的默认的所有者和权限
chown_uploads=YES(默认NO)
chown_username=wang
chown_upload_mode=0644
```

2. Linux系统用户
```sh
local_enable=YES  #是否允许linux用户登录
write_enable=YES  #允许linux用户上传文件
local_umask=022  #指定系统用户上传文件的默认权限
guest_enable=YES  # 所有系统用户都映射成guest用户
guest_username=ftp  #配合上面选项才生效，指定guest用户
local_root=/ftproot guest  #用户登录所在目录
```
3. 禁锢所有系统用户在家目录中
```sh
chroot_local_user=YES（默认NO，不禁锢）禁锢系统用户
```

4. 禁锢或不禁锢特定的系统用户在家目录中，与上面设置功能相反 
```sh
chroot_list_enable=YES
chroot_list_file=/etc/vsftpd/chroot_list

chroot_local_user=YES #则chroot_list中用户不禁锢
#chroot_local_user=NO时，则chroot_list中用户禁锢
```

### 3. 日志
1. wu-ftp日志：默认启用
```sh
xferlog_enable=YES    #（默认） 启用记录上传下载日志
xferlog_std_format=YES    #（默认） 使用wu-ftp日志格式
xferlog_file=/var/log/xferlog    #（默认）可自动生成
```

2. vsftpd日志：默认不启用
```sh
dual_log_enable=YES    #使用vsftpd日志格式，默认不启用
vsftpd_log_file=/var/log/vsftpd.log   #（默认）可自动生成
```

### 4. 提示信息
1. 登录提示信息
```sh
ftpd_banner="welcome to mage ftp server"
banner_file=/etc/vsftpd/ftpbanner.txt
```
2. 目录访问提示信息
```sh
dirmessage_enable=YES   #(默认)
message_file=.message  #(默认) 信息存放在指定目录下.message
```

### 5. 使用pam完成用户认证
1. 
```sh
pam_service_name=vsftpd
```
2. pam配置文件:/etc/pam.d/vsftpd
```sh
/etc/vsftpd/ftpusers #默认文件中用户拒绝登录
```

3. 是否启用控制用户登录的列表文件
```sh
userlist_enable=YES   #默认有此设置
userlist_deny=YES  #默认值 黑名单,不提示口令，NO为白名单
userlist_file=/etc/vsftpd/users_list   #此为默认值
```

4. vsftpd服务指定用户身份运行
```sh
nopriv_user=nobody   #(默认值)
```

### 6. 传输

1. 连接数限制
```sh
max_clients=0   #最大并发连接数
max_per_ip=0   #每个IP同时发起的最大连接数
```

2. 传输速率：字节/秒
```sh
anon_max_rate=0   #匿名用户的最大传输速率
local_max_rate=0   #本地用户的最大传输速率
```
3. 连接时间：秒为单位
```sh
connect_timeout=60   #主动模式数据连接超时时长
accept_timeout=60   #被动模式数据连接超时时长
data_connection_timeout=300   #数据连接无数据输超时时长
idle_session_timeout=60   #无命令操作超时时长
```
4. 优先以文本方式传输
```sh
ascii_upload_enable=YES
ascii_download_enable=YES
```

- - -

## 实现基于SSL的FTPS
1. 查看是否支持SSL
```sh
ldd `which vsftpd` #查看到libssl.so
```

2. 创建自签名证书
```sh
cd /etc/pki/tls/certs/
make vsftpd.pem

#查看证书
openssl x509 -in vsftpd.pem -noout –text
```

3. 配置vsftpd服务支持SSL：/etc/vsftpd/vsftpd.conf
```sh
[101]$ vim /etc/vsftpd/vsftpd.conf
ssl_enable=YES #启用SSL
allow_anon_ssl=NO #匿名不支持SSL
force_local_logins_ssl=YES #本地用户登录加密
force_local_data_ssl=YES #本地用户数据传输加密
rsa_cert_file=/etc/pki/tls/certs/vsftpd.pem
```

4. 用filezilla等工具测试

## vsftpd虚拟用户
1. 虚拟用户：
所有虚拟用户会统一映射为一个指定的系统帐号：访问共享位置，即为此系统帐号的家目录
各虚拟用户可被赋予不同的访问权限，通过匿名用户的权限控制参数进行指定
2. 虚拟用户帐号的存储方式：
(1)文件：编辑文本文件，此文件需要被编码为hash格式
    奇数行为用户名，偶数行为密码
    db_load -T -t hash -f vusers.txt vusers.db

(2)关系型数据库中的表中：
    实时查询数据库完成用户认证
(3)mysql库：pam要依赖于pam-mysql
    /lib64/security/pam_mysql.so
    /usr/share/doc/pam_mysql-0.7/README

