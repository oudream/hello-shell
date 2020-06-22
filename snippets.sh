Z.a-135246-a.Z

# dir-file count
find . -maxdepth 1 -type d | while read dir; do count=$(find "$dir" -type f | wc -l); echo "$dir : $count"; done


# ssh google1
ssh root@34.70.15.201 -AXY -v
# ssh tencent
ssh root@122.51.12.151 -AXY
# ssh vultr
ssh root@209.250.224.158 -AXY
# ssh llb
ssh root@106.13.225.200 -AXY
# ssh ssr
ssh root@149.248.45.13 -AXY -v


# ip google
34.70.15.201
# ip tencent
122.51.12.151
# ip llb
106.13.225.200
# ip vultr
45.76.243.243
# ip windows
111.229.78.27
# pwd-limi
limi.135246
# pwd-z
Z-j8$S5-E@}[97?1
# pwd-llb
lulb@zh519015


# cmake . -G "Xcode"...
cmake . -G "Xcode" --build "/ddd/communication/protobuf/protobuf/cmake" -B"/ddd/communication/protobuf/protobuf/cmake-xcode"
# minikubestart
minikube start --docker-env HTTP_PROXY=$http_proxy --docker-env HTTPS_PROXY=$https_proxy --docker-env NO_PROXY=$no_proxy
# portainer
docker run -d -p 9000:9000 --restart=always --name portainer -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer


### git 
# update
git pull origin master
# reset
git reset --hard origin/master
# submodule add
git submodule add 
# submodule update
git submodule update --remote

# git clone
git clone --recursive

# proxy-pre
export local_ip=10.31.58.125
# proxy
#export local_ip=$(ifconfig | grep -Eo &apos;inet (addr:)?([0-9]*\.){3}[0-9]*&apos; | grep -Eo &apos;([0-9]*\.){3}[0-9]*&apos; | grep -v &apos;127.0.0.1&apos; | head -n 1)
#export local_ip=192.168.0.101
export http_proxy=http://${local_ip}:1080
export https_proxy=$http_proxy
export HTTPS_PROXY=$http_proxy
export HTTP_PROXY=$http_proxy
export ftp_proxy=socks5://${local_ip}:1086
export FTP_PROXY=${ftp_proxy}
export no_proxy=127.0.0.1,localhost,192.168.0.*,192.168.1.*,192.168.99.*,10.31.58.*,10.32.50.*,10.31.16.*,10.30.0.*,hadoop-master,hadoop-slave1,hadoop-slave2
export NO_PROXY=$no_proxy

# 127.0.0.1,localhost...
# 127.0.0.1、localhost、10.31.58.*、10.31.16.*、hadoop-master、hadoop-slave1、hadoop-slave2、jianshu.com、ics-ubuntu1、ics-ubuntu2、ics-ubuntu3
# ifconfig en0 ether
sudo ifconfig en0 up
sudo ifconfig en0 ether F0:DE:F1:B4:2A:82
sudo ifconfig en0 down
sudo ifconfig en0 up

# mount 215
sudo mount -t cifs -o username=administrator,password=ygct@12345678 //10.31.58.215/d /eee/215d
# mount 11
sudo mount -t cifs //10.35.191.11/ddd /eee/11d -o username=oudream,password=oudream,nounix,sec=ntlmssp
# ssh -X
ssh -X 10.35.191.11 "DISPLAY=:0.0 pbcopy -i"

# source activate keras-p3
source activate keras-p3
# keras-p3 jupyter
screen -S jupyter-p3
source activate keras-p3
jupyter notebook

# keras-p2 jupyter
screen -S jupyter-p2
source activate keras-p2
jupyter notebook
# jupyter notebook --...
jupyter notebook --no-browser --port 8901 --ip=10.35.191.17
# nginx limi-server
nginx -c "/ddd/web/nginx/conf-limi-server/nginx.conf"
# julia
/Applications/Julia-1.0.app/Contents/Resources/julia/bin/julia
# IJulia
using IJulia
notebook()

### sn
# baidu-w-k
# mban3947
# baidu-w-k-p
# 2448176
