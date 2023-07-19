

### telnet
# https://blog.csdn.net/qq_38074673/article/details/103344832
# wget https://ftp.gnu.org/gnu/inetutils/inetutils-2.4.tar.gz
wget https://ftp.gnu.org/gnu/inetutils/inetutils-1.9.4.tar.gz
tar -xzvf inetutils-1.9.4.tar.gz
cd inetutils-1.9.4

# -mfloat-abi=hard
CC=/opt/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-gcc CXX=/opt/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-g++ \
./configure --host=aarch64-linux-gnu --disable-clients --disable-ipv6 --disable-ncurses --prefix=/

make
# make check

# sudo make install

# 上步完成后在 ./telnetd 目录下生成了telnetd ,在./src 目录下生成了inetd文件，上传到 /usr/sbin/

cat > /etc/inetd.conf <<EOF
telnet stream tcp nowait root /usr/bin/telnetd telnetd
EOF

# etc/services
# 确保里面会有这样（ telnet  23/tcp ）的内容,没有的话加上此行

# /etc/init.d/rcS
cat >> /etc/init.d/rcS << EOF
mkdir /dev/pts
mount devpts -t devpts /dev/pts
inetd
EOF

# /etc/securetty
cat > /etc/securetty << EOF
              pts/0
              pts/1
              pts/2
              pts/3
              pts/4
              pts/5
              pts/6
              pts/7
EOF
