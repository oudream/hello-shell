
### 
- https://github.com/go-admin-team/go-admin
- https://github.com/go-admin-team/go-admin/blob/master/README.Zh-cn.md
```shell
git clone https://github.com/go-admin-team/go-admin.git

cd go-admin
go mod vendor

# create database goadmin;

CGO_ENABLED=0 go build -o go-admin main.go

# 数据库初始化
./go-admin migrate -c /opt/wedo/go-admin/config/settings.yml
# http server start
./go-admin server -c /opt/wedo/go-admin/config/settings.yml
  
  
nohup ./go-admin server -c /opt/wedo/go-admin/config/settings.yml 1> /opt/log/go-admin.log 2>&1 &  
nohup npm run dev 1> /opt/log/go-admin-ui.log 2>&1 &  
```


