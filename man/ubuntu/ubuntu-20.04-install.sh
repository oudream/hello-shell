### change root password
passwd root


### ssh root
apt install openssh-server
# vim /etc/ssh/sshd_config
sed -i 's/PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config
systemctl status ssh
systemctl restart ssh


### desktop root login
cat >> /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf << EOF
greeter-show-manual-login=true
all-guest=false
EOF
sed -i 's/auth   required        pam_succeed_if.so/#auth   required        pam_succeed_if.so/g' /etc/pam.d/gdm-autologin
sed -i 's/auth   required        pam_succeed_if.so/#auth   required        pam_succeed_if.so/g' /etc/pam.d/gdm-password
sed -i 's/mesg n/#mesg n/g' /root/.profile
cat >> /root/.profile << EOF
tty -s&&mesg n || true
EOF


### vnc
apt install vino dconf-editor -y
dconf write /org/gnome/desktop/remote-access/require-encryption false
# 在界面中配置共享界面


### terminator
apt-get install -y terminator


### Ubuntu 镜像
- https://developer.aliyun.com/mirror/ubuntu/


### install libs
apt update -y ; apt-get upgrade -y && apt install -y terminator gcc g++ cmake build-essential gdb gdbserver git unixodbc unixodbc-dev libcurl4-openssl-dev uuid uuid-dev libssl-dev libncurses5-dev software-properties-common libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev python3 python3-pip python3-dev libopencv-dev python3-opencv libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libgl1-mesa-dev net-tools

### pip
pip install opencv-python pandas ultralytics matplotlib -i https://pypi.tuna.tsinghua.edu.cn/simple

### install linaro arm32
cd /opt
wget https://releases.linaro.org/components/toolchain/binaries/latest-7/arm-linux-gnueabihf/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf.tar.xz
tar xvf gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf.tar.xz

### install linaro arm64
wget https://releases.linaro.org/components/toolchain/binaries/latest-7/aarch64-linux-gnu/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu.tar.xz
tar xvf gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu.tar.xz

### install qt
apt install libxcb-xinerama0
cd /opt/
mkdir tmp
wget https://download.qt.io/official_releases/qt/5.14/5.14.2/qt-opensource-linux-x64-5.14.2.run
wget https://download.qt.io/archive/qt/5.14/5.14.2/qt-opensource-linux-x64-5.14.2.run
chmod +x qt-opensource-linux-x64-5.14.2.run
./qt-opensource-linux-x64-5.14.2.run

### install docker
apt update -y && apt-get upgrade -y && apt install -y ca-certificates curl gnupg lsb-release
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update -y
apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
systemctl enable docker
systemctl start docker
systemctl status docker
docker run hello-world

### install go
rm -rf /usr/local/go
wget https://go.dev/dl/go1.19.2.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.19.2.linux-amd64.tar.gz
cat >> /etc/profile << EOF
export GOROOT=/usr/local/go
export GOPATH=/root/gopath
export PATH=\$GOPATH/bin:\$GOROOT/bin:\$PATH
EOF

### chrome
chmod +x google-chrome-stable_current_amd64.deb
# ./google-chrome-stable_current_amd64.deb
apt install ./google-chrome-stable_current_amd64.deb
google-chrome --no-sandbox
# copy google-chrome.desktop
chmod +x google-chrome.desktop
./google-chrome.desktop


### mysql docker
mkdir -p /opt/mysql1/data
docker run -d --restart=always --name mysql-client -v /opt/mysql1/data:/var/lib/mysql -p 3306:3306 -p 33060:33060 -e MYSQL_ROOT_PASSWORD="XXXXXX" -e MYSQL_ROOT_HOST="%" mysql:5.7.28 mysqld   --log-bin=mysql-bin   --binlog-format=ROW   --lower_case_table_names=1   --server-id=1
docker ps

### dev
### hello_iec104
mkdir /opt/dev
cd /opt/dev
git clone https://gitee.com/oudream/hello_iec104.git
cd /opt/dev/hello_iec104/
git submodule update --init --recursive
# compile
rm -rf /opt/dev/hello_iec104/cmake-build-linaro
mkdir /opt/dev/hello_iec104/cmake-build-linaro
cd /opt/dev/hello_iec104/cmake-build-linaro
export STAGING_DIR=/opt/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu/aarch64-linux-gnu
cmake -D U_DEPLOY_PATH="/opt/dev/hello_iec104/build/deploy-linaro" -D CMAKE_TOOLCHAIN_FILE="/opt/dev/hello_iec104/build/aarch64/linaro/toolchainfile.cmake" ..
make -j 8

### install node.js
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
apt install -y nodejs
node -v
npm -v

