#!/usr/bin/env bash


open https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Basics_of_HTTP/MIME_types


text/plain
text/html
image/jpeg
image/png
audio/mpeg
audio/ogg
audio/*
video/mp4
application/*
application/json
application/javascript
application/ecmascript
application/octet-stream


text
# 表明文件是普通文本，理论上是人类可读
# text/plain, text/html, text/css, text/javascript
image
# 表明是某种图像。不包括视频，但是动态图（比如动态gif）也使用image类型
# image/gif, image/png, image/jpeg, image/bmp, image/webp, image/x-icon, image/vnd.microsoft.icon
audio
# 表明是某种音频文件
# audio/midi, audio/mpeg, audio/webm, audio/ogg, audio/wav
video
# 表明是某种视频文件
# video/webm, video/ogg
application
# 表明是某种二进制数据
# application/octet-stream, application/pkcs12, application/vnd.mspowerpoint, application/xhtml+xml, application/xml,  application/pdf