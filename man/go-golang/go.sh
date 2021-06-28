#!/usr/bin/env bash

go env

go build -v -work -o hello.exe


### build
-a	  # 强行对所有涉及到的代码包（包含标准库中的代码包）进行重新构建，即使它们已经是最新的了。
-n	  # 打印编译期间所用到的其它命令，但是并不真正执行它们。
-p n	# 指定编译过程中执行各任务的并行数量（确切地说应该是并发数量）。在默认情况下，该数量等于CPU的逻辑核数。但是在darwin/arm平台（即iPhone和iPad所用的平台）下，该数量默认是1。
-race	# 开启竞态条件的检测。不过此标记目前仅在linux/amd64、freebsd/amd64、darwin/amd64和windows/amd64平台下受到支持。
-v	  # 打印出那些被编译的代码包的名字。
-work	# 打印出编译时生成的临时工作目录的路径，并在编译结束时保留它。在默认情况下，编译结束时会删除该目录。
-x	  # 打印编译期间所用到的其它命令。注意它与-n标记的区别。


### install
wget https://golang.org/dl/go1.15.8.linux-amd64.tar.gz
sudo tar -xvf go1.15.8.linux-amd64.tar.gz
sudo mv go /usr/local

cat >> ~/.bash_profile << EOF
export GOROOT=/usr/local/go
export GOPATH=/home/gopath
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
EOF
/usr/local/go/bin
export GOPATH=/fff/gopath
# GOPATH="/home/ferghs/gowork:/home/ferghs/gowork/src/project1"
# Windows使用分号分割(;)


### go可以设置多个GOPATH
# Linux下用冒号(:)分割，例如：
GOPATH="/home/ferghs/gowork:/home/ferghs/gowork/src/project1"
# Windows使用分号分割(;)
# 1 如果使用go get 默认安装到第一个GOPATH路径
# 2 编译(go build)时，有时会报同一种类型或方法不匹配，原因是GOPATH路径中多个路径顺序不对，调换一下就OK了


### go module是Go1.11版本之后官方推出的版本管理工具，并且从Go1.13版本开始，go module将是Go语言默认的依赖管理工具。
# 环境变量GO111MODULE，可以开启或关闭模块支持：off、on、auto，默认值是auto。
# GO111MODULE=off禁用模块支持，编译时会从GOPATH和vendor文件夹中查找包。
# GO111MODULE=on启用模块支持，编译时会忽略GOPATH和vendor文件夹，只根据 go.mod下载依赖，将依赖下载至%GOPATH%/pkg/mod/ 目录下。
# GO111MODULE=auto，当项目在$GOPATH/src外且项目根目录有go.mod文件时，开启模块支持。
# 简单来说，设置GO111MODULE=on之后就可以使用go module了，以后就没有必要在GOPATH中创建项目了，并且还能够很好的管理项目依赖的第三方包信息。
## 使用 go module 管理依赖后会在项目根目录下生成两个文件go.mod和go.sum。

## GOPROXY
export GOPROXY=https://goproxy.cn
# Go1.13之后GOPROXY默认值为https://proxy.golang.org，在国内是无法访问的，所以十分建议大家设置GOPROXY，这里我推荐使用goproxy.cn。
go env -w GOPROXY=https://goproxy.cn,direct

## go mod命令
go mod download    # 下载依赖的module到本地cache（默认为$GOPATH/pkg/mod目录）
go mod edit        # 编辑go.mod文件
go mod graph       # 打印模块依赖图
go mod init        # 初始化当前文件夹, 创建go.mod文件
go mod tidy        # 增加缺少的module，删除无用的module
go mod vendor      # 将依赖复制到vendor下
go mod verify      # 校验依赖
go mod why         # 解释为什么需要依赖


### ubuntu install
wget https://golang.org/dl/go1.16.3.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.16.3.linux-amd64.tar.gz
vim /etc/profile
export GOROOT=/usr/local/go
export GOPATH=/home/gopath
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
#
export GOPROXY=https://goproxy.io
export GO111MODULE=off

### 交叉编译
sudo apt-get install gcc-aarch64-linux-gnu
export GO111MODULE=off
CGO_ENABLED=1 GOOS=linux GOARCH=arm64 CC=aarch64-linux-gnu-gcc go build .


### golang代理超时报错"https://proxy.golang.org/github.com/********** timeout make: *** [build_yaml] Error 1解决
go env -w GOPROXY=https://goproxy.cn
# go env -w GOPROXY=https://goproxy.cn,direct
# go env -w GO111MODULE=on