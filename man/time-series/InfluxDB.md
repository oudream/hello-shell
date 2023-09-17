
### web
- https://github.com/influxdata/influxdb
- https://portal.influxdata.com/downloads/
- http://127.0.0.1:8086/


### download
- arm32 armv7
```shell
https://github.com/influxdata/influxdb/releases?page=2
https://bitbucket.org/choekstra/influxdb2-linux-arm/src/master/
https://hub.docker.com/r/arm32v7/influxdb/tags
```


### start
```shell
nohup /userdata/influxdb2/influxd --http-bind-address=0.0.0.0:7809 --engine-path=/userdata/influxdb2/data --bolt-path=/userdata/influxdb2/influxd.bolt 1>/userdata/influxdb2/influxdb.log 2>&1 &
```

### docker
```shell
docker run -d --name influxdb-tk227 -p 8086:8086 influxdb:2.3.0
```
```shell
mkdir -p /userdata/influxdb2/data

docker run -d -p 7809:8086 \
      --name influxdb2 \
      -v /userdata/influxdb2/data/data:/var/lib/influxdb2 \
      -v /userdata/influxdb2/data/config:/etc/influxdb2 \
      -v /userdata/influxdb2/data/backup:/backup \
      influxdb:2.5.1
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


### docker
```shell
mkdir -p /data/influxdb2b

docker run -d --restart=always -p 7809:8086 \
      --name influxdb2 \
      -v /home/influxdb2/data:/var/lib/influxdb2 \
      -v /home/influxdb2/config:/etc/influxdb2 \
      influxdb:2.5.1
```


### setup 2.6.0
- https://portal.influxdata.com/downloads/
```shell
#  amd64
wget https://dl.influxdata.com/influxdb/releases/influxdb2-2.6.0-linux-amd64.tar.gz
tar xvfz influxdb2-2.6.0-linux-amd64.tar.gz

# arm64
wget https://dl.influxdata.com/influxdb/releases/influxdb2-2.6.0-linux-arm64.tar.gz
tar xvfz influxdb2-2.6.0-linux-arm64.tar.gz
```


### setup 2.5.1
- https://portal.influxdata.com/downloads/
- https://docs.influxdata.com/influxdb/v2.5/install/?t=Linux#download-and-install-influxdb-vspan-classcurrent-version25span
```shell
# amd64
wget https://dl.influxdata.com/influxdb/releases/influxdb2-2.5.1-linux-amd64.tar.gz

# arm
wget https://dl.influxdata.com/influxdb/releases/influxdb2-2.5.1-linux-arm64.tar.gz

wget https://dl.influxdata.com/influxdb/releases/influxdb2-2.7.1-linux-arm64.tar.gz
wget https://dl.influxdata.com/influxdb/releases/influxdb2-client-2.7.3-linux-arm64.tar.gz
wget https://dl.influxdata.com/influxdb/releases/influxdb2-client-2.7.3-amd64.tar.gz

# amd64
tar xvzf path/to/influxdb2-2.5.1-linux-amd64.tar.gz

# arm
tar xvzf path/to/influxdb2-2.5.1-linux-arm64.tar.gz

# amd64
sudo cp influxdb2-2.5.1-linux-amd64/influxd /usr/local/bin/

# arm
sudo cp influxdb2-2.5.1-linux-arm64/influxd /usr/local/bin/

# windows
wget https://dl.influxdata.com/influxdb/releases/influxdb2-client-2.7.3-windows-amd64.zip -UseBasicParsing -OutFile influxdb2-client-2.7.3-windows-amd64.zip
Expand-Archive .\influxdb2-client-2.7.3-windows-amd64.zip -DestinationPath 'C:\Program Files\InfluxData\influxdb2-client\'

```


### start
- https://docs.influxdata.com/influxdb/v2.5/reference/cli/influxd/
- https://docs.influxdata.com/influxdb/v2.5/reference/config-options/
```shell
influxd --http-bind-address=0.0.0.0:8086
#influxd --http-bind-address=:8086

#Environment variable
#export INFLUXD_HTTP_BIND_ADDRESS=:8086

```


### query
- https://docs.influxdata.com/influxdb/v1.7/write_protocols/line_protocol_reference/
- https://docs.influxdata.com/flux/v0.x/data-types/basic/duration/
- https://docs.influxdata.com/influxdb/v1.7/query_language/data_exploration/#time-syntax
- https://docs.influxdata.com/flux/v0.x/stdlib/universe/range/
- https://docs.influxdata.com/flux/v0.x/stdlib/universe/count/
- https://docs.influxdata.com/influxdb/cloud/query-data/flux/query-fields/


### InfluxDB
```text
对于存储引擎，时序数据库的先行者 InfluxDB 曾经做过很多尝试，在各个存储引擎（LevelDB、RocksDB、BoltDB 等）之间反复横跳，
遇到过的问题也有很多，
比如 BoltDB 中 mmap+BTree 模型中随机 IO 导致的吞吐量低、RocksDB 这类纯 LSM Tree 
存储引擎没办法很优雅快速地按时间分区删除、多个 LevelDB + 划分时间分区的方法又会产生大量句柄……踩了这一系列的坑后，
最终 InfluxDB 换成了自研的存储引擎 TSM。可见对时序数据库来说，一个好的存储引擎有多么重要，又是多么难得，要想做到极致，还得自己研发。
```
