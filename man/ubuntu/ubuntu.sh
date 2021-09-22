
RUN apt-get update -y ; apt-get upgrade -y && \
    apt-get install -y apt-utils wget openssh-server telnet vim passwd ifstat unzip iftop htop telnet git \
    samba net-tools lsof rsync gcc g++ cmake build-essential gdb gdbserver \
    unixodbc unixodbc-dev libcurl4-openssl-dev uuid uuid-dev \
    qt5-default libqt5svg5 libqt5svg5-dev qtcreator


# Ubuntu 18.04 屏蔽 ctrl + alt + 箭头 快捷键
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['']"
# 恢复默认为 reset
gsettings reset org.gnome.desktop.wm.keybindings
