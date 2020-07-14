#!/usr/bin/env bash

# 显示最近使用的10条历史命令
history 10


# https://www.cnblogs.com/cherishry/p/5886035.html
# history命令来获取用户的历史记录
history | head -10

# 使用 HISTTIMEFORMAT 显示时间戳
export HISTTIMEFORMAT='%F %T'
history | more

# 使用 HISTSIZE 控制历史命令记录的总行数
# 将这两行内容追加到/etc/profile文件中，当你再次重新登录bash时，历史命令总行数会变成100000
export HISTSIZE=100000
export HISTFILESIZE=100000

# 使用 HISTFILE 更改历史文件名称
# 默认情况下，历史命令存放在~/.bash_history文件中。如下，重新定位历史命令存放位置
export HISTFILE=/.logs/history_${LOGNAME}

# 使用 HISTCONTROL 从命令历史中剔除连续重复的条目
# HISTCONTROL=ignoredups剔除连续的相同命令的条目，仅剩余一条，如下：
export HISTCONTROL=ignoredups
history | tail -n 5


# history(选项)(参数)
# 选项
-c        # 清空当前历史命令；
-a        # 将历史命令缓冲区中命令写入历史命令文件中；
-r        # 将历史命令文件中的命令读入当前历史命令缓冲区；
-w        # 将当前历史命令缓冲区命令写入历史命令文件中。
-d offset # 根据offset删除记录。如果是正数则表示offset位置的记录，如果为负数则表示从结尾向前offset位置的记录。
-a        # 将当前终端的历史记录行添加到历史记录文件。
-n        # 将尚未从历史文件中读取的历史行追加到当前历史列表中。
-p        # 在每个arg上执行历史记录扩展并在标准输出上显示结果，而不将结果存储在历史记录列表中。
-s        # 将每个arg作为单个条目附加到历史记录列表。
# 参数
n # 打印最近的n条历史命令。
filename # 可选，表示历史文件；默认调用顺序为filename、环境变量HISTFILE、~/.bash_history
