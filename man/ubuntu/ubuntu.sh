
RUN apt-get update -y ; apt-get upgrade -y && \
    apt-get install -y apt-utils wget openssh-server telnet vim passwd ifstat unzip iftop htop telnet git \
    samba net-tools lsof rsync gcc g++ cmake build-essential gdb gdbserver \
    unixodbc unixodbc-dev libcurl4-openssl-dev uuid uuid-dev \
    qt5-default libqt5svg5 libqt5svg5-dev qtcreator