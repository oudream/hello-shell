
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


### hello
- OpenPose: Real-time multi-person keypoint detection library for body, face, hands, and foot estimation
- https://github.com/JimmyHHua/opencv_tutorials/blob/master/README_CN.md
- https://github.com/CMU-Perceptual-Computing-Lab/openpose
- https://github.com/spmallick/learnopencv
- https://github.com/makelove/OpenCV-Python-Tutorial
- https://docs.opencv.org/4.5.5/d6/d00/tutorial_py_root.html
- https://docs.opencv.org/4.5.5/d9/df8/tutorial_root.html


### qt
- OpenCV人脸识别系统开发(三）：QT图形界面开发
- https://www.guyuehome.com/43274
- https://www.youtube.com/watch?v=S-gVIhUAC04
- https://github.com/andywang0607/AutoAnnotationTool