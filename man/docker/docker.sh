#!/usr/bin/env bash

# https://docs.docker.com/engine/reference/commandline/ps/#formatting
docker ps --format "{{.ID}}: {{.Names}}: {{.Command}}: {{.Image}}: {{.CreatedAt}}: {{.Ports}}: {{.Status}}: {{.Size}}: {{.Mounts}}: {{.Networks}}"
docker ps --format "{{.ID}}\t{{.Names}}\t{{.Command}}\t{{.Networks}}"

docker exec -it --user root  3c15 bash

docker run -d -p 22:22 --name=CentOS7S1 centos:centos7 /bin/sh -c "while true; do echo hello world; sleep 1; done"
docker run -d -p 2201:22 centos7s1 /usr/sbin/sshd -D

docker rm -v $(docker ps -a -q -f status=exited)

docker kill -s KILL $(docker ps -a -q)
docker kill --signal=SIGINT $(docker ps -a -q)
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

docker rmi $(docker images alpine-ssh* -q)
docker rmi $(docker images -q)

docker top $containerId
docker ps --size
docker ps -a --no-trunc

docker network create --subnet=172.17.0.0/16 docker00

docker update --restart=always <container>
docker update --add-host lbm:10.0.0.12

docker image prune -a --force # clean cache

docker pull --platform=linux/arm64/v8 redis:6.2.5

# backup volume
docker run --rm -d --name test -v test-vol:/data test-img tail -f /dev/null f4ff81f4c31025ff476fbebc2c779a915b43ba5940b5bcc42e3ef9b1379eaeab
docker run --rm -v test-vol:/volume -v $PWD:/backup alpine tar cvf /backup/backup.tar /volume


# The host has a changing IP address (or none if you have no network access). From 18.03 onwards our recommendation is to connect to the special DNS name host.docker.internal, which resolves to the internal IP address used by the host. This is for development purpose and will not work in a production environment outside of Docker Desktop for Mac.
curl host.docker.internal:3306 # macos , windows 用 host.docker.internal 来访问宿主机.
nc -l 0.0.0.0 801
nc -zv 192.168.65.2 801 # macos
nc -zv 172.17.0.1 801 # linux


## 容器生命周期管理
run
start/stop/restart
kill
rm
pause/unpause
create
exec
## 容器操作
ps
inspect
top
attach
events
logs
wait
export
port
## 容器rootfs命令
commit
cp
diff
## 镜像仓库
login
pull
push
search
## 本地镜像管理
images
rmi
tag
build
history
save
load
import
## info|version
info
version

# registry.hub.docker.com/ or by using the command docker search <name>.
# For example, to find an image for Redis, you would use
docker search redis


## docker inspect : 获取容器/镜像的元数据。
## dockerfile from image
docker inspect [OPTIONS] NAME|ID [NAME|ID...]
docker inspect mysql:5.6
docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mymysql


## docker port :列出指定的容器的端口映射，或者查找将PRIVATE_PORT NAT到面向公众的端口。
# docker port [OPTIONS] CONTAINER [PRIVATE_PORT[/PROTO]]
# 查看容器mynginx的端口映射情况。
docker port mymysql
# 3306/tcp -> 0.0.0.0:3306


## docker ps : 列出容器
# docker ps [OPTIONS]
# -a :显示所有的容器，包括未运行的。
# -f :根据条件过滤显示的内容。
# --format :指定返回值的模板文件。
# -l :显示最近创建的容器。
# -n :列出最近创建的n个容器。
# --no-trunc :不截断输出。
# -q :静默模式，只显示容器编号。
# -s :显示总的文件大小。
# 列出最近创建的5个容器信息。
docker ps -n 5
# 列出所有创建的容器ID。
docker ps -a -q
# 根据标签过滤
docker run -d --name=test-nginx --label color=blue $imageId
docker run -d --name=alpine-1 $imageId tail -f /dev/null
docker ps --filter "label=color"
docker ps --filter "label=color=blue"
# 根据名称过滤
docker ps --filter"name=test-nginx"
# 根据状态过滤
docker ps -a --filter 'exited=0'
docker ps --filter status=running
docker ps --filter status=paused
# 根据镜像过滤
# 镜像名称
docker ps --filter ancestor=nginx
# 镜像ID
docker ps --filter ancestor=d0e008c6cf02
# 根据启动顺序过滤
docker ps -f before=9c3527ed70ce
docker ps -f since=6e63f6ff38b0


