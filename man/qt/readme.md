
### linux qt
- https://download.qt.io/new_archive/qt/5.5/5.5.1/

### deploy qt linux deploy qt [linuxdeployqt]
- https://blog.csdn.net/pengrui18/article/details/106903186
- https://github.com/probonopd/linuxdeployqt
- https://www.cnblogs.com/linuxAndMcu/p/11016322.html

### centos deploy
- https://blog.csdn.net/weixin_39713646/article/details/95607808
- https://www.thinbug.com/q/45351763
- https://blog.csdn.net/wlwlwlwl015/article/details/51482065
- https://blog.csdn.net/sksukai/article/details/107325930
- https://www.cnblogs.com/kinglxg/p/14182640.html
- https://blog.csdn.net/pengrui18/article/details/106903186
- https://www.cnblogs.com/jasonxiaoqinde/p/11696960.html  
```shell
ldd untitled2
#-rw-r--r--.  1 root root   281984 10月 28 20:28 libfontconfig.so.1
#-rwxr-xr-x.  1 root root 25048256 10月 28 20:11 libicudata.so.56
#-rwxr-xr-x.  1 root root  3368288 10月 28 20:11 libicui18n.so.56
#-rwxr-xr-x.  1 root root  2069136 10月 28 20:11 libicuuc.so.56
#-rwxr-xr-x.  1 root root  6945448 10月 28 19:55 libQt5Core.so.5
#-rwxr-xr-x.  1 root root   756888 10月 28 20:29 libQt5DBus.so.5
#-rwxr-xr-x.  1 root root  8668192 10月 28 19:55 libQt5Gui.so.5
#-rwxr-xr-x.  1 root root  8085232 10月 28 19:55 libQt5Widgets.so.5
#-rwxr-xr-x.  1 root root  2006008 10月 28 20:24 libQt5XcbQpa.so.5
#-rw-r--r--.  1 root root   256424 10月 28 20:28 libxkbcommon.so.0
#-rw-r--r--.  1 root root    31528 10月 28 20:28 libxkbcommon-x11.so.0
#drwxr-xr-x. 32 root root     4096 10月 28 21:15 plugins
#-rwxr-xr-x.  1 root root    28368 10月 28 21:27 untitled2
```
```shell
# X11
yum install -y xorg-x11-xauth                 
yum install mesa-libGL
yum -y install fontconfig
# 安装中文字库
yum -y install wqy-zenhei-fonts*       
export QT_QPA_PLATFORM_PLUGIN_PATH=/opt/tmp2/plugins
export LD_LIBRARY_PATH=$PWD
export QT_DEBUG_PLUGINS=1
./untitled2
QT_QPA_PLATFORM_PLUGIN_PATH=/opt/tmp2/plugins LD_LIBRARY_PATH=$PWD ./untitled2
QT_QPA_PLATFORM_PLUGIN_PATH=/opt/tmp2/plugins LD_LIBRARY_PATH=$PWD QT_DEBUG_PLUGINS=1 ./untitled2
```
- error
```shell
libGL error: unable to load driver: swrast_dri.so
libGL error: failed to load driver: swrast
```