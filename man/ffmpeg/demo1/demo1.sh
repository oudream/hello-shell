
# https://trac.ffmpeg.org/wiki/ffserver
# https://github.com/fhunleth/ffmpeg/blob/master/doc/ffserver.conf


# run your ffserver in debug mode with "-d"
ffserver -d -f ffserver.conf

# feed
./ffmpeg -i rtsp://admin:tk123456@192.168.91.120:554/h264/ch1/main/av_stream -vcodec copy http://localhost:8090/1.ffm

open http://192.168.91.221:8090/stat.html

# 输出成文件 采集1200秒
./ffmpeg -i rtsp://admin:tk123456@192.168.91.120:554/h264/ch1/main/av_stream -t 1200 -vcodec copy rtsp2mp4.mp4


ffmpeg -i rtsp://admin:12345@10.31.16.210/h264/ch1/sub/av_stream -f mpegts -codec:v mpeg1video -s 352x288 -b:v 1000k -bf 0 http://localhost:8081/supersecret
