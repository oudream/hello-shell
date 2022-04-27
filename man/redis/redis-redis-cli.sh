
# https://www.jianshu.com/p/dadcee1c8c0f

redis-cli -h 10.144.62.3 -p 30000
redis-cli -h 47.112.141.121 -p 19005 -a wedoredis


### redis持久化：一类是手动触发，另一类是自动触发。
# https://www.cnblogs.com/traditional/p/13296648.html
# 客户端中执行 save 命令，就会触发 Redis 的持久化，但同时也会使 Redis 处于阻塞状态，直到 RDB 持久化完成
# save m n 是指在 m 秒内，如果有 n 个键发生改变，则自动触发持久化。
redis-cli
  save
  exit
# bgsave 会 fork() 一个子进程来执行持久化
# Background saving started  # 提示开始后台保存
  bgsave
  exit
# AOF（Append Only File）中文是附加到文件，顾名思义 AOF 可以把 Redis 每个键值对操作都记录到文件（appendonly.aof）中。
# 查询 AOF 启动状态
  config get appendonly
# 命令行启动 AOF
  config set appendonly yes
# 配置文件启动 AOF
# 只需要在配置文件redis.conf中设置 appendonly yes
# 开启每秒写入一次的持久化策略：appendfsync everysec
# 获取 Redis 的根目录
  config get dir



### install
# 安装
wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
yum install redis

#
vim /etc/redis.conf
bind 0.0.0.0

# 配置Redis随系统启动
systemctl enable redis
# 複製備份到redis目錄
cp dump.rdb /var/lib/redis/
 # 启动Redis服务
systemctl start redis