## docker events : 从服务器获取实时事件
# docker events [OPTIONS]
# -f ：根据条件过滤事件；
# --since ：从指定的时间戳后显示所有事件;
# --until ：流水时间显示到指定的时间为止；
# 显示docker 2016年7月1日后的所有事件。
docker events  --since="1467302400"
# 显示docker 镜像为mysql:5.6 2016年7月1日后的相关事件。
docker events -f "image"="mysql:5.6" --since="1467302400"


## docker logs : 获取容器的日志
# docker logs [OPTIONS] CONTAINER
# -f : 跟踪日志输出
# --since :显示某个开始时间的所有日志
# -t : 显示时间戳
# --tail :仅列出最新N条容器日志
# 跟踪查看容器mynginx的日志输出。
docker logs -f mynginx
# 查看容器mynginx从2016年7月1日后的最新10条日志。
docker logs --since="2016-07-01" --tail=10 mynginx


## docker run
# 使用docker镜像nginx:latest以后台模式启动一个容器,并将容器命名为mynginx。
docker run --name mynginx -d nginx:latest
# 使用镜像nginx:latest以后台模式启动一个容器,并将容器的80端口映射到主机随机端口。
docker run -P -d nginx:latest
#使用镜像 nginx:latest，以后台模式启动一个容器,将容器的 80 端口映射到主机的 80 端口,主机的目录 /data 映射到容器的 /data。
docker run -p 80:80 -v /data:/data -d nginx:latest
#绑定容器的 8080 端口，并将其映射到本地主机 127.0.0.1 的 80 端口上。
docker run -p 127.0.0.1:80:8080/tcp ubuntu bash
# 使用镜像nginx:latest以交互模式启动一个容器,在容器内执行/bin/bash命令。
docker run -it nginx:latest /bin/bash
# 追加命令参数
docker run --entrypoint /bin/bash mysql:latest ...
# 给出容器入口的后续命令参数
docker run --entrypoint="/bin/bash" mysql:latest ...
# 覆盖ENTRYPOINT指令
docker run -it --entrypoint="" mysql:latest bash
docker run -it --entrypoint="" mysql:latest bash
# 覆盖CMD指令
docker run ... New_Command
# The my-label key doesn’t specify a value so the label defaults to an empty string ("").
# To add multiple labels, repeat the label flag (-l or --label).
docker run -l my-label --label com.example.foo=bar ubuntu bash
# This will run the redis container with a restart policy of always so that
# if the container exits, Docker will restart it.
docker run --restart=always redis

docker start [OPTIONS] CONTAINER [CONTAINER...]
docker stop [OPTIONS] CONTAINER [CONTAINER...]
docker restart [OPTIONS] CONTAINER [CONTAINER...]


# docker pause :暂停容器中所有的进程。
# docker unpause :恢复容器中所有的进程。
# docker pause [OPTIONS] CONTAINER [CONTAINER...]
# docker unpause [OPTIONS] CONTAINER [CONTAINER...]
# 暂停数据库容器db01提供服务。
docker pause db01
# 恢复数据库容器db01提供服务。
docker unpause db01


## docker kill [OPTIONS] CONTAINER [CONTAINER...]
# -s :向容器发送一个信号
docker kill -s KILL mynginx


## docker rm ：删除一个或多少容器
docker rm [OPTIONS] CONTAINER [CONTAINER...]
# -f :通过SIGKILL信号强制删除一个运行中的容器
# -l :移除容器间的网络连接，而非容器本身
# -v :-v 删除与容器关联的卷
docker rm -v $(docker ps -a -q -f status=exited)


##docker wait : 阻塞运行直到容器停止，然后打印出它的退出代码。
#docker wait [OPTIONS] CONTAINER [CONTAINER...]
#docker wait CONTAINER


## 查看容器mymysql的进程信息。
docker top mymysql
# 查看所有运行容器的进程信息。
for i in  `docker ps |grep Up|awk '{print $1}'`;do echo \ &&docker top $i; done


## docker history : 查看指定镜像的创建历史。
docker history [OPTIONS] IMAGE
# -H :以可读的格式打印镜像大小和日期，默认为true；
# --no-trunc :显示完整的提交记录；
# -q :仅列出提交记录ID。
docker history runoob/ubuntu:v3


