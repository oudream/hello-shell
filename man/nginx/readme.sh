#!/usr/bin/env bash

docker run -tid --privileged=true -p 80:80 -v server:/opt/server/ centos:centos7 /sbin/init

yum install epel-release -y

yum -y install sudo wget gcc gcc-c++ automake autoconf libtool make ncurses-devel perl pcre pcre-devel zlib gzip zlib-devel open openssl-dev vim


