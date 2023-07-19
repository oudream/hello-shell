
### macbook pro 关机后随便按键盘就开机了，有办法把这功能取消吗？
### 这个是新Mac的功能叫做自动启动，开启屏幕上盖启动，连接交流电源时启动，按键盘任意键启动，可以通过终端来关闭这个功能，
# 终端的位置：应用程序--实用工具--终端，停用自动启动 sudo nvram AutoBoot=%00   开启自动启动 sudo nvram AutoBoot=%03
sudo nvram AutoBoot=%00

