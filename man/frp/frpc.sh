
chmod +x frpc

cp frpc.service /etc/systemd/system/
systemctl disable frpc.service
systemctl enable frpc.service
systemctl start frpc.service
systemctl status frpc.service
ps aux | grep frpc

