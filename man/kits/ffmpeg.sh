#!/usr/bin/env bash

# download ffmpeg-20190826-0821bc4-win64-static.zip
open https://ffmpeg.zeranoe.com/builds/win64/static/

# rtsp ws
node ./jsmpeg/websocket-relay.js supersecret 8081 8082

# rtsp convert to mp2
# rtsp info : ffprobe.exe rtsp://admin:12345@10.31.16.210/h264/ch1/sub/av_stream
ffmpeg -i rtsp://admin:12345@10.31.16.210/h264/ch1/sub/av_stream -f mpegts -codec:v mpeg1video -s 352x288 -b:v 1000k -bf 0 http://localhost:8081/supersecret
