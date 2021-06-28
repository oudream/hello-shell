
@[toc]

# Docker 安装及基础命令介绍：
> 官方网址： https://www.docker.com/

**系统版本选择：**
> Docker 目前已经支持多种操作系统的安装运行， 比如 **Ubuntu**、 **CentOS**、**Redhat**、 **Debian**、 **Fedora**，甚至是还支持了 Mac 和 Windows，在 linux 系统上需要内核版本在 3.10 或以上， docker 版本号之前一直是 0.X 版本或 1.X 版本，但是从 2017 年 3 月 1 号开始改为每个季度发布一次稳版，其版本号规则也统一变更为 YY.MM， 例如 17.09 表示是 2017 年 9 月份发布的， 本次演示的操作系统使用 Centos 7.5 为例。

**Docker 版本选择：**
> Docker 之前没有区分版本，但是 2017 年推出(将 docker 更名为)新的项目Moby， github 地址： https://github.com/moby/moby， Moby 项目属于 Docker 项目的全新上游， Docker 将是一个隶属于的 Moby 的子产品，而且之后的版本之后开始区分为 CE 版本（社区版本） 和 EE（企业收费版）， CE 社区版本和 EE 企业版本都是每个季度发布一个新版本，但是 EE 版本提供后期安全维护 1 年， 而CE 版本是 4 个月， 本次演示的 Docker 版本为 18.03，

---
## Docker安装
### 下载 rpm 包安装：
> 官方 rpm 包下载地址:
https://download.docker.com/linux/centos/7/x86_64/stable/Packages/

> 阿里镜像下载地址：
https://mirrors.aliyun.com/docker-ce/linux/centos/7/x86_64/stable/Packages/

### Centos yum 源安装：
1. 下载docker源
```bash
rm -rf /etc/yum.repos.d/*
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
wget -O /etc/yum.repos.d/docker-ce.repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
```
2. 安装
```bash
yum install docker-ce
```
3. 启动
```bash
systemctl start docker
systemctl enable docker
```

### Ubuntu 安装
> 版本： Ubuntu 18.04.3
> 参考： https://yq.aliyun.com/articles/110806

> * <b><font color=red> 阿里脚本安装最新版 </font></b>
1. 使用官方安装脚本自动安装 （仅适用于公网环境）
```bash
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
```

> * <b><font color=red> 自定义版本下载 </font></b>
0. 配置阿里yum源
```bash
sudo vim /etc/apt/sources.list
```
```bash
deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
```
1. 安装必要的一些系统工具
```bash
sudo apt-get update
sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
```
2. 安装GPG证书
```bash
curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
```
3. 写入软件源信息
```bash
sudo add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
```
4. 更新
```bash
sudo apt-get -y update
```
5. 查找Docker-CE的版本:
```bash
# apt-cache madison docker-ce
docker-ce | 5:19.03.2~3-0~ubuntu-bionic | http://mirrors.aliyun.com/docker-ce/linux/ubuntu bionic/stable amd64 Packages
docker-ce | 5:19.03.1~3-0~ubuntu-bionic | http://mirrors.aliyun.com/docker-ce/linux/ubuntu bionic/stable amd64 Packages
...
```
6. 安装指定版本的Docker-CE: (VERSION 例如上面的 17.03.1~ce-0~ubuntu-xenial)
```bash
sudo apt install docker-ce-cli=5:18.09.9~3-0~ubuntu-bionic
sudo apt install docker-ce=5:18.09.9~3-0~ubuntu-bionic
```

7. 验证版本
```bash
# docker version
Client:
 Version:           18.09.9
 API version:       1.39
 Go version:        go1.11.13
 Git commit:        039a7df9ba
 Built:             Wed Sep  4 16:57:28 2019
 OS/Arch:           linux/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          18.09.9
  API version:      1.39 (minimum version 1.12)
  Go version:       go1.11.13
  Git commit:       039a7df
  Built:            Wed Sep  4 16:19:38 2019
  OS/Arch:          linux/amd64
  Experimental:     false
```

