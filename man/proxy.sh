#!/usr/bin/env bash

### proxy
git config --global http.proxy http://127.0.0.1:9980
git config --global https.proxy https://127.0.0.1:9980
git config --global http.proxy http://192.168.1.35:9980
git config --global https.proxy https://192.168.1.35:9980
git config --global http.proxy http://192.168.91.232:1080
git config --global https.proxy https://192.168.91.232:1080

git config --global --unset http.proxy
git config --global --unset https.proxy

npm config set proxy http://127.0.0.1:9980
npm config set https-proxy https://127.0.0.1:9980
npm config delete proxy
npm config delete https-proxy

http_proxy="http://10.31.58.78:9980/"
https_proxy="https://10.31.58.78:9980/"
no_proxy=localhost,127.0.0.0,127.0.0.1,127.0.1.1,local.home,10.31.58.86,10.31.58.99,10.31.58.101

127.0.0.1,localhost,10.31.58.*,10.32.50.*,10.31.16.*,10.30.0.*,hadoop-master,hadoop-slave1,hadoop-slave2,192.168.99.*

Scheme: https
Proxy Host: www.51netflix.com
Port: 1443

minikube start --docker-env http_proxy=$http_proxy --docker-env https_proxy=$https_proxy --docker-env no_proxy=$no_proxy

### go golang proxy
alias go='http_proxy=http://127.0.0.1:9980/ https_proxy=http://127.0.0.1:9980/ go'
export https_proxy=http://127.0.0.1:9980/
export http_proxy=http://127.0.0.1:9980/
export GO111MODULE=off
alias go='http_proxy=http://192.168.91.253:9980/ https_proxy=http://192.168.91.253:9980/ go'
export https_proxy=http://192.168.91.253:9980/
export http_proxy=http://192.168.91.253:9980/
export GO111MODULE=off
# 没有试的
export http_proxy=socks5://127.0.0.1:9980		# 梯子的本地端口
export https_proxy=$http_proxy
# go 1.11版本新增了 GOPROXY 环境变量，go get会根据这个环境变量来决定去哪里取引入库的代码
# 没有试的
# go 1.11版本新增了 GOPROXY 环境变量，go get会根据这个环境变量来决定去哪里取引入库的代码
export GOPROXY=https://goproxy.io
# 其中，https://goproxy.io 是一个goproxy.io这个开源项目提供的公开代理服务。

### oudream-ubuntu1
cd /fff/shadowsocksr
python3 ./shadowsocks/local.py

export local_ip=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | head -n 1)
export local_ip=127.0.0.1
#export local_ip=192.168.169.1
#export local_ip=10.35.191.11
export http_proxy=http://${local_ip}:9980
export HTTP_PROXY=$http_proxy
export https_proxy=https://${local_ip}:9980
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
npm config set proxy "http://127.0.0.1:9980"
npm config set https-proxy "https://127.0.0.1:9980"

ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | head -n 1
ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'



libqt5core5a libqt5gui5 libqt5widgets5 libqt5network5 libqt5xml5
export LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH


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
