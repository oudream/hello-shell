#!/usr/bin/env bash

### doc
# http://nginx.org/en/docs/
# https://docs.nginx.com/
# https://juejin.im/post/5d81906c518825300a3ec7ca


# 输出 NGINX 各文件夹的路径
nginx -V


# windows
http://nginx.org/download/nginx-1.16.1.zip
git clone https://github.com/oudream/nginx-v1.9.7
# config
./conf/nginx.conf # 默认配置


# ubuntu
apt install nginx
/etc/nginx/nginx.conf # 默认配置


# alpine
apk add nginx
/etc/nginx/nginx.conf # 默认配置


# macos osx
brew install nginx
/usr/local/etc/nginx/nginx.conf # 默认配置


### nginx
nginx -c "/ddd/web/nginx/conf-limi/nginx.conf"
nginx -t -c "/ddd/web/nginx/conf-limi/nginx.conf" # 只测试配置文件


# 启动 nginx
nginx

# 停止 nginx
nginx -s stop
# or
nginx -s quit


# 重载 nginx 配置
nginx -s reload
# or
nginx -s quit


# 指定配置文件
nginx -c /usr/local/nginx/conf/nginx.conf

# 检查配置文件是否正确
nginx -t /usr/local/nginx/conf/nginx.conf


# 帮助信息
nginx -h
#or
nginx -?


# 查看 Nginx 版本
nginx -v
# or
nginx -V


# 获得 pid
ps aux | grep nginx
# or
cat /path/to/nginx.pid


# 从容停止 nginx，等所有请求结束后关闭服务
ps aux | grep nginx
kill -QUIT  pid


# nginx 快速停止命令，立刻关闭进程
ps aux | grep nginx
kill -TERM pid
