
RUN apt-get update -y ; apt-get upgrade -y && \
    apt-get install -y apt-utils wget openssh-server telnet vim passwd ifstat unzip iftop htop telnet git \
    samba net-tools lsof rsync gcc g++ cmake build-essential gdb gdbserver \
    unixodbc unixodbc-dev libcurl4-openssl-dev uuid uuid-dev \
    qt5-default libqt5svg5 libqt5svg5-dev qtcreator

sudo apt install -y gcc g++ cmake build-essential gdb gdbserver git unixodbc unixodbc-dev libcurl4-openssl-dev uuid uuid-dev libssl-dev libncurses5-dev qt5-default libqt5svg5 libqt5svg5-dev qtcreator software-properties-common libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev python3 python3-pip python3-dev python3-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev



# GNOME
sudo apt install tasksel -y
sudo tasksel
# 向下滚动以选择Ubuntu desktop
#
# or
#
sudo apt-get install gnome-shell
sudo apt-get install ubuntu-gnome-desktop
# 有问题 可以
sudo apt-get install unity-tweak-tool
sudo apt-get install gnome-tweak-tool



# Ubuntu 18.04 屏蔽 ctrl + alt + 箭头 快捷键
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['']"
# 恢复默认为 reset
gsettings reset org.gnome.desktop.wm.keybindings
