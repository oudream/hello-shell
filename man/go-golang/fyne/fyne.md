
### 解决 fyne 中文乱码问题
- https://wang.mx/posts/224


### 控制台去掉
```shell
# 直接go build项目的话生成的程序在window打开会有控制台，需要带参编译把控制台去掉。
# 使用以下命令即可
go build -ldflags -H=windowsgui main.go

```


