#!/usr/bin/env bash

ln -s /opt/ddd/cshell/hello/systemd/log1/timer1.service /etc/systemd/system/
systemctl list-units --type=service
systemctl enable timer1
systemctl start timer1

