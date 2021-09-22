

ffplay rtsp://admin:tk123456@192.168.91.120:554/h264/ch1/main/av_stream


# 1) 播放 test.mp4 ，播放完成后自动退出
ffplay -autoexit test.mp4
# 2) 以 320 x 240 的大小播放 test.mp4
ffplay -x 320 -y 240 test.mp4
# 3) 将窗口标题设置为 "myplayer"，循环播放 2 次
ffplay -window_title myplayer -loop 2 test.mp4
# 4) 以s16le格式播放 双通道 32K 的 PCM 音频数据
ffplay -f s16le -ar 32000 -ac 2 test.pcm

# 播放时失败，网路抓包显示RTSP服务器不支持UDP方式
ffplay rtsp://[username]:[password]@[ip]:[port]/path
#   由于ffplay默认采用UDP连接RTSP流且不会自动切换为TCP，故此时需要强制指定ffplay使用TCP方式，用法如下：
ffplay -rtsp_transport tcp  rtsp://[username]:[password]@[ip]:[port]/path
