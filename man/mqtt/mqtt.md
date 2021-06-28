### download
- https://mosquitto.org/download/
- https://mosquitto.org/files/binary/win64/mosquitto-2.0.11-install-windows-x64.exe

### org
- https://mosquitto.org/
- https://github.com/eclipse/mosquitto
- https://mosquitto.org/man/mosquitto_ctrl-1.html

### setting
```shell
#设置不允许匿名登录
allow_anonymous false
#设置账户密码文件位置为C:\MosquittoTest\pwfile.example
password_file /MosquittoTest/pwfile.example
```

### user, password
```shell
mosquitto_passwd /MosquittoTest/pwfile.example dissun
# 111111
```

### 订阅消息
```
mosquitto_sub -u dissun -P 111111 -t 'dissun/topic' -v
```

### 发布消息
```
mosquitto_pub -u dissun -P 111111 -t 'dissun/topic' -m '腰疼不加班'
```

