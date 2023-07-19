
# 查看参数
stty -F /dev/ttyS1

# 设置波特率
stty -F /dev/ttyS1 speed 9600

# 收发数据
# 先打开后台接收：
cat /dev/ttyS1 &
# 发送：
echo hello >/dev/ttyS1
printf 'hello\r' >/dev/ttyS1

# http://cutecom.sourceforge.net/
# https://blog.csdn.net/Coxhuang/article/details/109133860
#
# in ubuntu
# 安装 python3 pip
apt install python3-pip
pip3 install pyserial


# Ubuntu串口助手
sudo apt install cutecom
# 手动配置串口名
vim ~/.config/CuteCom/CuteCom5.conf

