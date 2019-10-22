#!/usr/bin/env bash

# 5秒后执行 ls -a
sleep 5s; ls -a

### at
# minutes（分钟）、hours（小时）、days（天）、weeks（星期）
# 三天后的下午 5 点锺执行 /bin/ls
at 5pm+3 days
#at> /bin/ls
#at> <EOT>


# sleep : 默认为秒。
sleep 1s 表示延迟一秒
sleep 1m 表示延迟一分钟
sleep 1h 表示延迟一小时
sleep 1d 表示延迟一天

# usleep : 默认以微秒。
1s = 1000ms = 1000000us

# 每隔一秒高亮显示网络链接数的变化情况
watch -n 1 -d netstat -ant
# 每隔一秒高亮显示http链接数的变化情况
watch -n 1 -d 'pstree|grep http'
# 实时查看模拟攻击客户机建立起来的连接数
watch 'netstat -an | grep:21 | \ grep<模拟攻击客户机的IP>| wc -l'
# 监测当前目录中 scf' 的文件的变化
watch -d 'ls -l|grep scf'
# 10秒一次输出系统的平均负载
watch -n 10 'cat /proc/loadavg'