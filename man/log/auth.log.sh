#!/usr/bin/env bash

# 查看用密码登陆成功的IP地址及次数
grep "Accepted password for root" /var/log/auth.log | awk '{print $11}' | sort | uniq -c | sort -nr | more

# 查看用密码登陆失败的IP地址及次数
grep "Failed password for root" /var/log/auth.log | awk '{print $11}' | sort | uniq -c | sort -nr | more

# 更改默认端口
sed -i.bak "s/Port .*/Port 9122/g" /etc/ssh/sshd_config

