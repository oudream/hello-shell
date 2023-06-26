#!/bin/sh

docker version
systemctl stop docker
systemctl stop docker.socket

apt remove -y docker docker-engine docker.io containerd runc
apt update -y
apt install -y apt-transport-https ca-certificates curl software-properties-common
apt update -y

apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update -y

apt install -y docker-ce docker-ce-cli containerd.io

docker version
