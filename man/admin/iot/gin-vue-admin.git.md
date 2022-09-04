### 注意自己路径
### 注意自己路径
### 注意自己路径

###
- https://doc.go-admin.dev/intro/tutorial01#path

### 后端
```shell
git clone https://github.com/flipped-aurora/gin-vue-admin.git
git checkout i3web-dev

cd go-admin
go mod vendor

# create database goadmin;
CGO_ENABLED=0 go build -o go-admin main.go

## 必须要修改数据库配置
## 必须要修改数据库配置
## 必须要修改数据库配置
vi ./config/settings.yml

## 数据库初始化
# linux
./go-admin migrate -c config/settings.yml
# windows
go-admin.exe migrate -c config/settings.yml

## start http server for golang
# linux
./go-admin server -c config/settings.yml
# windows
go-admin.exe server -c config/settings.yml
```

### 前端
```shell
git clone https://gitee.com/oudream/go-admin-ui.git
git checkout i3web-dev

## 安装 node.js（需要node.js v14+）、 yarn
npm install -g yarn

cd go-admin-ui

## 如果采用国内镜像
## 如果采用国内镜像
## 如果采用国内镜像
# linux
yarn --registry=https://registry.npmmirror.com --disturl=https://npmmirror.com/mirrors/node --cache=/opt/tmp/_cnpm install
# windows
yarn --registry=https://registry.npmmirror.com --disturl=https://npmmirror.com/mirrors/node --cache=c:/tmp/_cnpm install

## start http server for vue
npm run dev
  
```

### 发布
```shell
nohup ./go-admin server -c /opt/wedo/go-admin/config/settings.yml 1> /opt/log/go-admin.log 2>&1 &  
nohup npm run dev 1> /opt/log/go-admin-ui.log 2>&1 &  
```