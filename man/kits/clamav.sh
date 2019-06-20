#!/usr/bin/env bash

#Install ClamAV dependencies
#Install the developer tools
    sudo apt-get install build-essential
#
#Install library dependencies
     sudo apt-get install openssl libssl-dev libcurl4-openssl-dev zlib1g-dev libpng-dev libxml2-dev libjson-c-dev libbz2-dev libpcre3-dev ncurses-dev
#
#(very optional) Those wishing to use clamav-milter may wish to install the following
     sudo apt-get install libmilter1.0.1 libmilter-dev
#
#Install the unit testing dependencies
     sudo apt-get install valgrind check

cd /fff; wget https://www.clamav.net/downloads/production/clamav-0.101.2.tar.gz
tar xzvf clamav-0.101.2.tar.gz; cd clamav-0.101.2.tar.gz

./configure --enable-check

make -j2

make check

make install

# download virus's database
mkdir /usr/local/share/clamav; cd /usr/local/share/clamav; \
wget http://database.clamav.net/main.cvd; \
wget http://database.clamav.net/daily.cvd; \
wget http://database.clamav.net/bytecode.cvd


cp /usr/local/etc/freshclam.conf.sample /usr/local/etc/freshclam.conf
cp /usr/local/etc/clamd.conf.sample /usr/local/etc/clamd.conf

sed -i.bak 's/^Example/#Example/' /usr/local/etc/freshclam.conf
sed -i.bak 's/^Example/#Example/' /usr/local/etc/clamd.conf


#Configure SELinux for ClamAV
#Certain distributions (notably RedHat variants) when operating with SELinux enabled use the
# non-standard antivirus_can_scan_system SELinux option instead of clamd_can_scan_system.
#
#At this time, libclamav only sets the clamd_can_scan_system option, so you may need to
# manually enable antivirus_can_scan_system. If you don’t perform this step, freshclam
# will log something like this when it tests the newly downloaded signature databases:
#
#    During database load : LibClamAV Warning: RWX mapping denied: Can't allocate RWX Memory:
#    Permission denied
#
# To allow ClamAV to operate under SELinux, run the following:
setsebool -P antivirus_can_scan_system 1


    groupadd clamav
    useradd -g clamav -s /bin/false -c "Clam Antivirus" clamav

    sudo chown -R clamav:clamav /usr/local/share/clamav


#If you installed to a location in your system PATH:
    freshclam

#Important: It is common on Ubuntu after a fresh install to see the following
# error the first time you use ClamAV:
#    freshclam: error while loading shared libraries: libclamav.so.7:
#    cannot open shared object   file: No such file or directory
#You can fix this error by using ldconfig to rebuild the library search path.
    sudo ldconfig


clamscan -r /home /opt /fff /usr/local /tmp --log=/fff/clamscan.2.log


## clamscan常用参数选项
# -r：适用与所有文件
# --unrar：适用与 .rar 文件
# --arj：适用于 .arj 文件
# --unzoo：适用于 .zoo 文件
# --lha：适用于 .lzh 文件
# --jar：适用于 .jar 文件
# --deb：适用于 .deb 安装包
# --tar：适用于 .tar 文件
# --tgz：适用于 .tar.gz
# --log=FILE/-l FILE：适用于增加扫描日志
# --move=directory：适用于把病毒文件移动到目录directory下
# --copy=directory：适用于把病毒文件复制到目录directory下
# --remove：适用于删除病毒文件
# --quiet：适用于输出错误消息
# --infected/-i：适用于输出感染文件
# --suppress-ok-results/-o：适用于跳过扫描OK的文件

#定时扫描
#除了上述扫描病毒以外，你也可以设置个定时任务来定时扫描病毒；
crontab -e
