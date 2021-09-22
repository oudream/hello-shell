#!/usr/bin/env bash


### Compilation and Installation
# https://wiki.openssl.org/index.php/Compilation_and_Installation
# https://www.openssl.org/docs/man1.1.1/
./config shared
make -j 4

### openssl
# openssl：多用途的命令行工具
# libcrypto：加密算法库
# libssl：加密模块应用库，实现了ssl及tls
# openssl可以实现：秘钥证书管理、对称加密和非对称加密 。
# .key：私有的密钥
# .csr：证书签名请求（证书请求文件），含有公钥信息，certificate signing request的缩写
# .crt：证书文件，certificate的缩写
# .crl：证书吊销列表，Certificate Revocation List的缩写
# .pem：用于导出，导入证书时候的证书的格式，有证书开头，结尾的格式
## 公钥私钥的核心功能
#   加密: 公钥用于对数据进行加密，私钥用于对数据进行解密
#   签名: 私钥用于对数据进行签名，公钥用于对签名进行验证
## 公钥、私钥
openssl genrsa -out private.key 2048                # 生成私钥:
openssl rsa -in private.key -pubout -out public.key # 到出公钥:
## CA
openssl genrsa -out ca.key 2048                                     # 生成私钥:
openssl req -new -key ca.key -out ca.csr                            # 生成证书请求:
openssl x509 -req -days 365 -in ca.csr -signkey ca.key -out ca.crt  # 自签名:
## 颁发证书
openssl genrsa -out client.key 2048                                 # 生成密钥：
openssl req -new -key client.key -out client.csr                    # 生成请求:
# 签发证书:
openssl x509 -req -days 3650 -sha1 -extensions v3_req -CA ca.crt -CAkey ca.key -CAserial ca.srl -CAcreateserial -in client.csr -out client.crt
# 查看公钥
openssl x509 -in client.crt -pubkey
# 验证server证书openssl
openssl verify -CAfile ca.crt client.crt
# 生成pem格式证书有时需要用到pem格式的证书，可以用以下方式合并证书文件（crt）和私钥文件（key）来生成
cat client.crt client.key > client.pem
# 查看证书日期
openssl x509 -in localhost-cert.pem -noout -dates
# notBefore=May 23 06:40:15 2019 GMT
# notAfter=Jun 22 06:40:15 2019 GMT
openssl req -x509 -newkey rsa:2048 -nodes -sha256 -subj '/CN=localhost' \
  -keyout localhost-privkey.pem -out localhost-cert.pem
