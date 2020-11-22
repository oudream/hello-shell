#!/usr/bin/env bash


### sleep
# 5秒后执行 ls -a
sleep 5s; ls -a

# sleep : 默认为秒。
sleep 1s 表示延迟一秒
sleep 1m 表示延迟一分钟
sleep 1h 表示延迟一小时
sleep 1d 表示延迟一天

# usleep : 默认以微秒。
1s = 1000ms = 1000000us


### at
# minutes（分钟）、hours（小时）、days（天）、weeks（星期）
# 三天后的下午 5 点锺执行 /bin/ls
at 5pm+3 days
#at> /bin/ls
#at> <EOT>


### watch
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



cat >> /var/spool/cron/root <<EOF
* * * * * echo "xxx" >> /opt/tmp/0.txt
EOF
tail -f /var/log/cron

### cron crontab
# https://en.wikipedia.org/wiki/Cron
vim /var/spool/cron/root
crontab -e # 进入当前用户的工作表编辑，例如：/var/spool/cron/root

/var/spool/cron/ # 目录下存放的是每个用户包括root的crontab任务，每个任务以创建者的名字命名
/etc/crontab/    # 这个文件负责调度各种管理和维护任务。
/etc/cron.d/     # 这个目录用来存放任何要执行的crontab文件或脚本。
# 我们还可以把脚本放在 目录: <> 让它每小时/天/星期、月执行一次。
/etc/cron.hourly
/etc/cron.daily
/etc/cron.weekly
/etc/cron.monthly

# crontab的使用
# 我们常用的命令如下：
crontab [-u username]　#　　　//省略用户表表示操作当前用户的crontab
    -e      # (编辑工作表)
    -l      # (列出工作表里的命令)
    -r      # (删除工作作)
# 我们用crontab -e进入当前用户的工作表编辑，是常见的vim界面。每行是一条命令。

# crontab的命令构成为 时间+动作，其时间有分、时、日、月、周五种，操作符有
#    * 取值范围内的所有数字
#    / 每过多少个数字
#    - 从X到Z
#    ，散列数字
#
# 实例1：每1分钟执行一次myCommand
* * * * * myCommand

# 实例2：每小时的第3和第15分钟执行
3,15 * * * * myCommand

# 实例3：在上午8点到11点的第3和第15分钟执行
3,15 8-11 * * * myCommand

# 实例4：每隔两天的上午8点到11点的第3和第15分钟执行
3,15 8-11 */2  *  * myCommand

# 实例5：每周一上午8点到11点的第3和第15分钟执行
3,15 8-11 * * 1 myCommand

# 实例6：每晚的21:30重启smb
30 21 * * * /etc/init.d/smb restart

# 实例7：每月1、10、22日的4 : 45重启smb
45 4 1,10,22 * * /etc/init.d/smb restart

# 实例8：每周六、周日的1 : 10重启smb
10 1 * * 6,0 /etc/init.d/smb restart

# 实例9：每天18 : 00至23 : 00之间每隔30分钟重启smb
0,30 18-23 * * * /etc/init.d/smb restart

# 实例10：每星期六的晚上11 : 00 pm重启smb
0 23 * * 6 /etc/init.d/smb restart

# 实例11：每一小时重启smb
* */1 * * * /etc/init.d/smb restart

# 实例12：晚上11点到早上7点之间，每隔一小时重启smb
* 23-7/1 * * * /etc/init.d/smb restart

## install
# https://stackoverflow.com/questions/21802223/how-to-install-crontab-on-centos
yum remove cronie
yum install cronie
yum install crontabs
service crond start
service crond stop

yum install cronie # in centos
# yum install vixie-cron
yum install crontabs
# vixie-cron软件包是cron的主程序；
# crontabs软件包是用来安装、卸装、或列举用来驱动 cron 守护进程的表格的程序。
# //+++++++++++++++++++++++++++++++++++
# cron 是linux的内置服务，但它不自动起来，可以用以下的方法启动、关闭这个服务：
/sbin/service crond start # //启动服务
/sbin/service crond stop  # //关闭服务
/sbin/service crond restart # //重启服务
/sbin/service crond reload  # //重新载入配置
# 查看crontab服务状态：
service crond status
# 手动启动crontab服务：
service crond start
# 查看crontab服务是否已设置为开机启动，执行命令：
ntsysv
# 加入开机自动启动:
chkconfig --level 35 crond on
