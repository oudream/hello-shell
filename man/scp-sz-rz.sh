#!/usr/bin/env bash

# scp [参数] [原路径] [目标路径]

#-1  强制scp命令使用协议ssh1
#-2  强制scp命令使用协议ssh2
#-4  强制scp命令只使用IPv4寻址
#-6  强制scp命令只使用IPv6寻址
#-B  使用批处理模式（传输过程中不询问传输口令或短语）
#-C  允许压缩。（将-C标志传递给ssh，从而打开压缩功能）
#-p 保留原文件的修改时间，访问时间和访问权限。
#-q  不显示传输进度条。
#-r  递归复制整个目录。
#-v 详细方式显示输出。scp和ssh(1)会显示出整个过程的调试信息。这些信息用于调试连接，验证和配置问题。
#-c cipher  以cipher将数据传输进行加密，这个选项将直接传递给ssh。
#-F ssh_config  指定一个替代的ssh配置文件，此参数直接传递给ssh。
#-i identity_file  从指定文件中读取传输时使用的密钥文件，此参数直接传递给ssh。
#-l limit  限定用户所能使用的带宽，以Kbit/s为单位。
#-o ssh_option  如果习惯于使用ssh_config(5)中的参数传递方式，
#-P port  注意是大写的P, port是指定数据传输用到的端口号
#-S program  指定加密传输时所使用的程序。此程序必须能够理解ssh(1)的选项。

# 从本地复制到远程
scp local_file remote_username@remote_ip:remote_file
scp -r local_folder remote_username@remote_ip:remote_folder

# 从远程复制到本地
scp -P 4588 remote@xx.com:/usr/local/sin.sh /home/administrator

scp -P 2231 root@34.69.62.252:/tmp/hello-* /opt/




### install sz rz
# install iTerm2:
brew cask info iterm2-beta
# install sz rz
brew install lrzsz
apt install lrzsz

# macos
cd /usr/local/bin

cat >> /usr/local/bin/iterm2-send-zmodem.sh <<EOF
#!/bin/bash
# Author: Matt Mastracci (matthew@mastracci.com)
# AppleScript from http://stackoverflow.com/questions/4309087/cancel-button-on-osascript-in-a-bash-script
# licensed under cc-wiki with attribution required
# Remainder of script public domain

osascript -e 'tell application "iTerm2" to version' > /dev/null 2>&1 && NAME=iTerm2 || NAME=iTerm
if [[ $NAME = "iTerm" ]]; then
    FILE=`osascript -e 'tell application "iTerm" to activate' -e 'tell application "iTerm" to set thefile to choose file with prompt "Choose a file to send"' -e "do shell script (\"echo \"&(quoted form of POSIX path of thefile as Unicode text)&\"\")"`
else
    FILE=`osascript -e 'tell application "iTerm2" to activate' -e 'tell application "iTerm2" to set thefile to choose file with prompt "Choose a file to send"' -e "do shell script (\"echo \"&(quoted form of POSIX path of thefile as Unicode text)&\"\")"`
fi
if [[ $FILE = "" ]]; then
    echo Cancelled.
    # Send ZModem cancel
    echo -e \\x18\\x18\\x18\\x18\\x18
    sleep 1
    echo
    echo \# Cancelled transfer
else
    /usr/local/bin/sz "$FILE" -e -b
    sleep 1
    echo
    echo \# Received $FILE
fi
EOF

cat >> /usr/local/bin/iterm2-recv-zmodem.sh <<EOF
#!/bin/bash
# Author: Matt Mastracci (matthew@mastracci.com)
# AppleScript from http://stackoverflow.com/questions/4309087/cancel-button-on-osascript-in-a-bash-script
# licensed under cc-wiki with attribution required
# Remainder of script public domain

osascript -e 'tell application "iTerm2" to version' > /dev/null 2>&1 && NAME=iTerm2 || NAME=iTerm
if [[ $NAME = "iTerm" ]]; then
    FILE=`osascript -e 'tell application "iTerm" to activate' -e 'tell application "iTerm" to set thefile to choose folder with prompt "Choose a folder to place received files in"' -e "do shell script (\"echo \"&(quoted form of POSIX path of thefile as Unicode text)&\"\")"`
else
    FILE=`osascript -e 'tell application "iTerm2" to activate' -e 'tell application "iTerm2" to set thefile to choose folder with prompt "Choose a folder to place received files in"' -e "do shell script (\"echo \"&(quoted form of POSIX path of thefile as Unicode text)&\"\")"`
fi

if [[ $FILE = "" ]]; then
    echo Cancelled.
    # Send ZModem cancel
    echo -e \\x18\\x18\\x18\\x18\\x18
    sleep 1
    echo
    echo \# Cancelled transfer
else
    cd "$FILE"
    /usr/local/bin/rz -E -e -b
    sleep 1
    echo
    echo
    echo \# Sent \-\> $FILE
fi
EOF

#wget https://raw.github.com/aikuyun/iterm2-zmodem/master/iterm2-send-zmodem.sh
#wget https://raw.github.com/aikuyun/iterm2-zmodem/master/iterm2-recv-zmodem.sh
chmod 777 /usr/local/bin/iterm2-*

### 配置 iTerm2
# 配置iTerm2的触发器（点击菜单的Profiles，选择某个profile之后然后继续选择advanced → triggers，添加triggers），配置器触发如下：
#
#    Regular expression: rz waiting to receive.\*\*B0100
#    Action: Run Silent Coprocess
#    Parameters: /usr/local/bin/iterm2-send-zmodem.sh
#    Instant: checked
#
#    Regular expression: \*\*B00000000000000
#    Action: Run Silent Coprocess
#    Parameters: /usr/local/bin/iterm2-recv-zmodem.sh
#    Instant: checked

# rz 上传功能
# 在bash中，也就是iTerm2终端输入rz 就会弹出文件选择框，选择文件 choose 就开始上传，会上传到当前目录
sz

# 下载功能
rz $fileName
# 会弹出窗体 我们选择要保存的地方即可。