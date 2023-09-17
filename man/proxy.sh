#!/usr/bin/env bash

### proxy
git config --global http.proxy http://10.50.52.32:7890
git config --global https.proxy https://10.50.52.32:7890
git config --global http.proxy http://127.0.0.1:7890
git config --global https.proxy https://127.0.0.1:7890

git config --global --unset http.proxy
git config --global --unset https.proxy

npm config set proxy http://127.0.0.1:7890 -g
npm config set https-proxy https://127.0.0.1:7890 -g
yarn config set proxy http://127.0.0.1:7890 -g
yarn config set https-proxy https://127.0.0.1:7890 -g

npm config delete proxy -g
npm config delete https-proxy -g
npm config delete registry -g
npm config delete disturl -g
yarn config delete proxy -g
yarn config delete https-proxy -g
yarn config delete registry -g
yarn config delete disturl -g

http_proxy="http://127.0.0.1:7890/"
https_proxy="https://127.0.0.1:7890/"

no_proxy=localhost,127.0.0.0,127.0.0.1,127.0.1.1,local.home,10.31.58.86,10.31.58.99,10.31.58.101

127.0.0.1,localhost,10.31.58.*,10.32.50.*,10.31.16.*,10.30.0.*,hadoop-master,hadoop-slave1,hadoop-slave2,192.168.99.*

cargo --config http.proxy=\"http://127.0.0.1:7890\" --config https.proxy=\"https://127.0.0.1:7890\" build

# https://stackoverflow.com/questions/23111631/cannot-download-docker-images-behind-a-proxy
mkdir /etc/systemd/system/docker.service.d/ && cd /etc/systemd/system/docker.service.d/
vi http-proxy.conf
[Service]
Environment="HTTP_PROXY=http://127.0.0.1:7890/"
Environment="HTTPS_PROXY=http://127.0.0.1:7890/"
Environment="NO_PROXY=localhost,127.0.0.0/8,192.168.91.0/8,docker-registry.somecorporation.com"
#
sudo systemctl daemon-reload
sudo systemctl restart docker


Scheme: https
Proxy Host: www.51netflix.com
Port: 1443

minikube start --docker-env http_proxy=$http_proxy --docker-env https_proxy=$https_proxy --docker-env no_proxy=$no_proxy

### go golang proxy
### Bash (Linux or macOS)
# 配置 GOPROXY 环境变量
export GOPROXY=https://proxy.golang.com.cn,direct
# 还可以设置不走 proxy 的私有仓库或组，多个用逗号相隔（可选）
export GOPRIVATE=git.mycompany.com,github.com/my/private
# or
alias go='http_proxy=http://127.0.0.1:7890/ https_proxy=http://127.0.0.1:7890/ go'
#
### PowerShell (Windows)
# 配置 GOPROXY 环境变量
$env:GOPROXY = "https://proxy.golang.com.cn,direct"
# 还可以设置不走 proxy 的私有仓库或组，多个用逗号相隔（可选）
$env:GOPRIVATE = "git.mycompany.com,github.com/my/private"

# 没有试的
export http_proxy=socks5://127.0.0.1:7890		# 梯子的本地端口
export https_proxy=$http_proxy

### oudream-ubuntu1
cd /fff/shadowsocksr
python3 ./shadowsocks/local.py

export local_ip=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | head -n 1)
export local_ip=127.0.0.1
#export local_ip=192.168.169.1
#export local_ip=10.35.191.11
export http_proxy=http://${local_ip}:7890
export HTTP_PROXY=$http_proxy
export https_proxy=https://${local_ip}:7890
export HTTPS_PROXY=$https_proxy
#export ftp_proxy=socks5://${local_ip}:1086
export ftp_proxy=socks5://${local_ip}:8118
export FTP_PROXY=${ftp_proxy}
export all_proxy=${ftp_proxy}
export ALL_PROXY=${all_proxy}
export no_proxy=127.0.0.1,localhost,192.168.0.*,192.168.1.*,192.168.99.*,10.31.58.*,10.32.50.*,10.31.16.*,10.30.0.*,hadoop-master,hadoop-slave1,hadoop-slave2
export NO_PROXY=$no_proxy

git config --global http.proxy ${http_proxy}
git config --global https.proxy ${https_proxy}
git config --global --unset http.proxy
git config --global --unset https.proxy

npm config set proxy ${http_proxy}
npm config set https-proxy ${https_proxy}
npm config delete proxy
npm config delete https-proxy

ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | head -n 1
ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'

unset local_ip
unset http_proxy
unset HTTP_PROXY
unset https_proxy
unset HTTPS_PROXY
unset ftp_proxy
unset FTP_PROXY
unset all_proxy
unset ALL_PROXY
unset no_proxy
unset NO_PROXY
