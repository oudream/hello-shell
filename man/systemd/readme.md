

###
```shell script
cp /home/log4t/deploy/f2/filebeat/log4j/filebeat-log4j.service /etc/systemd/system/
systemctl enable filebeat-log4j.service
systemctl disable filebeat-log4j.service
systemctl start filebeat-log4j.service
systemctl stop filebeat-log4j.service
systemctl status filebeat-log4j.service

journalctl -f -u filebeat-log4j.service
journalctl -f -u filebeat-log4j.service --since today

```

