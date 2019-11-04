#!/usr/bin/env bash


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
