

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
- https://docs.influxdata.com/influxdb/v2.5/install/?t=Linux#download-and-install-influxdb-vspan-classcurrent-version25span
```shell
# amd64
wget https://dl.influxdata.com/influxdb/releases/influxdb2-2.5.1-linux-amd64.tar.gz

# arm
wget https://dl.influxdata.com/influxdb/releases/influxdb2-2.5.1-linux-arm64.tar.gz

# amd64
tar xvzf path/to/influxdb2-2.5.1-linux-amd64.tar.gz

# arm
tar xvzf path/to/influxdb2-2.5.1-linux-arm64.tar.gz

# amd64
sudo cp influxdb2-2.5.1-linux-amd64/influxd /usr/local/bin/

# arm
sudo cp influxdb2-2.5.1-linux-arm64/influxd /usr/local/bin/

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

