
### twant redis
```shell
docker run -it --name redis1 -v D:/twant/redis/data/dump.rdb:/data/dump.rdb -p 6379:6379 redis:3.2.12
```

### Redis问题
> MISCONF Redis is configured to save RDB snapshots, but is currently not able to persist on disk. 
> Commands that may modify the data set are disabled. Please check Redis logs for details about the error.
> Redis被配置为保存数据库快照，但它目前不能持久化到硬盘。用来修改集合数据的命令不能用。请查看Redis日志的详细错误信息。

- 原因
> 强制关闭Redis快照导致不能持久化。

- 解决方案
> 将stop-writes-on-bgsave-error设置为no
```shell
127.0.0.1:6379> config set stop-writes-on-bgsave-error no
```
216235_113_90a55cfe-ac72-4552-a0e5-213bbde0038e.jp
216234_3267_53abf841-bc82-49b8-a6a9-8ab2b9792cfd.j