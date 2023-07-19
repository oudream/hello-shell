
# 下载一个Swag命令行
# 在 $GOPATH 目录中，GOPATH 目录 可以使用 go env 查看
go get -u -v github.com/swaggo/swag/cmd/swag

# 安装
go install -v github.com/swaggo/swag/cmd/swag@latest
swag -v

#
swag init
#2023/07/06 19:34:08 create docs.go at docs/docs.go
#2023/07/06 19:34:08 create swagger.json at docs/swagger.json
#2023/07/06 19:34:08 create swagger.yaml at docs/swagger.yaml

