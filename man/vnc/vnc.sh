
### vnc server

# step 1
# 设置屏幕共享
# ubuntu20.04 如果没有共享桌面的设置选项,需要安装vino用于设置共享桌面
apt-get install vino -y

# step 2
yum install -y dconf-editor
apt install dconf-editor -y

dconf write /org/gnome/desktop/remote-access/require-encryption false


#


# This is the network config written by 'subiquity'
network:
  ethernets:
    ens18:
      addresses:
        - 10.50.52.114/24
      gateway4: 10.50.52.1
      nameservers:
        addresses: [114.114.114.114, 10.1.1.1, 202.96.128.166]
        search: [mydomain, otherdomain]
  version: 2
  renderer: networkd
