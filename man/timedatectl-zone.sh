
# 查看系统时间方面的各种状态
timedatectl status

# 列出所有时区
timedatectl list-timezones

# 将硬件时钟调整为与本地时钟一致, 0 为设置为 UTC 时间
timedatectl set-local-rtc 1

# 设置系统时区为上海
timedatectl set-timezone Asia/Shanghai
#
# 其实不考虑各个发行版的差异化, 从更底层出发的话, 修改时间时区比想象中要简单:
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
