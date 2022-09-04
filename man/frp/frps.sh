
chmod +x /opt/frp/frps

cp /opt/frp/frps.service /etc/systemd/system/
systemctl enable frps.service
systemctl start frps.service
systemctl status frps.service
ps aux | grep frps

