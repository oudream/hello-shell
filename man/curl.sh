#!/usr/bin/env bash

# 抓取页面内容到一个文件中,用 -O（大写的）
curl -O http://www.mydomain.com/linux/index.html


# 模拟用户登录
# 此参数相当于设置http头 Authorization:
curl -u user:password http://blog.mydomain.com/login.php
curl --user user:password http://blog.mydomain.com/login.php
# 使用用户名、密码认证，此参数会覆盖“-n”、“--netrc”和“--netrc-optional”选项 -n, --netrc 必须从 .netrc 文件读取用户名和密码
# 第一种 指定用户但不指定密码 每次输入进行rpc通信时需要输入密码
curl --user user --data-binary '{"jsonrpc":"1.0","id":"curltest","method":"getbalance","params":[]}' http://127.0.0.1:18332/
# 第二种 用户名后跟密码 回车后直接通信 ‘’这个符合加不加都可以
curl --user 'user:123456' --data-binary '{"jsonrpc":"1.0","id":"curltest","method":"getbalance","params":[]}' http://127.0.0.1:18332/


# open http://man7.org/linux/man-pages/man1/curl.1.html
# open https://catonmat.net/cookbooks/curl


#  DICT, FILE, FTP, FTPS, GOPHER, HTTP, HTTPS, IMAP, IMAPS, LDAP, LDAPS, POP3, POP3S, RTMP, RTSP,
#  SCP, SFTP, SMB, SMBS, SMTP, SMTPS, TELNET and TFTP


# -b 参数用来向服务器发送 Cookie。
curl -b 'foo=bar' https://google.com
curl -b 'foo1=bar;foo2=bar2' https://google.com
curl -b cookies.txt https://www.google.com # 上面命令读取本地文件cookies.txt，里面是服务器设置的 Cookie（参见-c参数），将其发送到服务器。

# -c 参数将服务器设置的 Cookie 写入一个文件。
curl -c cookies.txt https://www.google.com

# -d 参数用于发送 POST 请求的数据体。
curl -d'login=emma＆password=123'-X POST https://google.com/login
# 或者
# 使用-d参数以后，HTTP 请求会自动加上标头Content-Type : application/x-www-form-urlencoded。并且会自动将请求转为 POST 方法，因此可以省略-X POST。
$ curl -d 'login=emma' -d 'password=123' -X POST  https://google.com/login
# 读取data.txt文件的内容，作为数据体向服务器发送。
curl -d '@data.txt' https://google.com/login

# -F 参数用来向服务器上传二进制文件。
# 会给 HTTP 请求加上标头Content-Type: multipart/form-data，然后将文件photo.png作为file字段上传。
curl -F 'file=@photo.png' https://google.com/profile
curl -F 'file=@photo.png;type=image/png' https://google.com/profile
curl -F 'file=@photo.png;filename=me.png' https://google.com/profile

# -G 参数用来构造 URL 的查询字符串。
curl -G -d 'q=kitties' -d 'count=20' https://google.com/search

# -H 参数添加 HTTP 请求的标头。
curl -H 'Accept-Language: en-US' https://google.com
curl -H 'Accept-Language: en-US' -H 'Secret-Message: xyzzy' https://google.com
curl -H 'Content-Type: application/json' -d '{"login": "emma", "pass": "123"}' https://google.com/login

# -k 参数指定跳过 SSL 检测。
# 不会检查服务器的 SSL 证书是否正确。
curl -k https://www.example.com

# -L 参数会让 HTTP 请求跟随服务器的重定向。curl 默认不跟随重定向。
curl -L -d 'tweet=hi' https://api.twitter.com/tweet

# --limit-rate
# --limit-rate用来限制 HTTP 请求和回应的带宽，模拟慢网速的环境。
# 将带宽限制在每秒 200K 字节。
curl --limit-rate 200k https://google.com

# -o 参数将服务器的回应保存成文件，等同于wget命令。
curl -o example.html https://www.example.com
# -O 参数将服务器回应保存成文件，并将 URL 的最后部分当作文件名。
curl -O https://www.example.com/foo/bar.html

