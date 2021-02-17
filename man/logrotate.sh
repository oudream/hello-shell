
### https://cloud.tencent.com/developer/article/1681716
# logrotate，默认的配置文件：
# /etc/logrotate.conf
# /etc/logrotate.d/
# logrotate.conf：为主配置文件
# logrotate.d：为配置相关子系统，用于隔离每个应用配置（Nginx、PHP、Tomcat…）


cat /etc/logrotate.conf
  weekly    # 默认每一周执行一次rotate轮转工作
  rotate 4  # 保留多少个日志文件(轮转几次).默认保留四个.就是指定日志文件删除之前轮转的次数，0 指没有备份
  create    # 自动创建新的日志文件，新的日志文件具有和原来的文件相同的权限；因为日志被改名,因此要创建一个新的来继续存储之前的日志
  dateext   # 这个参数很重要！就是切割后的日志文件以当前日期为格式结尾，如xxx.log-20131216这样,如果注释掉,切割出来是按数字递增,即前面说的 xxx.log-1这种格式
  compress  # 是否通过gzip压缩转储以后的日志文件，如xxx.log-20131216.gz ；如果不需要压缩，注释掉就行
  include /etc/logrotate.d # 导入/etc/logrotate.d/ 目录中的各个应用配置
  /var/log/wtmp { # 仅针对 /var/log/wtmp 所设定的参数
    monthly       # 每月一次切割,取代默认的一周
    minsize 1M    # 文件大小超过 1M 后才会切割
    create 0664 root utmp # 指定新建的日志文件权限以及所属用户和组
    rotate 1      # 只保留一个日志.
  } # 这个 wtmp 可记录用户登录系统及系统重启的时间
    # 因为有 minsize 的参数，因此不见得每个月一定会执行一次喔.要看文件大小。


### Logrotate中其他可配置参数，具体如下：
  compress # 通过gzip 压缩转储以后的日志
  nocompress # 不做gzip压缩处理
  copytruncate # 用于还在打开中的日志文件，把当前日志备份并截断；是先拷贝再清空的方式，拷贝和清空之间有一个时间差，可能会丢失部分日志数据。
  nocopytruncate # 备份日志文件不过不截断
  create mode owner group # 轮转时指定创建新文件的属性，如create 0777 nobody nobody
  nocreate # 不建立新的日志文件
  delaycompress # 和compress 一起使用时，转储的日志文件到下一次转储时才压缩
  nodelaycompress # 覆盖 delaycompress 选项，转储同时压缩。
  missingok # 如果日志丢失，不报错继续滚动下一个日志
  errors address # 专储时的错误信息发送到指定的Email 地址
  ifempty # 即使日志文件为空文件也做轮转，这个是logrotate的缺省选项。
  notifempty # 当日志文件为空时，不进行轮转
  mail address # 把转储的日志文件发送到指定的E-mail 地址
  nomail # 转储时不发送日志文件
  olddir directory # 转储后的日志文件放入指定的目录，必须和当前日志文件在同一个文件系统
  noolddir # 转储后的日志文件和当前日志文件放在同一个目录下
  sharedscripts # 运行postrotate脚本，作用是在所有日志都轮转后统一执行一次脚本。如果没有配置这个，那么每个日志轮转后都会执行一次脚本
  prerotate # 在logrotate转储之前需要执行的指令，例如修改文件的属性等动作；必须独立成行
  postrotate # 在logrotate转储之后需要执行的指令，例如重新启动 (kill -HUP) 某个服务！必须独立成行
  daily # 指定转储周期为每天
  weekly # 指定转储周期为每周
  monthly # 指定转储周期为每月
  rotate count # 指定日志文件删除之前转储的次数，0 指没有备份，5 指保留5 个备份
  dateext # 使用当期日期作为命名格式
  dateformat .%s # 配合dateext使用，紧跟在下一行出现，定义文件切割后的文件名，必须配合dateext使用，只支持 %Y %m %d %s 这四个参数
  size(或minsize) log-size # 当日志文件到达指定的大小时才转储，log-size能指定bytes(缺省)及KB (sizek)或MB(sizem).
  当日志文件 >= log-size 的时候就转储。 以下为合法格式：（其他格式的单位大小写没有试过）
  size = 5 或 size 5 （>= 5 个字节就转储）
  size = 100k 或 size 100k
  size = 100M 或 size 100M


### NGINX日志的配置实例参考:
vim /etc/logrotate.d/nginx
/var/log/weblog/*.log {
    daily  # 指定转储周期为每天
    compress  # 通过gzip 压缩转储以后的日志
    rotate 7  # 保存7天的日志
    missingok  # 如果日志文件丢失，不要显示错误
    notifempty  # 当日志文件为空时，不进行轮转
    dateext  # 使用当期日期作为命名格式，exp: nginx_access.log-20190120
    sharedscripts  # 运行postrotate脚本
    postrotate  # 执行的指令
            if [ -f /run/nginx.pid ]; then
                    kill -USR1 `cat /run/nginx.pid`
            fi
    endscript  # 结束指令
}

