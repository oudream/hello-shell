
### 易用的文件传输平台(支持P2P高速传输超大文件). 后端使用Golang, 前端React.
- https://github.com/edwardwohaijun/file-transfer

### A file transfer tool that can be used in the browser webrtc p2p
- https://github.com/a-wing/filegogo11

### 运行
```shell
nohup /mnt/sda2/dev/file-transfer/filetransferd -mgoHost 127.0.0.1:20117 -serverPort 9090 -maxUpload 5 -maxFileSize 1000M -duration 30m 1>/mnt/sda2/file-transfer.log 2>&1 &

/mnt/sda2/dev/file-transfer/filetransferd -mgoHost 127.0.0.1:20117 -serverPort 9090 -maxUpload 5 -maxFileSize 1000M -duration 30m
```

### 浏览器
- http://117.141.182.206:9090/
