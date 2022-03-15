
### vnc server

# step 1
# 设置屏幕共享

# step 2
yum install -y dconf-editor
apt install dconf-editor -y

dconf write /org/gnome/desktop/remote-access/require-encryption false


#