8. 验证docker信息
```bash
# docker info
Containers: 0
 Running: 0
 Paused: 0
 Stopped: 0
Images: 0
Server Version: 18.09.9
Storage Driver: overlay2
 Backing Filesystem: extfs
 Supports d_type: true
 Native Overlay Diff: true
Logging Driver: json-file
Cgroup Driver: cgroupfs
Plugins:
 Volume: local
 Network: bridge host macvlan null overlay
 Log: awslogs fluentd gcplogs gelf journald json-file local logentries splunk syslog
Swarm: inactive
Runtimes: runc
Default Runtime: runc
Init Binary: docker-init
containerd version: 894b81a4b802e4eb2a91d1ce216b8817763c29fb
runc version: 425e105d5a03fabd737a126ad93d62a9eeede87f
init version: fec3683
Security Options:
 apparmor
 seccomp
  Profile: default
Kernel Version: 4.15.0-62-generic
Operating System: Ubuntu 18.04.3 LTS
OSType: linux
Architecture: x86_64
CPUs: 2
Total Memory: 1.861GiB
Name: ubuntu
ID: 2C5Z:IASC:G3GK:325R:RDGI:GDJ4:23EE:O76B:Z2RY:HY5U:RSLC:J7OO
Docker Root Dir: /var/lib/docker
Debug Mode (client): false
Debug Mode (server): false
Registry: https://index.docker.io/v1/
Labels:
Experimental: false
Insecure Registries:
 127.0.0.0/8
Live Restore Enabled: false
Product License: Community Engine

WARNING: No swap limit support
```
最后一行有个WARNING: <b><font color=red> WARNING: No swap limit support </font></b>
解决方法：
```bash
sudo vim /etc/default/grub
```
在`GRUB_CMDLINE_LINUX=""`这行加上
```ini
GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"
```
更新下grub，然后重启
```bash
sudo update-grub
reboot
```


---
## Docker命令
1. 查看信息
```bash
docker info
```
2. 查看版本
```bash
docker version
```
3. 查看当前容器状态
```bash
docker ps 
```
4. 查询镜像
```bash
docker search nginx
```
5. 获取镜像
```bash
docker pull nginx
```
6. 查看已有镜像
```bash
docker images
```
7. 进入容器后，安装基础命令：
```bash
apt update
apt install procps
apt install iputils-ping
apt install net-tools
```

### 启动容器
```bash
# 启动一个在后台运行的 docker 容器
docker run -it -d --name 'test-nginx' nginx

# -p指定端口映射，
-p 80:80

# 指定 ip 地址和传输协议 udp 或者 tcp:  
-p 192.168.7.108:80:80/tcp

# 也可以在创建时手动指定容器的 dns
--dns 223.6.6.6 

# 指定名称
--name "centos3"
```

```bash
vi docker-enter.sh
chmod +x docker-enter.sh 
```

### 进入容器

1. 使用执行命令方式进入容器
```bash
docker exec -it 32ffb5ac7566 bash
```
2. 使用使用容器 pid 方式进入容器
```bash
docker inspect  -f  "{{.State.Pid}}"  02a1907e7c89
    19080 
nsenter -t 19080 -m -u -i -n -p
```
3. 脚本方式进入容器
```bash
#!/bin/bash
docker_in(){

    NAME_ID=$1
    PID=$(docker inspect -f "{{.State.Pid}}" ${NAME_ID})
    nsenter -t ${PID} -m -u -i -n -p 

}

docker_in $1
```
启动
```bash
./docker-enter.sh centos-test
```

### 更多命令
以镜像名：nginx为例子

1. 删除 docker 镜像
```bash
docker rmi nginx
```
2. 手动导出 docker 镜像
```bash
docker save nginx -o /root/nginx.tar.gz
docker save nginx > /root/nginx.tar.gz
```
3. 手动导入 docker 镜像
```bash
docker load -i nginx.tar.gz 
docker load < nginx.tar.gz 
```
4. 停止和启动一个容器
```bash
# d5ab2595f09a是CONTAINER ID
docker stop d5ab2595f09a
docker start d5ab2595f09a
```
5. 删除一个已经停止的容器
```bash
docker rm d5ab2595f09a
```
6. 强制关闭一个运行中的容器
```bash
docker kill d1ad4fa0b74c
```

---
## docker 镜像加速配置：
国内下载国外的镜像有时候会很慢，因此可以更改 docker 配置文件添加一个加速器， 可以通过加速器达到加速下载镜像的目的。

### 获取加速地址：
浏览器打开 http://cr.console.aliyun.com， 注册或登录阿里云账号，点击左侧的镜像加速器， 将会得到一个专属的加速地址， 而且下面有使用配置说明：
[外链图片转存失败(img-bCW6VWRm-1568195007907)(png/2019-09-09-19-57-45.png)]
[外链图片转存失败(img-fFcKYkl4-1568195007908)(png/2019-09-09-20-02-20.png)]

1. 可以通过修改daemon配置文件/etc/docker/daemon.json来使用加速器
```bash
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["你的加速地址"]
}
EOF
```
2. 重启服务
```bash
sudo systemctl daemon-reload
sudo systemctl restart docker
```