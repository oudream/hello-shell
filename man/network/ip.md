
### 修改IP
- debian
```shell
vim /etc/network/interfaces
```

### 查看当前系统上使用的 DNS 服务器：
```shell
cat /etc/resolv.conf
```

### 查询网络接口的 DNS 配置
```shell
nmcli dev show eth0
```
