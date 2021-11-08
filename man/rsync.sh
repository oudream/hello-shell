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

