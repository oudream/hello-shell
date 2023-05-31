
# https://doc.qt.io/qt-5/linux.html

# Debian/Ubuntu (apt-get)
sudo apt-get install build-essential libgl1-mesa-dev

# Fedora/RHEL/CentOS (yum)
sudo yum groupinstall "C Development Tools and Libraries"
sudo yum install mesa-libGL-devel

#### qt5.14.2
wget https://download.qt.io/archive/qt/5.14/5.14.2/qt-opensource-linux-x64-5.14.2.run
chmod +x qt-opensource-linux-x64-5.14.2.run
./qt-opensource-linux-x64-5.14.2.run

# CentOS 7上升级/安装gcc
yum install -y centos-release-scl
yum install -y devtoolset-8 devtoolset-9 devtoolset-10

cat > /opt/qtcreate.sh <<EOF
#!/usr/bin/env bash
scl enable devtoolset-9 bash
/opt/qt5.14.2/Tools/QtCreator/bin/qtcreator.sh
EOF
chmod +x /opt/qtcreate.sh

# scl -l
scl enable devtoolset-9 bash
/opt/qt5.14.2/Tools/QtCreator/bin/qtcreator.sh
