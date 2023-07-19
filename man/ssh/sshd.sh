
# 手册
# https://man.openbsd.org/sshd_config

# 服务端获取支持算法列表
sshd -T | grep kex

# 客户端获取支持算法列表
ssh -Q kex

# 这个搞了几天才得这两行
# 这个搞了几天才得这两行
Ciphers +3des-cbc,aes128-cbc
KexAlgorithms +diffie-hellman-group1-sha1
# KexAlgorithms curve25519-sha256,curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512,diffie-hellman-group-exchange-sha1,diffie-hellman-group14-sha256,diffie-hellman-group14-sha1,diffie-hellman-group1-sha1

# 在 SSH 中，Ciphers 和 KexAlgorithms 这两个配置选项分别用于指定支持的对称加密算法和密钥交换算法。
  #
  #Ciphers（对称加密算法）：
  #
  #对称加密算法用于对传输的数据进行加密和解密。
  #Ciphers 行允许你指定一组支持的对称加密算法，以便在 SSH 会话中使用。
  #在这个选项中，你可以列出多个对称加密算法，以空格分隔。SSH 客户端和服务器会根据其在列表中的优先级选择一个共同支持的算法。
  #例如，Ciphers aes128-cbc, aes256-cbc 表示支持 AES-128 和 AES-256 算法。
  #
  #KexAlgorithms（密钥交换算法）（共享密钥）：
  #
  #密钥交换算法用于在 SSH 连接建立时协商出一个共享密钥。
  #KexAlgorithms 行允许你指定一组支持的密钥交换算法，以便在 SSH 连接建立过程中使用。
  #在这个选项中，你可以列出多个密钥交换算法，以空格分隔。SSH 客户端和服务器会根据其在列表中的优先级选择一个共同支持的算法。
  #例如，KexAlgorithms diffie-hellman-group-exchange-sha256, ecdh-sha2-nistp256 表示支持 Diffie-Hellman Group Exchange 和 ECDH（椭圆曲线 Diffie-Hellman）算法。
  #这些配置选项允许你根据需求和安全性要求来定义所支持的加密算法和密钥交换算法。通过设置适当的算法列表，可以平衡安全性和性能，并确保 SSH 连接使用强大和适当的加密和密钥交换机制。

# KexAlgorithms（密钥交换算法）（共享密钥）共享密钥确实用于 Ciphers 算法中。
  #
  #在 SSH 连接建立过程中，客户端和服务器使用密钥交换算法协商出一个共享密钥。这个共享密钥是一个随机生成的密钥，用于对称加密算法的加密和解密过程。而 Ciphers 算法列表定义了可供选择的对称加密算法。
  #
  #当 SSH 连接建立后，数据传输过程中使用共享密钥通过所选的对称加密算法进行加密和解密。这些算法包括在 Ciphers 算法列表中指定的算法。
  #
  #因此，共享密钥用于实际的数据加密和解密，而 Ciphers 算法列表则定义了可供选择的对称加密算法，决定了在 SSH 会话中使用哪种加密算法来操作共享密钥对数据进行加密和解密。


### 交叉编译 openssh
# https://blog.csdn.net/feitingfj/article/details/106928234
# https://git.centos.org/rpms/openssh/blob/c7/f/SPECS/openssh.spec
wget https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-7.4p1.tar.gz
tar zxvf openssh-7.4p1.tar.gz
cd openssh-7.4p1
#
CC=/opt/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-gcc CXX=/opt/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-g++ \
./configure --host=aarch64-linux-gnu --with-zlib=/opt/dev/3rd/zlib_install --with-ssl-dir=/opt/dev/3rd/openssl_install --disable-etc-default-login LDFLAGS="-static -pthread"

# ssh-copy-id
tar cvf ssh.new.bin.tar scp sftp ssh ssh-add ssh-agent ssh-keygen ssh-keyscan
tar cvf ssh.new.sbin.tar sshd
tar cvf ssh.new.libexec.tar ssh-keysign ssh-pkcs11-helper sftp-server
