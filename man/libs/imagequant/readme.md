

### install
- git clone https://github.com/ImageOptim/libimagequant.git
```shell script
# 編譯so庫，並安裝
cd libimagequant
./configure --prefix=/usr
make libimagequant.so
make install
ldconfig -v
``` 
```shell script
[root@localhost libimagequant]# make install
gcc -fno-math-errno -funroll-loops -fomit-frame-pointer -Wall -std=c99 -I. -O3 -DNDEBUG -DUSE_SSE=1 -msse -mfpmath=sse -Wno-unknown-pragmas -fexcess-precision=fast   -c -o pam.o pam.c
gcc -fno-math-errno -funroll-loops -fomit-frame-pointer -Wall -std=c99 -I. -O3 -DNDEBUG -DUSE_SSE=1 -msse -mfpmath=sse -Wno-unknown-pragmas -fexcess-precision=fast   -c -o mediancut.o mediancut.c
gcc -fno-math-errno -funroll-loops -fomit-frame-pointer -Wall -std=c99 -I. -O3 -DNDEBUG -DUSE_SSE=1 -msse -mfpmath=sse -Wno-unknown-pragmas -fexcess-precision=fast   -c -o blur.o blur.c
gcc -fno-math-errno -funroll-loops -fomit-frame-pointer -Wall -std=c99 -I. -O3 -DNDEBUG -DUSE_SSE=1 -msse -mfpmath=sse -Wno-unknown-pragmas -fexcess-precision=fast   -c -o mempool.o mempool.c
gcc -fno-math-errno -funroll-loops -fomit-frame-pointer -Wall -std=c99 -I. -O3 -DNDEBUG -DUSE_SSE=1 -msse -mfpmath=sse -Wno-unknown-pragmas -fexcess-precision=fast   -c -o kmeans.o kmeans.c
gcc -fno-math-errno -funroll-loops -fomit-frame-pointer -Wall -std=c99 -I. -O3 -DNDEBUG -DUSE_SSE=1 -msse -mfpmath=sse -Wno-unknown-pragmas -fexcess-precision=fast   -c -o nearest.o nearest.c
gcc -fno-math-errno -funroll-loops -fomit-frame-pointer -Wall -std=c99 -I. -O3 -DNDEBUG -DUSE_SSE=1 -msse -mfpmath=sse -Wno-unknown-pragmas -fexcess-precision=fast   -c -o libimagequant.o libimagequant.c
ar rv libimagequant.a pam.o mediancut.o blur.o mempool.o kmeans.o nearest.o libimagequant.o
ar: creating libimagequant.a
a - pam.o
a - mediancut.o
a - blur.o
a - mempool.o
a - kmeans.o
a - nearest.o
a - libimagequant.o
sed 's|PREFIX|/usr|;s|VERSION|2.12.6|' < imagequant.pc.in > imagequant.pc
install -d /usr/lib
install -d /usr/lib/pkgconfig
install -d /usr/include
install -m 644 libimagequant.a /usr/lib/libimagequant.a
install -m 644 libimagequant.so.0 /usr/lib/libimagequant.so.0
ln -sf libimagequant.so.0 /usr/lib/libimagequant.so
install -m 644 imagequant.pc /usr/lib/pkgconfig/imagequant.pc
install -m 644 libimagequant.h /usr/include/libimagequant.h

```