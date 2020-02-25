@[TOC](目录)

# 数据的实时同步
1. 实现实时同步
    要利用监控服务（inotify），监控同步数据服务器目录中信息的变化
    发现目录中数据产生变化，就利用rsync服务推送到备份服务器上

2. inotify+rsync 方式实现数据同步
`sersync` ：金山公司周洋在 inotify 软件基础上进行开发的，功能更加强大
`inotify` ：
>异步的文件系统事件监控机制，利用事件驱动机制，而无须通过诸如cron等的轮询机制来获取事件，linux内核从2.6.13起支持 inotify，通过inotify可以监控文件系统中添加、删除，修改、移动等各种事件

3. 实现inotify软件：
    inotify-tools，sersync，lrsyncd

## inotify和rsync
inotify： 对同步数据目录信息的监控
rsync： 完成对数据的同步


+ 查看服务器内核是否支持inotify
    Linux下支持inotify的内核最小为2.6.13
```sh
ll /proc/sys/fs/inotify 
#列出下面的文件，说明服务器内核支持inotify
-rw-r--r-- 1 root root 0 Dec 7 10:10 max_queued_events
-rw-r--r-- 1 root root 0 Dec 7 10:10 max_user_instances
-rw-r--r-- 1 root root 0 Dec 6 05:54 max_user_watches
```

+ inotify内核参数
    参数说明：参看man 7 inotify
```sh
max_queued_events：inotify  # 事件队列最大长度，如值太小会出现 Event Queue Overflow 错误，默认值：16384
max_user_watches  #可以监视的文件数量（单进程），默认值：8192
max_user_instances  #每个用户创建inotify实例最大值，默认值：128
```


+ **安装：基于epel源**
```sh
yum install inotify-tools
```

+ inotify-tools包主要文件：
    + `inotifywait`： 在被监控的文件或目录上等待特定文件系统事件（open close delete等）发生，常用于实时同步的目录监控
    + `inotifywatch`：收集被监控的文件系统使用的统计数据，指文件系统事件发生的次数统计

## inotify和rsync实现实时同步

**inotifywait命令常见**
选项 | 说明
- | -
-m, --monitor |始终保持事件监听
-d, --daemon |以守护进程方式执行，和-m相似，配合-o使用
-r, --recursive |递归监控目录数据信息变化
-q, --quiet |输出少量事件信息
--exclude <pattern>|指定排除文件或目录，使用扩展的正则表达式匹配的模式实现
--excludei <pattern> |和exclude相似，不区分大小写
-o, --outfile <file>|打印事件到文件中，相当于标准正确输出
-s, --syslogOutput |发送错误到syslog相当于标准错误输出
--timefmt <fmt> |指定时间输出格式
--format <fmt> |指定的输出格式；即实际监控输出内容
-e |指定监听指定的事件，如果省略，表示所有事件都进行监听


**`--timefmt <fmt>`时间格式**
格式 | 说明
- | - 
%Y |年份信息，包含世纪信息
%y |年份信息，不包括世纪信息
%m |显示月份，范围 01-12
%d |每月的第几天，范围是 01-31
%H |小时信息，使用 24小时制，范围 00-23
%M |分钟，范围 00-59

示例：
```sh
--timefmt "%Y-%m-%d %H:%M"
```


**`--format <fmt> `格式定义** 
格式 | 说明
 - | -
%T |输出时间格式中定义的时间格式信息，通过 --timefmt option 语法格式指定时间信息
%w |事件出现时，监控文件或目录的名称信息
%f |事件出现时，将显示监控目录下触发事件的文件或目录信息，否则为空
%e |显示发生的事件信息，不同的事件默认用逗号分隔
%Xe | 显示发生的事件信息，不同的事件指定用X进行分隔

示例：
```sh
--format "%T %w%f event: %;e"
--format '%T %w %f'
```

**`-e`选项指定的事件类型**
类型 | 说明
 - | -
create | 文件或目录创建
delete| 文件或目录被删除
modify |文件或目录内容被写入
attrib |文件或目录属性改变
close_write |文件或目录关闭，在写入模式打开之后关闭的
close_nowrite |文件或目录关闭，在只读模式打开之后关闭的
close |文件或目录关闭，不管读或是写模式
open |文件或目录被打开
moved_to |文件或目录被移动到监控的目录中
moved_from |文件或目录从监控的目录中被移动
move |文件或目录不管移动到或是移出监控目录都触发事件
access |文件或目录内容被读取
delete_self |文件或目录被删除，目录本身被删除
unmount |取消挂载

示例： 
```sh
-e create,delete,moved_to,close_write, attrib
```

## 示例：
监控一次性事件
```sh
inotifywait /data
```

持续监控
```sh
inotifywait -mrq /data
```

持续后台监控，并记录日志
```sh
inotifywait -o /root/inotify.log -drq /data --timefmt "%Y-%m-%d %H:%M" --format "%T %w%f event: %e"
```

持续后台监控特定事件
```sh
inotifywait -mrq /data --timefmt “%F %H:%M” --format “%T %w%f event: %;e” -e create,delete,moved_to,close_write,attrib
```

## 配置 rsync 服务器端的配置文件

1. 先安装：`yum install rsync`

2. 改配置
```sh
[101]$ vi /etc/rsyncd.conf

    uid = root
    gid = root
    use chroot = no
    max connections = 0
    ignore errors
    exclude = lost+found/
    log file = /var/log/rsyncd.log
    pid file = /var/run/rsyncd.pid
    lock file = /var/run/rsyncd.lock
    reverse lookup = no
    hosts allow = 192.168.8.0/24
[backup]
    path = /backup/
    comment = backup
    read only = no
    auth users = rsyncuser
    secrets file = /etc/rsync.pass
```

3. 服务器端生成验证文件
```sh
echo "rsyncuser:123" > /etc/rsync.pass
chmod 600 /etc/rsync.pass
```

4. 服务器端准备目录
```sh
mkdir /backup
```

5. 服务器端启动rsync服务
```sh
rsync --daemon   #可加入/etc/rc.d/rc.local实现开机启动
systemctl start rsyncd 
```

**客户端配置**
1. 密码文件
```sh
echo "123" > /etc/rsync.pass
chmod 600 /etc/rsync.pass
```

2. 客户端测试同步数据
```sh
yum -y install rsync inotify-tools
rsync -avz --password-file=/etc/rsync.pass /data/ rsyncuser@192.168.99.101::backup
```

3. 客户端创建inotify_rsync.sh脚本
```sh
#!/bin/bash
SRC='/data/'
DEST='rsyncuser@192.168.99.101::backup'
inotifywait -mrq --timefmt '%Y-%m-%d %H:%M' --format '%T %w %f' -e create,delete,moved_to,close_write,attrib ${SRC} |while read DATE TIME DIR FILE;do
FILEPATH=${DIR}${FILE}
rsync -az --delete --password-file=/etc/rsync.pass $SRC $DEST && echo "At ${TIME} on ${DATE}, file $FILEPATH was backuped up via rsync" >> /var/log/changelist.log
done
```
