### change root password
sudo passwd root


### ssh root
apt install openssh-client=1:7.6p1-4
apt install openssh-server
# vim /etc/ssh/sshd_config
sed -i 's/PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config
systemctl status ssh
systemctl restart ssh


### Ubuntu 更换国内阿里源（优先使用）、163源、清华源、中科大源（打开以下网址）
- https://developer.aliyun.com/mirror/ubuntu/
- https://www.cnblogs.com/zqifa/p/12910989.html
### 更换国内源后
apt update -y ; apt-get upgrade -y


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


### install libs
apt update -y ; apt-get upgrade -y && apt install -y terminator gcc g++ cmake build-essential gdb gdbserver git unixodbc unixodbc-dev libcurl4-openssl-dev uuid uuid-dev libssl-dev libncurses5-dev software-properties-common libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev python3 python3-pip python3-dev libopencv-dev python3-opencv libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libgl1-mesa-dev net-tools


### terminator（工具）
apt-get install -y terminator


### 拉代码
mkdir /opt/dev
git clone http://10.50.52.210:9980/iot/platform.git /opt/dev/device_communicator
git checkout dev

