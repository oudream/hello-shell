
### Syncthing 的特点包括去中心化、加密通信、跨平台支持和版本历史记录等
- https://github.com/syncthing/syncthing
### GUI
- https://docs.syncthing.net/users/contrib.html#gui-wrappers
### Windows tray utility / filesystem watcher / launcher for Syncthing
- https://github.com/canton7/SyncTrayzor

### windows rsync, DeltaCopy For rsync(Borland C++ Builder 2006 (BDS))
- https://www.itefix.net/cwrsync
- https://github.com/oudream/DeltaCopy
- http://www.aboutmyip.com/AboutMyXApp/DisplayFAQ.do?fid=6

### rsync, 官网
- https://rsync.samba.org/download.html
- https://github.com/WayneD/rsync

### Go rsync implementation
- https://github.com/gokrazy/rsync


rsync -av --delete --exclude='deploy/amd64/hy3-*' -e 'ssh -p 5022' /opt/dev/device_communicator/ root@yun4:/opt/dev/device_communicator

# rsync 默认使用 SSH 进行远程登录和数据传输。

# 本机使用 rsync 命令时，可以作为cp和mv命令的替代方法，将源目录同步到目标目录。
rsync -r source destination
rsync -r source1 source2 destination

# 将本地内容，同步到远程服务器。
rsync -av source/ username@remote_host:destination
# 将远程内容同步到本地。
rsync -av username@remote_host:source/ destination

### install setup
# Debian
sudo apt-get install rsync
# Red Hat
sudo yum install rsync
# Arch Linux
sudo pacman -S rsync

