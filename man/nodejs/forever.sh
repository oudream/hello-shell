#!/usr/bin/env bash


# 启动守护进程
forever start app.js
# 列表显示forever进程
forever list
# 列出所有forever进程的日志
forever logs
tail -f /root/.forever/9RT6.log
# 停止守护进程
forever stop app.js

npm install -g forever


# 子命令actions：

start:启动守护进程
stop:停止守护进程
stopall:停止所有的forever进程
restart:重启守护进程
restartall:重启所有的foever进程
list:列表显示forever进程
config:列出所有的用户配置项
set <key> <val>: 设置用户配置项
clear <key>: 清楚用户配置项
logs: 列出所有forever进程的日志
logs <script|index>: 显示最新的日志
columns add <col>: 自定义指标到forever list
columns rm <col>: 删除forever list的指标
columns set<cols>: 设置所有的指标到forever list
cleanlogs: 删除所有的forever历史日志
配置参数options：

-m MAX: 运行指定脚本的次数
-l LOGFILE: 输出日志到LOGFILE
-o OUTFILE: 输出控制台信息到OUTFILE
-e ERRFILE: 输出控制台错误在ERRFILE
-p PATH: 根目录
-c COMMAND: 执行命令，默认是node
-a, –append: 合并日志
-f, –fifo: 流式日志输出
-n, –number: 日志打印行数
–pidFile: pid文件
–sourceDir: 源代码目录
–minUptime: 最小spinn更新时间(ms)
–spinSleepTime: 两次spin间隔时间
–colors: 控制台输出着色
–plain: –no-colors的别名，控制台输出无色
-d, –debug: debug模式
-v, –verbose: 打印详细输出
-s, –silent: 不打印日志和错误信息
-w, –watch: 监控文件改变
–watchDirectory: 监控顶级目录
–watchIgnore: 通过模式匹配忽略监控
-h, –help: 命令行帮助信息
