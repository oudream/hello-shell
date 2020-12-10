
# host
# hosts所在文件夹：
# Windows 系统hosts位于 C:\Windows\System32\drivers\etc\hosts
# Android（安卓）系统hosts位于 /etc/hosts
# macos（苹果电脑）系统hosts位于 /etc/hosts
# iPhone（iOS）系统hosts位于 /etc/hosts
# Linux系统hosts位于 /etc/hosts
# 绝大多数Unix系统都是在 /etc/hosts

# 修改hosts后生效方法：
# Windows
# 开始 -> 运行 -> 输入cmd -> 在CMD窗口输入
# 清除DNS缓存内容。
ipconfig /flushdns
# 显示DNS缓存内容
ipconfig /displaydns

# Linux
# 终端输入
sudo rcnscd restart
# 对于systemd发行版，请使用命令
sudo systemctl restart NetworkManager

# macos X终端输入
sudo killall -HUP mDNSResponder
# Android

# 开启飞行模式 -> 关闭飞行模式
# 通用方法
# 拔网线(断网) -> 插网线(重新连接网络)
# 如不行请清空浏览器缓存（老D建议不要使用国产浏览器，请使用谷歌Chrome浏览器）

