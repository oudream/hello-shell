
### update libstdc++.so
# https://blog.csdn.net/weixin_43976122/article/details/108053736?utm_source=app&app_version=4.17.0
### compile gcc
wget https://ftp.gnu.org/gnu/gcc/gcc-7.5.0/gcc-7.5.0.tar.gz
# wget https://ftp.gnu.org/gnu/gcc/gcc-10.2.0/gcc-10.2.0.tar.gz
tar  xf  gcc-7.5.0.tar.gz && cd gcc-7.5.0
./contrib/download_prerequisites
mkdir gcc-7.5-build && cd gcc-7.5-build
../gcc-7.5.0/configure -enable-checking=release  -enable-languages=c,c++  -disable-multilib
make -j 4
make install

#
strings /usr/lib64/libstdc++.so.6 | grep GLIBC
find / -name "libstdc++.so*"
cd /usr/lib64/
cp /root/gcc-7.5.0/gcc-build-7.5.0/stage1-x86_64-pc-linux-gnu/libstdc++-v3/src/.libs/libstdc++.so.6.0.24  ./
mv libstdc++.so.6   libstdc++.so.6.bak
ln -s libstdc++.so.6.0.24   libstdc++.so.6

# cmake
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -static-libstdc++")
