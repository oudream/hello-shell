#!/usr/bin/env bash

systemctl list-units --type=service

ln -s /opt/ddd/cshell/hello/systemd/log1/timer1.service /etc/systemd/system/
systemctl enable timer1
systemctl start timer1

sudo journalctl -f -u timer1

systemctl stop timer1
systemctl disable timer1
rm /etc/systemd/system/timer1.service
