
# ffpeobe查看一个视频的文件
ffprobe ~/a.mp4
# 键入上述命令之后，可以看到第一部分的信息是Metadata信息:
#    Metadata:
#            major_brand: jsom
#            minor_version: 512
#            compatible_brands: isomiso2avc1mp41
#            encoder: Lavf55.12.100
# 这行信息表明了该文件的Metadata信息，比如encoder是Lavf55.12.100，其中Lavf代表的是FFmpeg输出的文件，
# 后面的编号代表了FFmpeg的版本代号，接下来的一行信息如下：
#    Duration: 00:04:34.560 start: 0.023220, bitrate: 577kb/s
# 上面的一行的内容表示Duration是4分34秒560毫秒，开始播放的时间是从23ms开始播放的，整个文件的比特率是577Kbit/s，
# 紧接着再来看下一行：
#    Stream#0:0 (un): Video:h264 (avc1/0x31637661), yuv420p, 480*480, 508kb/s, 24fps
# 这行信息表示第一个stream是视频流，编码方式是H264的格式（封装格式是AVC1），每一帧的数据表示是YUV420P的格式，
# 分辨率是480*480，这路流的比特率是508Kbit/s，帧率是每秒钟24帧，紧接着再来看下一行：
#    Stream#0:1 (und):Audio: aac(LC)(mp4a/0x6134706D), 44100Hz, stereo, fltp, 63kb/s
# 这行信息表示第二个stream是音频流，编码方式是AAC（封装格式是MP4A），并且采用的Profile是LC规格，采样率是44100Hz，
# 声道数是立体声，数据表示格式是浮点型，这路音频流的比特率是63Kbit/s。
#    tbn= the time base in AVStream that has come from the container
#    tbc= the time base in AVCodecContext for the codec used for a particular stream
#    tbr= tbr is guessed from the video stream and is the value users want to see when they look for the video frame rate
#    25  tbr代表帧率；
#    12800 tbn代表文件层（st）的时间精度，即1S=12800，和duration相关；
#    50   tbc代表视频层（st->codec）的时间精度，即1S=50，和strem->duration和时间戳相关。
