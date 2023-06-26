#!/bin/bash

docker version
systemctl stop docker
systemctl stop docker.socket

yum remove -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine
yum install -y yum-utils device-mapper-persistent-data lvm2

yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum makecache fast
yum install -y docker-ce docker-ce-cli containerd.io

systemctl start docker
docker version
