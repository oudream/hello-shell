
### build
```shell
git clone https://github.com/redis/redis.git
# 6.2.7 oranagra released this 27 Apr 2022
git checkout e6f6709

### build amd64
make
make 32bit
#
mkdir -p /opt/deploy/amd64/redis/
cp src/redis-server /opt/deploy/amd64/redis/
cp src/redis-cli /opt/deploy/amd64/redis/
cp src/redis-check-aof /opt/deploy/amd64/redis/
cp src/redis-check-rdb /opt/deploy/amd64/redis/
cp src/redis-sentinel /opt/deploy/amd64/redis/
cp src/redis-benchmark /opt/deploy/amd64/redis/

### build amd64 alpine
make
make 32bit
#
mkdir -p /opt/deploy/amd64-alpine/redis/
cp src/redis-server /opt/deploy/amd64-alpine/redis/
cp src/redis-cli /opt/deploy/amd64-alpine/redis/
cp src/redis-check-aof /opt/deploy/amd64-alpine/redis/
cp src/redis-check-rdb /opt/deploy/amd64-alpine/redis/
cp src/redis-sentinel /opt/deploy/amd64-alpine/redis/
cp src/redis-benchmark /opt/deploy/amd64-alpine/redis/

# run
cd src
./redis-server
./redis-server /path/to/redis.conf

### build arm64
export PATH=$PATH:/opt/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu/bin/
export CC=aarch64-linux-gnu-gcc
export CXX=aarch64-linux-gnu-g++
export LD=aarch64-linux-gnu-ld
export RAINLIB=aarch64-linux-gnu-rainlib
export AR=aarch64-linux-gnu-ar
export LINK=aarch64-linux-gnu-g++
make MALLOC=libc
#
mkdir -p /opt/deploy/arm64/redis/
cp src/redis-server /opt/deploy/arm64/redis/
cp src/redis-cli /opt/deploy/arm64/redis/
cp src/redis-check-aof /opt/deploy/arm64/redis/
cp src/redis-check-rdb /opt/deploy/arm64/redis/
cp src/redis-sentinel /opt/deploy/arm64/redis/
cp src/redis-benchmark /opt/deploy/arm64/redis/

### build arm32
export PATH=$PATH:/opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/
export CC=arm-linux-gnueabihf-gcc
export CXX=arm-linux-gnueabihf-g++
export LD=arm-linux-gnueabihf-ld
export RAINLIB=arm-linux-gnueabihf-rainlib
export AR=arm-linux-gnueabihf-ar
export LINK=arm-linux-gnueabihf-g++
make MALLOC=libc
#
mkdir -p /opt/deploy/arm32/redis/
cp src/redis-server /opt/deploy/arm32/redis/
cp src/redis-cli /opt/deploy/arm32/redis/
cp src/redis-check-aof /opt/deploy/arm32/redis/
cp src/redis-check-rdb /opt/deploy/arm32/redis/
cp src/redis-sentinel /opt/deploy/arm32/redis/
cp src/redis-benchmark /opt/deploy/arm32/redis/

```

### Redis核心技术实战
- https://github.com/oudream/YAY-guide/blob/master/%E8%AF%BE%E7%A8%8B/Redis%E6%A0%B8%E5%BF%83%E6%8A%80%E6%9C%AF%E4%B8%8E%E5%AE%9E%E6%88%98/01_%E5%9F%BA%E6%9C%AC%E6%9E%B6%E6%9E%84%EF%BC%9A%E4%B8%80%E4%B8%AA%E9%94%AE%E5%80%BC%E6%95%B0%E6%8D%AE%E5%BA%93%E5%8C%85%E5%90%AB%E4%BB%80%E4%B9%88%EF%BC%9F.md

### redis client
```shell
wget https://github.com/qishibo/AnotherRedisDesktopManager/releases/download/v1.4.8/Another-Redis-Desktop-Manager.1.4.8.AppImage -o /opt/Another-Redis-Desktop-Manager.1.4.8.AppImage
chmod +x /opt/Another-Redis-Desktop-Manager.1.4.8.AppImage
cat > /root/桌面/Another-Redis-Desktop-Manager.desktop <<EOF
[Desktop Entry]
Name=Another-Redis-Desktop-Manager.1.4.8
Exec=/opt/Another-Redis-Desktop-Manager.1.4.8.AppImage --no-sandbox
Type=Application
StartupNotify=true
EOF
gio set /root/桌面/Another-Redis-Desktop-Manager.desktop "metadata::trusted" yes
# 在18.04，它对我不起作用。目标.desktop文件保留Allow executing file as program在属性菜单中未选中的复选框
```

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


### Redis 在Windows上编译
- https://blog.csdn.net/u010142597/article/details/108418443