### mqtt
cd /opt/dev
git clone https://github.com/eclipse/mosquitto.git
git clone https://github.com/troydhanson/uthash.git
cp uthash/src/* mosquitto/include
cd mosquitto
git checkout fd0e398
# build amd64
cd /opt/dev/mosquitto
rm -rf cmake-build-amd64 && mkdir cmake-build-amd64 &&cd cmake-build-amd64
cmake -DWITH_CJSON=no -DWITH_TLS=no -DWITH_BUNDLED_DEPS=no -DWITH_DOCS=no -DDOCUMENTATION=OFF ..
make -j 8
mkdir -p /opt/deploy/amd64/mosquitto/
cp src/mosquitto /opt/deploy/amd64/mosquitto/
cp client/mosquitto_pub /opt/deploy/amd64/mosquitto/
cp client/mosquitto_rr /opt/deploy/amd64/mosquitto/
cp client/mosquitto_sub /opt/deploy/amd64/mosquitto/
cp lib/libmosquitto.so.1 /opt/deploy/amd64/mosquitto/
# build for arm64
cd /opt/dev/mosquitto
mkdir cmake-build-linaro64 &&cd cmake-build-linaro64
cmake -DWITH_CJSON=no -DWITH_TLS=no -DWITH_BUNDLED_DEPS=no -DWITH_DOCS=no -DDOCUMENTATION=OFF -D CMAKE_TOOLCHAIN_FILE="/opt/dev/hello_iec104/build/aarch64/linaro/toolchainfile.cmake" ..
make -j 8
mkdir -p /opt/deploy/arm64/mosquitto/
cp src/mosquitto /opt/deploy/arm64/mosquitto/
cp client/mosquitto_pub /opt/deploy/arm64/mosquitto/
cp client/mosquitto_rr /opt/deploy/arm64/mosquitto/
cp client/mosquitto_sub /opt/deploy/arm64/mosquitto/
cp lib/libmosquitto.so.1 /opt/deploy/arm64/mosquitto/
# build for arm32
cd /opt/dev/mosquitto
mkdir cmake-build-arm32 && cd cmake-build-arm32
cmake -DWITH_CJSON=no -DWITH_TLS=no -DWITH_BUNDLED_DEPS=no -DWITH_DOCS=no -DDOCUMENTATION=OFF -D CMAKE_TOOLCHAIN_FILE="/opt/dev/hello_iec104/build/armv7/linaro/toolchainfile.cmake" ..
make -j 8
mkdir /opt/deploy/arm32/mosquitto/
cp src/mosquitto /opt/deploy/arm32/mosquitto/
cp client/mosquitto_pub /opt/deploy/arm32/mosquitto/
cp client/mosquitto_rr /opt/deploy/arm32/mosquitto/
cp client/mosquitto_sub /opt/deploy/arm32/mosquitto/
cp lib/libmosquitto.so.1 /opt/deploy/arm32/mosquitto/

### redis amd64 7.0.5
cd /opt/dev
git clone https://github.com/redis/redis.git redis-amd64
cd redis-amd64
git checkout 1571907
make MALLOC=libc
mkdir -p /opt/deploy/amd64/redis/
cp src/redis-server /opt/deploy/amd64/redis/
cp src/redis-cli /opt/deploy/amd64/redis/
cp src/redis-check-aof /opt/deploy/amd64/redis/
cp src/redis-check-rdb /opt/deploy/amd64/redis/
cp src/redis-sentinel /opt/deploy/amd64/redis/
cp src/redis-benchmark /opt/deploy/amd64/redis/

### redis arm64 7.0.5
cd /opt/dev
git clone https://github.com/redis/redis.git redis-arm64
cd redis-arm64
git checkout 1571907
export PATH=$PATH:/opt/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu/bin/
export CC=aarch64-linux-gnu-gcc
export CXX=aarch64-linux-gnu-g++
export LD=aarch64-linux-gnu-ld
export RAINLIB=aarch64-linux-gnu-rainlib
export AR=aarch64-linux-gnu-ar
export LINK=aarch64-linux-gnu-g++
make MALLOC=libc
mkdir -p /opt/deploy/arm64/redis/
cp src/redis-server /opt/deploy/arm64/redis/
cp src/redis-cli /opt/deploy/arm64/redis/
cp src/redis-check-aof /opt/deploy/arm64/redis/
cp src/redis-check-rdb /opt/deploy/arm64/redis/
cp src/redis-sentinel /opt/deploy/arm64/redis/
cp src/redis-benchmark /opt/deploy/arm64/redis/

### redis arm32 7.0.5
cd /opt/dev
git clone https://github.com/redis/redis.git redis-arm32
cd redis-arm32
git checkout 1571907
export PATH=$PATH:/opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/
export CC=arm-linux-gnueabihf-gcc
export CXX=arm-linux-gnueabihf-g++
export LD=arm-linux-gnueabihf-ld
export RAINLIB=arm-linux-gnueabihf-rainlib
export AR=arm-linux-gnueabihf-ar
export LINK=arm-linux-gnueabihf-g++
make MALLOC=libc
mkdir -p /opt/deploy/arm32/redis/
cp src/redis-server /opt/deploy/arm32/redis/
cp src/redis-cli /opt/deploy/arm32/redis/
cp src/redis-check-aof /opt/deploy/arm32/redis/
cp src/redis-check-rdb /opt/deploy/arm32/redis/
cp src/redis-sentinel /opt/deploy/arm32/redis/
cp src/redis-benchmark /opt/deploy/arm32/redis/

### tar
cd /opt/deploy/amd64
tar zcvf mosquitto-amd64-v221107.tar.gz mosquitto/
tar zcvf redis-amd64-v221107.tar.gz redis/
#
cd /opt/deploy/arm64
tar zcvf mosquitto-arm64-v221107.tar.gz mosquitto/
tar zcvf redis-arm64-v221107.tar.gz redis/
#
cd /opt/deploy/arm32
tar zcvf mosquitto-arm32-v221107.tar.gz mosquitto/
tar zcvf redis-arm32-v221107.tar.gz redis/
#
find $PWD -name \*.tar.gz | while read dir; do mv $dir ./; done


### db
wget https://dbeaver.io/files/dbeaver-ce-latest-linux.gtk.x86_64.tar.gz
tar zxvf dbeaver-ce-latest-linux.gtk.x86_64.tar.gz
