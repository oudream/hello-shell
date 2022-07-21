
### docker
```shell
docker run -d --name influxdb-tk227 -p 8086:8086 influxdb:2.3.0
```
```shell
docker run -p 8086:8086 \
      -v influxdb:/var/lib/influxdb \
      -v influxdb2:/var/lib/influxdb2 \
      -e DOCKER_INFLUXDB_INIT_MODE=upgrade \
      -e DOCKER_INFLUXDB_INIT_USERNAME=my-user \
      -e DOCKER_INFLUXDB_INIT_PASSWORD=my-password \
      -e DOCKER_INFLUXDB_INIT_ORG=my-org \
      -e DOCKER_INFLUXDB_INIT_BUCKET=my-bucket \
      influxdb:2.0
```



### InfluxDB
```text
对于存储引擎，时序数据库的先行者 InfluxDB 曾经做过很多尝试，在各个存储引擎（LevelDB、RocksDB、BoltDB 等）之间反复横跳，
遇到过的问题也有很多，
比如 BoltDB 中 mmap+BTree 模型中随机 IO 导致的吞吐量低、RocksDB 这类纯 LSM Tree 
存储引擎没办法很优雅快速地按时间分区删除、多个 LevelDB + 划分时间分区的方法又会产生大量句柄……踩了这一系列的坑后，
最终 InfluxDB 换成了自研的存储引擎 TSM。可见对时序数据库来说，一个好的存储引擎有多么重要，又是多么难得，要想做到极致，还得自己研发。
```
