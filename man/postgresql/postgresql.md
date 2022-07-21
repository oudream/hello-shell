
### PostgreSQL timescaledb
- https://hub.docker.com/r/timescale/timescaledb/tags
- https://hub.docker.com/_/postgres?tab=tags


### PostgreSQL12-主从复制
- https://blog.csdn.net/Linuxprobe18/article/details/102454221
- https://www.cnblogs.com/Hollson/p/13180510.html
- https://blog.csdn.net/Kangyucheng/article/details/108543370


###
```text
psql是PostgreSQL 的交互式客户端工具。
使用方法:
  psql [选项]... [数据库名称 [用户名称]]
通用选项:
  -c,--command=命令        执行单一命令(SQL或内部指令)然后结束
  -d, --dbname=数据库名称   指定要连接的数据库 (缺省："postgres")
  -f, --file=文件名      从文件中执行命令然后退出
  -l, --list             列出所有可用的数据库,然后退出
  -v, --set=, --variable=名称=值
                           为psql变量(名称)设定值
  -V, --version            输出版本信息, 然后退出
  -X, --no-psqlrc         不读取启动文档(~/.psqlrc)
  -1 ("one"), --single-transaction
                          作为一个单一事务来执行命令文件
  -?, --help               显示此帮助, 然后退出

输入和输出选项：
  -a, --echo-all          显示所有来自于脚本的输入
  -e, --echo-queries      显示发送给服务器的命令
  -E, --echo-hidden        显示内部命令产生的查询
  -L, --log-file=文件名  将会话日志写入文件
  -n, --no-readline       禁用增强命令行编辑功能(readline)
  -o, --output=FILENAME 将查询结果写入文件(或 |管道)
  -q, --quiet             以沉默模式运行(不显示消息，只有查询结果)
  -s, --single-step       单步模式 (确认每个查询)
  -S, --single-line        单行模式 (一行就是一条 SQL 命令)

输出格式选项 :
  -A, --no-align           使用非对齐表格输出模式
  -F, --field-separator=字符串
                      设字段分隔符(缺省："|")
  -H, --html             HTML 表格输出模式
  -P, --pset=变量[=参数]    设置将变量打印到参数的选项(查阅 \pset 命令)
  -R, --record-separator=字符串
                        设定记录分隔符(缺省：换行符号)
  -t, --tuples-only      只打印记录i
  -T, --table-attr=文本   设定 HTML 表格标记属性（例如,宽度,边界)
  -x, --expanded           打开扩展表格输出
  -z, --field-separator-zero
                           设置字段分隔符为字节0
  -0, --record-separator-zero
                           设置记录分隔符为字节0

联接选项:
  -h, --host=主机名        数据库服务器主机或socket目录(缺省："本地接口")
  -p, --port=端口        数据库服务器的端口(缺省："5432")
  -U, --username=用户名    指定数据库用户名(缺省："postgres")
  -w, --no-password       永远不提示输入口令
  -W, --password           强制口令提示 (自动)

更多信息，请在psql中输入"\?"(用于内部指令)或者 "\help"(用于SQL命令)，
或者参考PostgreSQL文档中的psql章节.

臭虫报告至 <pgsql-bugs@postgresql.org>.
```