## docker exec/attach
# docker exec ：在运行的容器中执行命令
# docker exec [OPTIONS] CONTAINER COMMAND [ARG...]
# -d :分离模式: 在后台运行
# -i :即使没有附加也保持STDIN 打开
# -t :分配一个伪终端
# 在容器 mynginx 中以交互模式执行容器内 /root/runoob.sh 脚本:
docker exec -it mynginx /bin/sh /root/runoob.sh
# 在容器 mynginx 中开启一个交互模式的终端:
docker exec -i -t  mynginx /bin/bash
docker exec -it 9df70f9a0714 /bin/bash
docker attach --sig-proxy=false mynginx
docker exec -it $ContainerID /bin/bash
docker exec -it e3338bd4ce6b /bin/sh
docker exec -it db env


## docker network
docker network create
docker network connect
docker network ls
docker network rm
docker network disconnect
docker network inspect
# 在安装Docker Engine时会自动创建一个默认的bridge网络docker0。
# 此外，还可以创建自己的bridge网络或overlay网络。
# bridge网络依附于运行Docker Engine的单台主机上，而overlay网络能够覆盖运行各自Docker Engine的多主机环境中。
# 不指定网络驱动时默认创建的bridge网络
docker network create simple-network
# 查看网络内部信息
docker network inspect simple-network
# 应用到容器时，可进入容器内部使用ifconfig查看容器的网络详情
# 创建网络时，使用参数`-d`指定驱动类型为overlay
docker network create -d overlay my-multihost-network


### docker
# docker-server control
service docker start
systemctl start docker
service docker stop
systemctl stop docker

docker run -t -i ubuntu /bin/bash # start ubuntu in interaction
docker ps -a
docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $INSTANCE_ID # Get an instance’s IP address
docker inspect --format='{{range .NetworkSettings.Networks}}{{.MacAddress}}{{end}}' $INSTANCE_ID # Get an instance’s MAC address
docker inspect --format='{{.LogPath}}' $INSTANCE_ID # Get an instance’s log path
docker system prune -a # clean cache
docker volume create portainer_data
docker run -d -p 9000:9000 --restart=always --name portainer -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer
# Folder Directory
#~/Library/Containers/com.docker.docker
#/var/lib/docker


## docker create ：创建一个新的容器但不启动它
# 用法同 docker run
# docker create [OPTIONS] IMAGE [COMMAND] [ARG...]
# 使用docker镜像nginx:latest创建一个容器,并将容器命名为myrunoob
docker create  --name myrunoob  nginx:latest


# -a :提交的镜像作者；
# -c :使用Dockerfile指令来创建镜像；
# -m :提交时的说明文字；
# -p :在commit时，将容器暂停。
docker commit -p 3089dd928de3 hello-twant:1.0.3


## docker export :将文件系统作为一个tar归档文件导出到STDOUT。
# docker export [OPTIONS] CONTAINER
# -o :将输入内容写到文件。
# 将id为a404c6c174a2的容器按日期保存为tar文件。
docker export -o mysql-`date +%Y%m%d`.tar a404c6c174a2


## docker save : 将指定镜像保存成 tar 归档文件。
# docker save [OPTIONS] IMAGE [IMAGE...]
# -o :输出到的文件。
# 将镜像 runoob/ubuntu:v3 生成 my_ubuntu_v3.tar 文档
docker save -o my_ubuntu_v3.tar runoob/ubuntu:v3

###
# error
# docker pull --platform=linux/arm64/v8 redis:6.2.5

docker pull aarch64/redis
docker save -o aarch64-redis.tar aarch64/redis
cat aarch64-redis.tar | docker import - aarch64/redis
docker run --name redis1 -d -p 6379:6379 aarch64/redis redis-server
docker run --rm aarch64/redis ls

docker pull arm64v8/redis:5.0.13

docker pull arm64v8/redis:6.2.5
docker save -o arm64v8-redis-6.2.5.tar arm64v8/redis:6.2.5
cat arm64v8-redis-6.2.5.tar | docker import - arm64v8/redis:6.2.5
docker run --name redis1 -d -p 6379:6379 arm64v8/redis:6.2.5 /usr/local/bin/redis-server
docker run --rm arm64v8/redis:6.2.5 ls
docker run --name redis1 -d -p 6379:6379 arm64v8/redis:6.2.5 bash -c "while true; do echo hello world; sleep 1; done"
docker rm redis1


docker pull arm64v8/mariadb:10.2
docker save -o mysql.docker.tar arm64v8/mariadb:10.2
cat mysql.docker.tar | docker import - arm64v8/mariadb:10.2
docker run -p 127.0.0.1:3306:3306  --name some-mariadb -e MARIADB_ROOT_PASSWORD="Aa.123456" -d arm64v8/mariadb:10.2

