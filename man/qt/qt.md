
### win10 编译 qtbase
```text
D:\Software\JetBrains\CLion2023.3.4\bin\cmake\win\x64\bin\cmake.exe -DCMAKE_BUILD_TYPE=Debug -DCMAKE_MAKE_PROGRAM=D:/Software/JetBrains/CLion2023.3.4/bin/ninja/win/x64/ninja.exe -DQT_FEATURE_system_brotli=OFF  -DQT_BUILD_EXAMPLES=ON -G Ninja -S D:\ct\qtbase -B D:\ct\qtbase\cmake-build-debug 


-DQT_FEATURE_system_brotli=OFF -DQT_BUILD_EXAMPLES=ON

PATH=D:\ct\qtbase\cmake-build-debug\bin\;D:\ct\qtbase\cmake-build-debug\lib\;%Path%;QT_PLUGIN_PATH=D:\ct\qtbase\cmake-build-debug\plugins;QT_QPA_PLATFORM_PLUGIN_PATH=D:\ct\qtbase\cmake-build-debug\plugins\platforms;Path=D:\ct\qtbase\cmake-build-debug\bin

```

### 深入理解 Qt 信号槽：高效沟通的桥梁
- https://developer.aliyun.com/article/1463737
```text

```
