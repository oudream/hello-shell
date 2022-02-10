
### 安装patchelf和linuxdeployqt
apt install patchelf
# https://github.com/probonopd/linuxdeployqt
# https://github.com/probonopd/linuxdeployqt/releases
# linuxdeployqt在github上下release就行。下载后复制到/usr/bin/下并ln -s创建软连接
#
# new
#  wget https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage
#  mv linuxdeployqt-continuous-x86_64.AppImage linuxdeployqt
wget https://github.com/probonopd/linuxdeployqt/releases/download/7/linuxdeployqt-7-x86_64.AppImage
mv linuxdeployqt-7-x86_64.AppImage linuxdeployqt
chmod +x linuxdeployqt
mv linuxdeployqt /usr/bin/

#add QT ENV
export PATH=/opt/qt5.9.9/5.9.9/gcc_64/bin:$PATH
export LD_LIBRARY_PATH=/opt/qt5.9.9/5.9.9/gcc_64/lib:$LD_LIBRARY_PATH
export QT_PLUGIN_PATH=/opt/qt5.9.9/5.9.9/gcc_64/plugins:$QT_PLUGIN_PATH
export QML2_IMPORT_PATH=/opt/qt5.9.9/5.9.9/gcc_64/qml:$QML2_IMPORT_PATH

cd app-dir
linuxdeployqt ./app -appimage

vim runApp.sh

#!/bin/bash
export LD_LIBRARY_PATH=/opt/bjht_ops/lib:$LD_LIBRARY_PATH
export QT_PLUGIN_PATH=/opt/bjht_ops/plugins:$QT_PLUGIN_PATH
export QML2_IMPORT_PATH=/opt/bjht_ops/qml:$QML2_IMPORT_PATH
cd /opt/bjht_ops
./bjht_ops