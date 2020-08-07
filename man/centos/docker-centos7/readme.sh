#!/usr/bin/env bash


# build dockerfile
docker build -t gcl3-ubuntu .


# run on vps
docker run -d -p 2235:22 -v /opt/ddd:/opt/ddd gcl3-ubuntu
ssh root@35.232.43.174 -p 2235 -AXY -v


# run on macos(localhost)
docker run -d -p 2235:22 -p 8821:8821 -p 8841:8841 -p 8861:8861 5ed
ssh root@localhost -p 2235 -AXY -v
