
# https://trac.ffmpeg.org/wiki/ffserver
# https://github.com/fhunleth/ffmpeg/blob/master/doc/ffserver.conf
# https://www.jianshu.com/p/b8787ef471ab
# http://da.dadaaierer.com/?p=639
# https://blog.csdn.net/ai2000ai/article/details/81477378
# 下载
# https://ffbinaries.com/downloads


# ffserver.conf              # conf根节点配置说明了服务器为本地
#    Port 8090               # 服务端口为8090
#    BindAddress 0.0.0.0
#    MaxHTTPConnections 2000 # http最大连接数
#    MaxClients 1000         # 最大client数
#    MaxBandwidth 30000      # 最大带宽
#    CustomLog -             # 使用原始log模式
#    NoDaemon                # 非Daemon模式
#                            # Stream节点为广播内部
#    <Stream test.mp3>
#    File "~/test.mp3"       # File标识本地文件地址，文件名为test.mp3
#    Format mp2              # 文件格式为mp2
#    NoVideo                 # 不含有视频                    
#    </Stream>

# 必须先启动ffserver，然后再启动FFmpeg，否则会找不到数据流源运行失败。
sudo ffserver -f ffserver.conf

open http://localhost:8090/test.mp3

#    Port 8090
#    BindAddress 0.0.0.0
#    MaxHTTPConnections 2000
#    MaxClients 1000
#    MaxBandwidth 30000
#    CustomLog -
#    NoDaemon
#
#    <Feed 1.ffm>
#    </Feed>
#
#    <Stream audioonline.wav>
#    Feed 1.ffm
#    NoVideo
#    </Stream>

sudo ffserver -f ffserver.conf
ffmpeg -f avfoundation -i :0 http://localhost:8090/1.ffm
