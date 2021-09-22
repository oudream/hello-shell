
wget https://github.com/qishibo/AnotherRedisDesktopManager/releases/download/v1.4.8/Another-Redis-Desktop-Manager.1.4.8.AppImage -o /opt/Another-Redis-Desktop-Manager.1.4.8.AppImage

chmod +x /opt/Another-Redis-Desktop-Manager.1.4.8.AppImage

cat > /root/桌面/Another-Redis-Desktop-Manager.desktop <<EOF
[Desktop Entry]
Name=Another-Redis-Desktop-Manager.1.4.8
Exec=/opt/Another-Redis-Desktop-Manager.1.4.8.AppImage --no-sandbox
Type=Application
StartupNotify=true
EOF

gio set /root/桌面/Another-Redis-Desktop-Manager.desktop "metadata::trusted" yes

# 在18.04，它对我不起作用。目标.desktop文件保留Allow executing file as program在属性菜单中未选中的复选框