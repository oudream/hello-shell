
### install go
> https://golang.org/dl/
```shell script
rm -rf /usr/local/go
wget https://go.dev/dl/go1.19.2.linux-amd64.tar.gz
sudo tar -xvf go1.19.2.linux-amd64.tar.gz
sudo mv go /usr/local

cat >> /etc/profile << EOF
export GOROOT=/usr/local/go
export GOPATH=/root/gopath
export PATH=\$GOPATH/bin:\$GOROOT/bin:\$PATH
EOF

# verification
go version
```

### install goland
```shell
wget https://download.jetbrains.com/go/goland-2022.2.6.tar.gz
tar zxvf goland-2022.2.6.tar.gz

```

### go mod
```shell
go mod vendor
http_proxy=http://127.0.0.1:7890/ https_proxy=http://127.0.0.1:7890/ go mod vendor
```

### go编译到 alpine
- 运行 golang:alpine
```shell
docker run -d --name=golang -v /opt/dev:/opt/dev golang:alpine3.16 /bin/sh -c "while true; do echo hello world; sleep 1; done"
docker exec -it --name=golang sh
```
- 进入 golang:alpine后
```shell
# 安装 cgo 的 gcc g++
apk add build-base
go env -w GO111MODULE=on 
go env -w GOPROXY=https://goproxy.cn,direct
go env -w CGO_ENABLED=0
```
- 把编译后的程序放 alpine 中运行
```shell
docker run -d --name=alpine3a alpine:3.16.3 /bin/sh -c "while true; do echo hello world; sleep 1; done"
```

### 如何优雅地关闭 channel?
- https://learnku.com/go/t/23459/how-to-close-the-channel-gracefully

### 通道关闭原则
> 一般原则上使用通道是不允许接收方关闭通道和 不能关闭一个有多个并发发送者的通道。 换而言之， 你只能在发送方的 goroutine 中关闭只有该发送方的通道。

### Go 语言分布式任务处理器 Machinery – 架构
- https://marksuper.xyz/2022/04/20/machinery1/
- https://github.com/RichardKnop/machinery
