

### 常用的接收器
- https://github.com/serilog/serilog/wiki/Provided-Sinks
```shell
Console 输出到控制台
Debug 输出到VS的Debug窗口
File 输出到文件
Rolling File
MongoDB 输出到MongoDB
LiteDB 输出到文件数据库LiteDB
SQLite 输出到文件数据库SQLite
SignalR 输出为SignalR服务
HTTP 输出到REST服务
Unity3D 输出到Unity
```

```shell
Install-Package Serilog
Install-Package Serilog.Sinks.Console
Install-Package Serilog.Sinks.File
```