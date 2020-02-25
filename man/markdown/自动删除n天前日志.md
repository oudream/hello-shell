## 自动删除n天前日志
linux是一个很能自动产生文件的系统，日志、邮件、备份等。虽然现在硬盘廉价，我们可以有很多硬盘空间供这些文件浪费，
让系统定时清理一些不需要的文件很有一种爽快的事情。不用你去每天惦记着是否需要清理日志，不用每天收到硬盘空间不足的报警短信，
想好好休息的话，让我们把这个事情交给机器定时去执行吧。

1. 删除文件命令：

        find 对应目录 -mtime +天数 -name "文件名" -exec rm -rf {} \;
    实例命令：

        find /opt/soft/log/ -mtime +30 -name "*.log" -exec rm -rf {} \;
    说明：

        将/opt/soft/log/目录下所有30天前带".log"的文件删除。具体参数说明如下：
        find：linux的查找命令，用户查找指定条件的文件；
        /opt/soft/log/：想要进行清理的任意目录；
        -mtime：标准语句写法；
        +30：查找30天前的文件，这里用数字代表天数；
        "*.log"：希望查找的数据类型，"*.jpg"表示查找扩展名为jpg的所有文件，"*"表示查找所有文件，这个可以灵活运用，举一反三；
        -exec：固定写法；
        rm -rf：强制删除文件，包括目录；
        {} \; ：固定写法，一对大括号+空格+\+;
2. 计划任务：

        若嫌每次手动执行语句太麻烦，可以将这小语句写到一个可执行shell脚本文件中，再设置cron调度执行，那就可以让系统自动去清理相关文件。
    2.1创建shell：

        touch /opt/soft/bin/auto-del-30-days-ago-log.sh
        chmod +x auto-del-30-days-ago-log.sh
        新建一个可执行文件auto-del-30-days-ago-log.sh，并分配可运行权限
    2.2编辑shell脚本：

        vi auto-del-30-days-ago-log.sh
        编辑auto-del-30-days-ago-log.sh文件如下：
        #!/bin/sh
        find /opt/soft/log/ -mtime +30 -name "*.log" -exec rm -rf {} \;
        ok，保存退出(:wq)。
    2.3计划任务：

        #crontab -e
        将auto-del-30-days-ago-log.sh执行脚本加入到系统计划任务，到点自动执行
        输入：
        10 0 * * * /opt/soft/log/auto-del-7-days-ago-log.sh >/dev/null 2>&1
        这里的设置是每天凌晨0点10分执行auto-del-7-days-ago-log.sh文件进行数据清理任务了。
    完成以上三步，你就再也不每天惦记是否硬盘空间满了，该清理日志文件了，再也不会受到服务器硬盘空间不足的报警信息了，放心的去看书喝咖啡去吧！