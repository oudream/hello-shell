#!/usr/bin/env bash

cmake . --build "/opt/ddd/ccpp/ccxx/build/cmake" -B"/opt/ddd/ccpp/ccxx/build/cmake-gcc"
cmake . -DCMAKE_BUILD_TYPE=Debug --build "/opt/ddd/ccpp/gcl3/build/cmake" -B"/opt/ddd/ccpp/gcl3/build/cmake-gcc"
cmake . -DCMAKE_BUILD_TYPE=Debug --build . -B"./cmake-gcc"

cmake . -G "Xcode" --build "/ddd/communication/protobuf/protobuf/cmake" -B"/ddd/communication/protobuf/protobuf/cmake-xcode"
