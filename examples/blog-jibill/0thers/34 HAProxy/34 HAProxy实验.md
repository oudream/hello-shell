[toc]

# listen简单使用
```bash
listen web
        bind 172.20.27.21:80        #定义监听的地址和端口
        server web1 172.20.27.31:80     #定义后端服务器
        server web2 172.20.27.32:80
```

1. 日志
```bash
$UDPServerRun 514
local3.*                                                /var/log/haproxy.log            #此处改为和配置文件相同的格式
```

# keepalived高可用方案
1. 安装
```bash
yum -y install keepalived haproxy psmisc
```

```bash
vim /etc/keepalived/keepalived.conf

! Configuration File for keepalived
global_defs {
   router_id LVS_DEVEL
}

vrrp_script chk_haproxy {                        #Haproxy服务启动
   script "killall -0 haproxy"     #监控haproxy进程的脚本, 根据自己的实际路径放置
   interval 2
   weight -4
   fall 2
   rise 1
}

vrrp_instance VI_1 {
   state MASTER                  #主机为MASTER，备机为BACKUP
   interface eth0                #监测网络端口，用ipconfig查看
   virtual_router_id 51          #主备机必须相同
   priority 150                  #主备机取不同的优先级，主机要大。从服务器上改为120
   advert_int 1                  #VRRP Multicast广播周期秒数

   authentication {
       auth_type PASS            #VRRP认证方式
       auth_pass 1111            #VRRP口令 主备机密码必须相同
   }

   track_script {                #调用haproxy进程检测脚本
       chk_haproxy
   }

   virtual_ipaddress {
      192.168.0.100 dev eth0 label eth0:1           #VIP
   }
}
```
```bash

```