
### 在amd64架构上 build arm64
```shell
### 在amd64架构上 build arm64
docker build . -t arm64v8/ou-golang:1.19.10-alpine3.18
#
docker run -it -d -v /opt/dev:/opt/dev arm64v8/ou-golang:1.19.10-alpine3.18

```

### 在本土CPU架构上 build self
```shell
### 在本土CPU架构上 build self
docker build . -t ou-golang:1.19.10-alpine3.18
#
docker run -it -d -v /opt/dev:/opt/dev ou-golang:1.19.10-alpine3.18

```

### 安装 QEMU 
```shell
### 安装 QEMU all 等环境
docker run --privileged --rm tonistiigi/binfmt --install all
### 安装 QEMU arm64 等环境
docker run --privileged --rm tonistiigi/binfmt --install arm64,riscv64,arm
docker buildx ls

```