## docker load : 导入使用 docker save 命令导出的镜像。
# docker load [OPTIONS]
# -i :指定导出的文件。
# -q :精简输出信息。
# 导入镜像：
docker load -i ubuntu.tar


## docker image
# 默认情况下Docker的存放位置为：/var/lib/docker
# 可以通过下面命令查看具体位置：
sudo docker info | grep "Docker Root Dir"
# Error response from daemon: conflict: unable to delete c5d80f5c2af6 (must be forced) - image is referenced in multiple repositories
# forced remove
docker image rm -f c5d80f5c2af6

ps -l --ppid=683
pstree -c -p -A $(pgrep dockerd)
### docker 进程过程
# dockerd(685) -> docker-containe(747) -> docker-containe(1826) -> redis-server(1839)
#4 S     0   685     1  0  80   0 - 134192 ep_pol ?       00:00:03 dockerd
#4 S     0   747   685  0  80   0 - 91630 futex_ ?        00:00:01 docker-containe
#4 S     0  1826   747  0  80   0 -  1879 futex_ ?        00:00:00 docker-containe
#4 S   999  1839  1826  0  80   0 -  6313 ep_pol ?        00:00:01 redis-server

# katacoda What is a container? Processes
# Containers are just normal Linux Processes with additional configuration applied. Launch the following Redis container so we can see what is happening under the covers.
docker run -d --name=db redis:alpine

# The Docker container launches a process called redis-server. From the host, we can view all the processes running, including those started by Docker.
ps aux | grep redis-server

# Docker can help us identify information about the process including the PID (Process ID) and PPID (Parent Process ID) via
docker top db
# Who is the PPID? Use
ps aux | grep <ppid>
# to find the parent process. Likely to be Containerd.

# The command pstree will list all of the sub processes. See the Docker process tree using
pstree -c -p -A $(pgrep dockerd)

# As you can see, from the viewpoint of Linux, these are standard processes and have the same properties as other processes on our system.

# Process Directory
# Linux is just a series of magic files and contents, this makes it fun to explore and navigate to see what is happening under the covers, and in some cases, change the contents to see the results.
# The configuration for each process is defined within the /proc directory. If you know the process ID, then you can identify the configuration directory.
# The command below will list all the contents of /proc, and store the Redis PID for future use.

DBPID=$(pgrep redis-server)
echo Redis is $DBPID
ls /proc

# Each process has it's own configuration and security settings defined within different files.
ls /proc/$DBPID
# For example, you can view and update the environment variables defined to that process.
cat /proc/$DBPID/environ
docker exec -it db env


docker run -d --rm alpine /bin/sh -c "while sleep 2;do printf aaabbbccc134\\n; done;"
docker run -i -t crystal/mono-base bash -c "/usr/local/bin/mono /home/crystal/Downloads/BackgroundProcesser.exe & /bin/bash"


### install aarch64
- https://www.jianshu.com/p/9ddcee50258e
- https://download.docker.com/linux/static/stable/

### install - ubuntu
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo docker run hello-world

### install - centos
sudo yum install -y yum-utils
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
sudo yum-config-manager --enable docker-ce-nightly
sudo yum-config-manager --enable docker-ce-test
sudo yum -y install docker-ce docker-ce-cli containerd.io
sudo docker run hello-world
# 修改docker工作目录
mkdir -p /etc/docker
mkdir -p /usr/local/docker/data
cat >> /etc/docker/daemon.json <<EOF
{
  "data-root": "/userdata/docker/data"
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "200m",
    "max-file": "7"
  },
  "live-restore": true
}
EOF
# 啟動
sudo systemctl enable docker
sudo systemctl disable docker
sudo systemctl start docker
sudo systemctl stop docker
sudo systemctl restart docker
# 修改完成后reload配置文件
sudo systemctl daemon-reload
# 重启docker服务
sudo systemctl restart docker.service


# 清理Docker占用的磁盘空间
docker system df
docker system prune     # 命令可以用于清理磁盘，删除关闭的容器、无用的数据卷和网络，以及 dangling 镜像(即无 tag 的镜像)。
docker system prune -a  # 命令清理得更加彻底，可以将没有容器使用 Docker 镜像都删掉。

### arm64 buildx
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
mkdir ~/.docker
cat << EOF > ~/.docker/config.json
{
  "experimental": "enabled"
}
EOF
docker buildx ls

