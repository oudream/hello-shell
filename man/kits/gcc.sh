#!/usr/bin/env bash

### gcc
./configure --build=i386-linux --host=arm-linux --target=mipsel-linux --prefix=$(pwd)/_install
export LD_LIBRARY_PATH=/.../bin_d:$LD_LIBRARY_PATH

