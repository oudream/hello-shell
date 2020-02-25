#!/usr/bin/env bash

yum install ntpdate
rm -f /etc/localtime
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
ntpdate ntp1.aliyun.com
