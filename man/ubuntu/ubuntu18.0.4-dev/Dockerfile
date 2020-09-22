FROM ubuntu:18.04


RUN echo "deb http://security.ubuntu.com/ubuntu xenial-security main" | tee /etc/apt/sources.list.d/libjasper.list && \
    apt update -y ; apt upgrade -y && \
    apt install -y gcc g++ cmake build-essential gdb gdbserver git \
        unixodbc unixodbc-dev libcurl4-openssl-dev uuid uuid-dev libssl-dev libncurses5-dev \
        qt5-default libqt5svg5 libqt5svg5-dev qtcreator \
        software-properties-common \
        libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev \
        python3 python3-pip python3-dev python3-numpy \
        libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3 1 && \
    update-alternatives --install /usr/bin/pip python /usr/bin/pip3 1

RUN cd /opt && \
    git clone https://github.com/opencv/opencv.git opencv && \
    cd /opt/opencv && git reset --hard 4c71dbf && \
    mkdir build && cd build && \
    cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local .. && \
    make -j7 && make install && \
    rm -r /opt/opencv

RUN apt update \
    && apt install -y openssh-server \
                      xauth \
                      x11-apps \
    && mkdir /var/run/sshd \
    && mkdir /root/.ssh \
    && chmod 755 /root/.ssh \
    && ssh-keygen -A \
    && sed -i "s/^.*PasswordAuthentication.*$/PasswordAuthentication yes/" /etc/ssh/sshd_config \
    && sed -i "s/^#PermitRootLogin.*$/PermitRootLogin yes/" /etc/ssh/sshd_config \
    && sed -i "s/^.*X11Forwarding.*$/X11Forwarding yes/" /etc/ssh/sshd_config \
    && sed -i "s/^.*X11UseLocalhost.*$/X11UseLocalhost no/" /etc/ssh/sshd_config \
    && grep "^X11UseLocalhost" /etc/ssh/sshd_config || echo "X11UseLocalhost no" >> /etc/ssh/sshd_config \
    && rm -rf /var/lib/apt/lists/*

RUN echo "root:123456" | chpasswd

ENTRYPOINT ["sh", "-c", "/usr/sbin/sshd && tail -f /dev/null"]
