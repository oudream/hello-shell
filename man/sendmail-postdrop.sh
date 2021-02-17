
# 解决crond引发大量sendmail、postdrop进程问题
  ps -ef | egrep "sendmail|postdrop" | awk '{print $2}' | xargs kill

# 解决办法：先把僵尸进程都干掉ps -ef | egrep "sendmail|postdrop" | grep -v grep |xargs kill，让内存降下来，其实我一开始将postfix服务重启了一下，问题就解决了，观察了一段时间，僵尸进程并没有再次出现。
# 为防以后postfix挂了再出现类似问题，可以进行如下配置，将crond的邮件通知关闭：
# 将/etc/crontab和/etc/cron.d/0hourly里的MAILTO=root修改为MAILTO=""
# crontab -e第一行增加一段MAILTO=""
