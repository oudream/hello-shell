#!/usr/bin/env bash

sudo journalctl -f -u etcd

### Journalctl 查看和操作 Systemd 日志
journalctl -b   # 当前引导的日志, 显示自最近重新引导以来收集的所有日记帐分录。
journalctl --since "2015-01-10" --until "2015-01-11 03:00"
journalctl --since yesterday
journalctl --since 09:00 --until "1 hour ago"
journalctl -u nginx.service --since today # 按单位, 按消息兴趣过滤
journalctl _PID=8088 # 按进程，用户或组ID
journalctl /usr/bin/bash # 按组件路径
journalctl -k # 显示内核消息
journalctl -n 20 # 工作原理完全一样 tail -n
journalctl -f # 要积极跟踪日志，因为他们正在写的。你可能期望tail -f
journalctl --disk-usage # 该杂志目前使用占用的磁盘空间量
sudo journalctl --vacuum-size=1G # 将删除旧条目，直到磁盘上占用的总日志空间为所请求的大小


## 查看某次启动后的日志
# 默认情况下 systemd-journald 服务只保存本次启动后的日志(重新启动后丢掉以前的日志)。
# 此时 -b 选项是没啥用的。当我们把 systemd-journald 服务收集到的日志保存到文件中之后，就可以通过下面的命令查看系统的重启记录：
journalctl --list-boots
# 此时我们就可以通过 -b 选项来选择查看某次运行过程中的日志：
sudo journalctl -b -1
# 或
sudo journalctl -b 9eaabbc25fe343999ef1024e6a16fb58
# 下面的命令都会输出最后一次启动后的日志信息：
sudo journalctl -b
sudo journalctl -b  0

## 查看指定时间段的日志
# 利用 --since 与 --until 选项设定时间段，二者分别负责指定给定时间之前与之后的日志记录。时间值可以使用多种格式，比如下面的格式：
# YYYY-MM-DD HH:MM:SS
# 如果我们要查询 2018 年 3 月 26 日下午 8:20 之后的日志：
journalctl --since "2018-03-26 20:20:00"
# 如果以上格式中的某些组成部分未进行填写，系统会直接进行默认填充。例如，如果日期部分未填写，则会直接显示当前日期。
#     如果时间部分未填写，则缺省使用 "00:00:00"(午夜)。秒字段亦可留空，默认值为 "00"，比如下面的命令：
journalctl --since "2018-03-26" --until "2018-03-26 03:00"
# 另外，journalctl 还能够理解部分相对值及命名简写。例如，大家可以使用 "yesterday"、"today"、"tomorrow" 或者 "now" 等。
# 比如获取昨天的日志数据可以使用下面的命令：
journalctl --since yesterday
# 要获得早上 9:00 到一小时前这段时间内的日志，可以使用下面的命令：
journalctl --since 09:00 --until "1 hour ago"
# 同时应用 match 和时间过滤条件
# 实际的使用中更常见的用例是同时应用 match 和时间条件，比如要过滤出某个时间段中 cron 服务的日志记录：
sudo journalctl _SYSTEMD_UNIT=cron.service --since "2018-03-27" --until "2018-03-27 01:00"

## 按 unit 过滤日志
# systemd 把几乎所有的任务都抽象成了 unit，因此我们可以方便的使用 -u 选项通过 unit 的名称来过滤器日志记录。查看某个 unit 的日志：
sudo journalctl -u nginx.service
sudo journalctl -u nginx.service --since today
# 还可以使用多个 -u 选项同时获得多个 unit 的日志：
journalctl -u nginx.service -u php-fpm.service --since today

## 通过日志级别进行过滤
# 除了通过 PRIORITY= 的方式，还可以通过 -p 选项来过滤日志的级别。 可以指定的优先级如下：
# 0: emerg
# 1: alert
# 2: crit
# 3: err
# 4: warning
# 5: notice
# 6: info
# 7: debug
sudo journalctl -p err
# 注意，这里指定的是优先级的名称。

## 实时更新日志
#与 tail -f 类似，journalctl 支持 -f 选项来显示实时的日志：
sudo journalctl -f
# 如果要查看某个 unit 的实时日志，再加上 -u 选项就可以了：
sudo journalctl -f -u prometheus.service

## 实时更新日志
# 与 tail -f 类似，journalctl 支持 -f 选项来显示实时的日志：
sudo journalctl -f
# 如果要查看某个 unit 的实时日志，再加上 -u 选项就可以了：
sudo journalctl -f -u prometheus.service

## 把结果重定向到标准输出
# 默认情况下，journalctl 会在 pager 内显示输出结果。如果大家希望利用文本操作工具对数据进行处理，则需要使用标准输出。
#     在这种情况下，我们需要使用 --no-pager 选项。
sudo journalctl --no-pager
# 这样就可以把结果重定向到我们需要的地方(一般是磁盘文件或者是文本工具)。
# 格式化输出的结果
# 如果大家需要对日志记录进行处理，可能需要使用更易使用的格式以简化数据解析工作。幸运的是，journalctl 能够以多种格式进行显示，
#     只须添加 -o 选项即可。-o 选项支持的类型如下：
#    short
#       这是默认的格式，即经典的 syslog 输出格式。
#    short-iso
#       与 short 类似，强调 ISO 8601 时间戳。
#    short-precise
#       与 short 类似，提供微秒级精度。
#    short-monotonic
#       与 short 类似，强调普通时间戳。
#    verbose
#       显示全部字段，包括通常被内部隐藏的字段。
#    export
#       适合传输或备份的二进制格式。
#    json
#       标准 json 格式，每行一条记录。
#    json-pretty
#       适合阅读的 json 格式。
#    json-sse
#       经过包装可以兼容 server-sent 事件的 json 格式。
#    cat
#       只显示信息字段本身。
# 比如我们要以 json 格式输出 cron.service 的最后一条日志：
sudo journalctl -u cron.service -n 1 --no-pager -o json

## 按可执行文件的路径过滤
# 如果在参数中指定某个可执行文件(二进制文件或脚本文件)，则 journalctl 会显示与该可执行文件相关的全部条目。
#     比如可以显示 /usr/lib/systemd/systemd 程序产生的日志：
sudo journalctl /usr/lib/systemd/systemd
# 也可以显示 /usr/bin/bash 程序产生的日志：
sudo journalctl /usr/bin/bash

