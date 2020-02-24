#!/usr/bin/env bash

# 获取每台服务器的uptime：
pssh -h ip.txt -i uptime

# 查看每台服务器上mysql复制IO/SQL线程运行状态信息：
pssh -h IP.txt -i "/usr/local/mysql/bin/mysql -e 'show slave status \G'"|grep Running:

# 保存每台服务器运行的结果：
pssh -h IP.txt -i -o /tmp/pssh/ uptime

cat /tmp/pssh/*


pssh    # parallel-ssh   （pssh）     在多个主机上并行地运行命令。
pscp    # parallel-scp   （pscp）     把文件并行地复制到多个主机上。
psync   # parallel-rsync （psync）    通过 rsync 协议把文件高效地并行复制到多个主机上。
pslurp  # parallel-slurp （pslurp）   把文件并行地从多个远程主机复制到中心主机上。
pnuke   # parallel-nuke  （pnuke）    并行地在多个远程主机上杀死进程。

# ubuntu
/usr/bin/parallel-scp
/usr/bin/parallel-ssh
/usr/bin/parallel-rsync
/usr/bin/parallel-slurp
/usr/bin/parallel-nuke


## install
# CentOs
yum install pssh
# or
wget http://parallel-ssh.googlecode.com/files/pssh-2.3.1.tar.gz
tar xf pssh-2.3.1.tar.gz
cd pssh-2.3.1/
python setup.py install
# MacOs
brew install pssh
# Ubuntu
apt install pssh


parallel-ssh [OPTIONS] command [...]

## options
--version  # : 查看版本
--help     # : 查看帮助，即此信息
-h         # : 主机文件列表，内容格式”[user@]host[:port]”
-H         # : 主机字符串，内容格式”[user@]host[:port]”
-          # : 登录使用的用户名
-p         # : 并发的线程数【可选】
-o         # : 输出的文件目录【可选】
-e         # : 错误输入文件【可选】
-t         # : TIMEOUT 超时时间设置，0无限制【可选】
-O         # : SSH的选项
-v         # : 详细模式
-A         # : 手动输入密码模式
-x         # : 额外的命令行参数使用空白符号，引号，反斜线处理
-X         # : 额外的命令行参数，单个参数模式，同-x
-i         # : 每个服务器内部处理信息输出
-P         # : 打印出服务器返回信息

# Options:
  --version             # show program's version number and exit
  --help                # show this help message and exit
  -h HOST_FILE, --hosts=HOST_FILE
                        # hosts file (each line "[user@]host[:port]")
  -H HOST_STRING, --host=HOST_STRING
                        # additional host entries ("[user@]host[:port]")
  -l USER, --user=USER  # username (OPTIONAL)
  -p PAR, --par=PAR     # max number of parallel threads (OPTIONAL)
  -o OUTDIR, --outdir=OUTDIR
                        # output directory for stdout files (OPTIONAL)
  -e ERRDIR, --errdir=ERRDIR
                        # output directory for stderr files (OPTIONAL)
  -t TIMEOUT, --timeout=TIMEOUT
                        # timeout (secs) (0 = no timeout) per host (OPTIONAL)
  -O OPTION, --option=OPTION
                        # SSH option (OPTIONAL)
  -v, --verbose         # turn on warning and diagnostic messages (OPTIONAL)
  -A, --askpass         # Ask for a password (OPTIONAL)
  -x ARGS, --extra-args=ARGS
                        # Extra command-line arguments, with processing for
                        # spaces, quotes, and backslashes
  -X ARG, --extra-arg=ARG
                        # Extra command-line argument
  -i, --inline          # inline aggregated output and error for each server
  --inline-stdout       # inline standard output for each server
  -I, --send-input      # read from standard input and send as input to ssh
  -P, --print           # print output as we get it
