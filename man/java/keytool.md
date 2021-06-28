
### 生成签名证书
```shell
keytool -genkey -alias testalias -keyalg RSA -keysize 2048 -validity 36500 -keystore test.keystore
```

### 可以使用以下命令查看：
```shell
keytool -list -v -keystore test.keystore 
```

