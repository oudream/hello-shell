FROM centos:centos7

## 一次性安装
RUN yum update -y && \
    yum install -y wget openssh-server telnet screen vim passwd ifstat unzip iftop htop git \
    samba net-tools lsof rsync gcc gcc-c++ make autoconf kernel-devel cmake gdb gdb-gdbserver \
    ncurses-libs ncurses-devel unixODBC unixODBC-devel libuuid libuuid-devel openssl-devel openssl \
    nginx mesa-libGL-devel
# libcurl-openssl-devel

### python3.7.8
# yum search python3 | grep devel
# yum install -y python3-devel.x86_64
RUN yum -y install zlib-devel bzip2-devel openssl-devel openssl-static ncurses-devel sqlite-devel readline-devel \
    tk-devel gdbm-devel db4-devel libpcap-devel xz-devel libffi-devel lzma gcc && \
    cd /usr/local/src/ && \
    wget https://www.python.org/ftp/python/3.7.8/Python-3.7.8.tar.xz && \
    tar xvf Python-3.7.8.tar.xz && \
    mv Python-3.7.8 /usr/local/python-3.7 && \
    cd /usr/local/python-3.7/ && \
    ./configure --prefix=/usr/local/sbin/python-3.7 && \
    make && make install

#### qt5.14.2
# wget https://download.qt.io/official_releases/qt/5.14/5.14.2/qt-opensource-linux-x64-5.14.2.run
# chmod +x qt-opensource-linux-x64-5.14.2.run
# ./qt-opensource-linux-x64-5.14.2.run

### nginx
# yum install -y perl perl-devel perl-ExtUtils-Embed libxslt libxslt-devel libxml2 libxml2-devel gd gd-devel GeoIP GeoIP-devel

RUN apt update \
    && apt install -y openssh-server \
                      xorg-x11-server-Xorg xorg-x11-xauth xorg-x11-apps \
    && mkdir /var/run/sshd \
    && mkdir /root/.ssh \
    && chmod 755 /root/.ssh \
    && ssh-keygen -A \
    && sed -i "s/^.*PasswordAuthentication.*$/PasswordAuthentication no/" /etc/ssh/sshd_config \
    && sed -i "s/^#PermitRootLogin.*$/PermitRootLogin yes/" /etc/ssh/sshd_config \
    && sed -i "s/^.*X11Forwarding.*$/X11Forwarding yes/" /etc/ssh/sshd_config \
    && sed -i "s/^.*X11UseLocalhost.*$/X11UseLocalhost no/" /etc/ssh/sshd_config \
    && grep "^X11UseLocalhost" /etc/ssh/sshd_config || echo "X11UseLocalhost no" >> /etc/ssh/sshd_config

### --- notice notice notice ---
#RUN echo "YOUR_PUB_KEY_HERE" >> /root/.ssh/authorized_keys
#
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC6x8pcWLtU0Oj/iZaps8gUSGnGQPI22tyFKEQ7yczQOpZkBvp+nnYi3pGeRRlJTG+Shyw6wgT4fwLUJ0/HkzOyGbTPPPSLGJZpiNDNo8ULmSJjtwX1odBeJxskxTHbVaGIRTTAzd5JmAnYBes2F/n6TfNW2ZoZaAh7R+ToX2e/JgniU8Bg39p+XJYdyb3d5EBnT7HjlKdohQwILCeSUemgVr2inxAYnFWMo62dIouYbEFPjR0mL69u/qxoIhBWEyE0Su7yg21pRZkMt4a5Yayk0p/GJYIWbHM9HlOzptuGHe/7uvOojxA9A2EmTwCX7WySPsMt9hibLlQ6le8ffeU7 oudream@bogon" >> /root/.ssh/authorized_keys

ENTRYPOINT ["sh", "-c", "/usr/sbin/sshd && tail -f /dev/null"]
