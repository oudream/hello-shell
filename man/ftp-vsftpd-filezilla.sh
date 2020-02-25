#!/usr/bin/env bash

# FTP Server
vsftpd

open https://security.appspot.com/vsftpd.html
open https://security.appspot.com/vsftpd/vsftpd_conf.html
open https://en.wikipedia.org/wiki/Vsftpd

### install
# If you are a Ubuntu, Debian user:
sudo apt-get install vsftpd
# If you are a CentOS/RedHat/Fedora user:
sudo yum install vsftpd


### config
# To configure your FTP server more, please open the following file on vim
# by typing the following command in your terminal.
# If you are a Ubuntu, Debian user:
sudo vim /etc/vsftpd.conf
# If you are a CentOS/RedHat/Fedora user:
sudo vim /etc/vsftpd/vsftpd.conf


sudo service vsftpd restart

sudo telnel localhost 21

ps -aux | grep vsftpd
sudo netstat -ntaulp | grep vsftpd
sudo adduser ftp1user


# 匿名
anonymous_enable=YES
#
xferlog_file=/var/log/vsftpd.log
#
write_enable=YES

### log
# For viewing log files of vsftpd, please type the following command in the terminal
sudo cat /var/log/vsftpd.log
# To view the log file in real time, type the following command in the terminal
sudo tail -f /var/log/vsftpd.log



### FTP Client
filezilla
open https://filezilla-project.org/download.php?show_all=1