# -s 参数将不输出错误和进度信息。
curl -s https://www.example.com
# 如果想让 curl 不产生任何输出，可以使用下面的命令。
curl -s -o /dev/null https://google.com
# -S 参数指定只输出错误信息，通常与-s一起使用。没有任何输出，除非发生错误。
curl -S -o /dev/null https://google.com

# -u 参数用来设置服务器认证的用户名和密码。
# 设置用户名为bob，密码为12345，然后将其转为 HTTP 标头Authorization: Basic Ym9iOjEyMzQ1。
curl -u 'bob:12345' https://google.com/login

# -v 参数输出通信的整个过程，用于调试。
# --trace 参数也可以用于调试，还会输出原始的二进制数据。

# -x 参数指定 HTTP 请求的代理。
# 指定 HTTP 请求通过myproxy.com:8080的 socks5 代理发出。
# 如果没有指定代理协议，默认为 HTTP。
curl -x socks5://james:cats@myproxy.com:8080 https://www.example.com
curl -x james:cats@myproxy.com:8080 https://www.example.com

# -X 参数指定 HTTP 请求的方法。
curl -X POST https://www.example.com


#    # 调试类
#    -v, --verbose                          输出信息
#    -q, --disable                          在第一个参数位置设置后 .curlrc 的设置直接失效，这个参数会影响到 -K, --config -A, --user-agent -e, --referer
#    -K, --config FILE                      指定配置文件
#    -L, --location                         跟踪重定向 (H)
#
#    # CLI显示设置
#    -s, --silent                           Silent模式。不输出任务内容
#    -S, --show-error                       显示错误. 在选项 -s 中，当 curl 出现错误时将显示
#    -f, --fail                             不显示 连接失败时HTTP错误信息
#    -i, --include                          显示 response的header (H/F)
#    -I, --head                             仅显示 响应文档头
#    -l, --list-only                        只列出FTP目录的名称 (F)
#    -#, --progress-bar                     以进度条 显示传输进度
#
#    # 数据传输类
#    -X, --request [GET|POST|PUT|DELETE|…]  使用指定的 http method 例如 -X POST
#    -H, --header <header>                  设定 request里的header 例如 -H "Content-Type: application/json"
#    -e, --referer                          设定 referer (H)
#    -d, --data <data>                      设定 http body 默认使用 content-type application/x-www-form-urlencoded (H)
#        --data-raw <data>                  ASCII 编码 HTTP POST 数据 (H)
#        --data-binary <data>               binary 编码 HTTP POST 数据 (H)
#        --data-urlencode <data>            url 编码 HTTP POST 数据 (H)
#    -G, --get                              使用 HTTP GET 方法发送 -d 数据 (H)
#    -F, --form <name=string>               模拟 HTTP 表单数据提交 multipart POST (H)
#        --form-string <name=string>        模拟 HTTP 表单数据提交 (H)
#    -u, --user <user:password>             使用帐户，密码 例如 admin:password
#    -b, --cookie <data>                    cookie 文件 (H)
#    -j, --junk-session-cookies             读取文件中但忽略会话cookie (H)
#    -A, --user-agent                       user-agent设置 (H)
#
#    # 传输设置
#    -C, --continue-at OFFSET               断点续转
#    -x, --proxy [PROTOCOL://]HOST[:PORT]   在指定的端口上使用代理
#    -U, --proxy-user USER[:PASSWORD]       代理用户名及密码
#
#    # 文件操作
#    -T, --upload-file <file>               上传文件
#    -a, --append                           添加要上传的文件 (F/SFTP)
#
#    # 输出设置
#    -o, --output <file>                    将输出写入文件，而非 stdout
#    -O, --remote-name                      将输出写入远程文件
#    -D, --dump-header <file>               将头信息写入指定的文件
#    -c, --cookie-jar <file>                操作结束后，要写入 Cookies 的文件位置
