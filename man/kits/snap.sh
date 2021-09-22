
# 搜索要安装的snap包
sudo snap findl <snap name>

# 查看snap包信息
snap info <snap name>

# 安装一个snap包
sudo snap install <snap name>
sudo snap install --channel=edge <snap name>
sudo snap switch --channel=stable <snap name>

# 查看命令（已安装应用程序可以在$PATH下找到/snap/bin，然后通常添加到$ PATH中，如果直接执行命令不起作用，请尝试使用/ snap / bin路径作为前缀）
# 如果直接执行命令不起作用，请尝试使用/ snap / bin路径作为前缀
/snap/bin/<snap name>

# 列出已经安装的snap包
sudo snap list

# 更新一个snap包，如果后面不加包名则更新所有
sudo snap refresh <snap name>
sudo snap refresh --channel=beta <snap name>

# 还原到以前安装的版本
sudo snap revert <snap name>

# 启用和禁用
sudo snap disable <snap name>
sudo snap enable <snap name>

# 删除snap包
sudo snap remove <snap name>

