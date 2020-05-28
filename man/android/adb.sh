#!/usr/bin/env bash

https://developer.android.com/studio/command-line/adb


# adb 命令在 $android_sdk/platform-tools/
# macos osx
/Users/oudream/Library/Android/sdk/platform-tools/


# 要在通过 USB 连接的设备上使用 adb，您必须在设备的系统设置中启用 USB 调试（位于开发者选项下）。
# 在搭载 Android 4.2 及更高版本的设备上，“开发者选项”屏幕默认情况下处于隐藏状态。如需将其显示出来，
# 请依次转到设置 > 关于手机，然后点按版本号七次。返回上一屏幕，在底部可以找到开发者选项。
adb devices -l


# 一般情况下，adb 通过 USB 与设备进行通信，但您也可以在通过 USB 完成一些初始设置后通过 WLAN 使用 adb
# 通过 IP 地址连接到设备。
adb connect device_ip_address
# 确认主机已连接到目标设备：
adb devices
#List of devices attached
#    device_ip_address:5555 device


# 重置 adb 主机：
adb kill-server
adb start-server


# 设置目标设备以监听端口 5555 上的 TCP/IP 连接。
adb tcpip 5555


# 设置主机端口 6100 到设备端口 7100 的转发
# 将对特定主机端口上的请求转发到设备上的其他端口
adb forward tcp:6100 tcp:7100

# 设置主机端口 6100 到 local:logd 的转发：
adb forward tcp:6100 local:logd


# 在该设备上安装 helloWorld.apk
adb -s emulator-5555 install helloWorld.apk



# 要从设备中复制某个文件或目录（及其子目录），请使用以下命令：
adb pull remote local
# 将某个文件或目录（及其子目录）复制到某个设备，请使用以下命令：
adb push local remote
# 将 local 和 remote 替换为开发计算机（本地）和设备（远程）上的目标文件/目录的路径。例如：
adb push foo.txt /sdcard/foo.txt



# 您可以在开发机远程手机上shell
# 发出单个命令，请使用如下 shell 命令：
adb [-d |-e | -s serial_number] shell shell_command

# 进入设备上的远程 shell：
adb [-d | -e | -s serial_number] shell

-d	# 将 adb 命令发送至唯一连接的 USB 设备。如果连接了多个 USB 设备，则返回错误。
-e	# 将 adb 命令发送至唯一运行的模拟器。如果有多个模拟器在运行，则返回错误。
-s serial_number	# 将 adb 命令发送至以其 adb 分配的序列号命名的特定设备（如“emulator-5556”）。替换存储在 $ANDROID_SERIAL 环境变量中的序列号值。请参阅将命令发送至特定设备。
