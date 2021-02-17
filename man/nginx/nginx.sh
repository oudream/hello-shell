#!/usr/bin/env bash

# docker
# simple static content
# https://hub.docker.com/_/nginx
docker run --name nginx1 -p 80:80 -d nginx
docker run --name nginx1 -p 80:80 -v /some/content:/usr/share/nginx/html:ro -d nginx
docker run --name nginx1 -p 80:80 -v /host/path/nginx.conf:/etc/nginx/nginx.conf:ro -d nginx

# news release
open http://hg.nginx.org/nginx/
open http://nginx.org/en/docs/
# Nginx：基本配置和日志处理
# https://www.cnblogs.com/Dy1an/p/11232207.html
# Nginx：rewrite / if / return / set 和变量
# https://www.cnblogs.com/Dy1an/p/11240223.html
# Nginx：location / root / alias
# https://www.cnblogs.com/Dy1an/p/11234740.html
# Nginx：TCP / 正向 / 反向代理 / 负载均衡
# https://www.cnblogs.com/Dy1an/p/11246021.html


# 查看安装了哪些模块,输出 NGINX 各文件夹的路径
nginx -V


# windows
http://nginx.org/download/nginx-1.16.1.zip
git clone https://github.com/oudream/nginx-v1.9.7
# config
./conf/nginx.conf # 默认配置


# centos
sudo yum -y install epel-release
sudo yum -y install nginx
sudo systemctl enable nginx
sudo systemctl start nginx
sudo systemctl status nginx
# 如果你的服务器开启了防火墙，则需要同时打开 80（HTTP）和 443（HTTPS）端口
# 通过下面的命令来打开这两个端口：
sudo firewall-cmd --permanent --zone=public --add-service=http
sudo firewall-cmd --permanent --zone=public --add-service=https
sudo firewall-cmd --reload


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



nginx -s quit
#  stop — fast shutdown
#  quit — graceful shutdown
#  reload — reloading the configuration file
#  reopen — reopening the log files
kill -s QUIT 1628
ps -ax | grep nginx

nginx -g "pid /var/run/nginx.pid; worker_processes `sysctl -n hw.ncpu`;"
#  -g directives — set global configuration directives, for example,
#  -c file — use an alternative configuration file instead of a default file.
#  -p prefix — set nginx path prefix, i.e. a directory that will keep server files (default value is /usr/local/nginx).
#  -q — suppress non-error messages during configuration testing.
#  -t — test the configuration file: nginx checks the configuration for correct syntax, and then tries to open files referred in the configuration.
#  -T — same as -t, but additionally dump configuration files to standard output (1.9.2).
#  -v — print nginx version.
#  -V — print nginx version, compiler version, and configure parameters.

# news release
open http://hg.nginx.org/nginx/

# doc
open http://nginx.org/en/docs/
# HTTPS servers
open http://nginx.org/en/docs/http/configuring_https_servers.html
# 中文 https://zhuanlan.zhihu.com/p/31202053
# 中文 https://juejin.im/post/5aa7704c6fb9a028bb18a993

open https://www.nginx.com/resources/wiki/start/topics/examples/full/
# guide
open http://nginx.org/en/docs/beginners_guide.html
# command-line parameters
open http://nginx.org/en/docs/switches.html

# download
open https://nginx.org/download/
open http://nginx.org/en/linux_packages.html

# nginx Cookbook
open https://github.com/sous-chefs/nginx
# NGINX-based Media Streaming Server
open https://github.com/arut/nginx-rtmp-module

# tutorials
open https://github.com/openresty/nginx-tutorials
open http://openresty.org/download/agentzh-nginx-tutorials-en.html
open http://blog.sina.com.cn/openresty

# kubernetes
open https://github.com/kubernetes/ingress-nginx

# Automated nginx proxy for Docker containers using docker-gen
open https://github.com/jwilder/nginx-proxy

# lua
open https://github.com/openresty/lua-nginx-module

### doc
# http://nginx.org/en/docs/
# https://docs.nginx.com/
# https://juejin.im/post/5d81906c518825300a3ec7ca
