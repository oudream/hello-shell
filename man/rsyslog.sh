
# rsyslog占用内存高
# https://blog.csdn.net/fanren224/article/details/103991748
# journalctl -u rsyslog查看状态
tail /var/log/messages  # 查看messages日志
#
journalctl --verify # 命令检查发现系统日志卷文件损坏错误：
# 1、删除上面损坏的journal文件
# 2、删除 /var/lib/rsyslog/imjournal.state文件
# 3、重启rsyslog。systemctl restart rsyslog
