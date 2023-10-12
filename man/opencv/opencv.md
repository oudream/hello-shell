
### 
git clone https://github.com/opencv/opencv.git
cd opencv
git checkout 5199850 # v4.8.1

### 安装依赖
apt install build-essential libgtk2.0-dev libavcodec-dev libavformat-dev libjpeg-dev libtiff5-dev libswscale-dev

###
cd opencv
mkdir build && cd build
cmake -D CMAKE_BUILD_TYPE=Release -D OPENCV_GENERATE_PKGCONFIG=ON -D CMAKE_INSTALL_PREFIX=/usr/local -DBUILD_TIFF=ON ..

###
make install -j 8