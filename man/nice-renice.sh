
# 修改线程优先级
# 等级的范围从-20-19，其中-20最高，19最低，只有系统管理者可以设置负数的等级。
# 查看线程优先级
ps -el
# nice [-n NI值] 命令
nice -n -5 service httpd start
# renice [优先级] PID
renice -10 2125
