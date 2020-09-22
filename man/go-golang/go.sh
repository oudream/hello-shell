#!/usr/bin/env bash

go env
export GOPATH=/fff/gopath
# GOPATH="/home/ferghs/gowork:/home/ferghs/gowork/src/project1"
# Windows使用分号分割(;)

sudo apt-get update
sudo apt-get -y upgrade

wget https://dl.google.com/go/go1.12.6.linux-amd64.tar.gz
sudo tar -xvf go1.12.6.linux-amd64.tar.gz
sudo mv go /usr/local

cat >> ~/.bash_profile << EOF
export GOROOT=/usr/local/go
export GOPATH=/home/gopath
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
EOF
