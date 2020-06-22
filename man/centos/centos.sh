#!/usr/bin/env bash

yum install epel-release

# Bash Centos7 “which” command
yum whatprovides *bin/which
# or
yum install which

# yum-config-manager: command not found
yum -y install yum-utils

# netstat command not found
yum install net-tools

yum install unzip

# https://stackoverflow.com/questions/21802223/how-to-install-crontab-on-centos
yum install cronie
