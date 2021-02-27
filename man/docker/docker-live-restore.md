## 如何优雅的重启 dockerd ？
- 生产环境 dockerd 内存泄漏？想重启 dockerd 又怕重启容器，影响到线上业务？
- 别怕！用 `docker live-restore`, 在重启 dockerd 时，不会重启容器。

#### 1. 配置 docker daemon 参数，编辑文件 /etc/docker/daemon.json，添加如下配置
```
{ "live-restore": true }
```

#### 2. dockerd reload 配置(不会重启 dockerd，修改配置真好用)
```
kill -SIGHUP $(pidof dockerd) # 给 dockerd 发送 SIGHUP 信号，dockerd 收到信号后会 reload 配置
```

#### 3. 检查是否配置成功
```
docker info | grep -i live
# 应该能看到 Live Restore Enabled: true
```

#### 4. 重启 docker，此时重启 docker 不会重启容器
```
systemctl restart docker
```

##### 实在是好用，dockerd 有啥问题都可以重启，不用担心重启 dockerd 会影响现有业务了。比如：
- 1. 升级 docker 版本
- 2. dockerd 内存泄漏。 docker 17.06 之前容易出现这个问题，再也不怕 dockerd 吃掉所有内存又不敢重启了～
- docker 可以不重启 reload 配置，使用 SIGHUP 信号，就像 nginx -s reload，挺好用的。

#### 补充：
- 如果有容器挂载了 docker.sock 文件，重启后工作可能会不正常，需要重启该容器。原因是重启 dockerd 后 docker.sock 文件的 inode 变了， 
- 详情可参考 [docker 单文件挂载的坑](https://yuansmin.github.io/2019/docker-mount-single-file/)
- 参考：docker 文档 https://docs.docker.com/config/containers/live-restore/
