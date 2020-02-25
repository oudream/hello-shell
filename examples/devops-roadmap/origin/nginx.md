# Nginx

# 一、简介

官网：http://nginx.org/ 

nginx是一款自由的、开源的、高性能的HTTP服务器和反向代理服务器；同时也是一个IMAP、POP3、SMTP代理服务器；nginx可以作为一个HTTP服务器进行网站的发布处理，另外nginx可以作为反向代理进行负载均衡的实现。



- 反向代理
- 负载均衡



# 二、安装

## 1. 二进制RPM安装

- **以RPM方式安装的配置文件在/etc/nginx/目录下**
- **二进制安装自带的模块**
- **二进制安装(例如YUM)的nginx不支持动态的安装和新加载模块的，新增模块需要重新编译安装了nginx** 

```bash
#To set up the yum repository for RHEL/CentOS, create the file named /etc/yum.repos.d/nginx.repo with the following contents:
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/OS/OSRELEASE/$basearch/
gpgcheck=0
enabled=1
#Replace “OS” with “rhel” or “centos”, depending on the distribution used, and “OSRELEASE” with “6” or “7”, for 6.x or 7.x versions, respectively.

$ bash -c 'cat > /etc/yum.repos.d/nginx.repo <<EOF
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/7/\$basearch/    #'$'符号需要转义
gpgcheck=0
enabled=1
EOF' && \
  yum clean all && \
  yum repolist && \
  yum list nginx --showduplicates | sort -r && \
  yum install -y nginx
```

## 2. 源码编译安装指定模块

### ①安装编译工具

```bash
yum install -y gcc gc++ perl gcc-c++
```

###  ②安装编译必备库

- the [PCRE](http://pcre.org/) library – required by NGINX [Core](https://nginx.org/en/docs/ngx_core_module.html) and [Rewrite](https://nginx.org/en/docs/http/ngx_http_rewrite_module.html) modules and provides support for regular expressions

  - pcre是一个正则库，nginx使用正则进行重写要用到，必须安装

  - pcre库有两个版本：pcre、pcre2(新版的库)。推荐下载pcre，pcre2是编译是通不过的。

  - 编译pcre就必须用到c++编译器，使用pcre2就使用gcc编译器。

  ```bash
  # yum安装
  $ rpm -qa pcre pcre-devel
  $ yum install pcre pcre-devel
  
  # 源码编译安装
  $ version=8.43 && \
    wget ftp://ftp.pcre.org/pub/pcre/pcre-$version.tar.gz && \
    tar -zxf pcre-$version.tar.gz&& \
    cd pcre-$version && \
    ./configure && \
    make && \
    make install
  ```

- the [zlib](http://www.zlib.net/) library – required by NGINX [Gzip](https://nginx.org/en/docs/http/ngx_http_gzip_module.html) module for headers compression:

  ```bash
  # yum安装
  $ rpm -qa zlib zlib-devel
  $ yum install zlib zlib-devel
  
  # 源码编译安装
  
  $ version=1.2.11 && \
    wget http://zlib.net/zlib-$version.tar.gz && \
    tar -zxf zlib-$version.tar.gz && \
    cd zlib-$version && \
    ./configure && \
    make && \
    make install
  ```

- the [OpenSSL](https://www.openssl.org/) library – required by NGINX SSL modules to support the HTTPS protocol

  OpenSSL 是一个强大的安全套接字层密码库，囊括主要的密码算法、常用的密钥和证书封装管理功能及 SSL 协议，并提供丰富的应用程序供测试或其它目的使用。nginx 不仅支持 http 协议，还支持 https（即在ssl协议上传输http），所以需要在 Centos 安装 OpenSSL 库 
  
  ```bash
  # yum安装
  $ rpm -qa openssl openssl-devel
  $ yum install openssl openssl-devel
  
  # 源码编译安装
  $ version=1.0.2t && \
    wget http://www.openssl.org/source/openssl-$version.tar.gz && \
    tar -zxf openssl-$version.tar.gz && \
    cd openssl-$version && \
    ./config && \
    make && \
    make install
    
  # 如果是在MacOS下源码编译，配置时手动指定OS平台
  ./Configure darwin64-x86_64-cc && \
  make  && \
  sudo make install
  ```

### ③下载解压Nginx源码包

```bash
$ version=1.17.6 && \
  wget http://nginx.org/download/nginx-$version.tar.gz && \
  tar -zxf nginx-*.tar.gz && \
  cd nginx-$version
```

###  ④配置编译参数 

**创建nginx用户----->创建相关目录------>配置编译参数**

```bash
$ ./configure --help  #查看编译配置参数
--with开头的，默认是禁用的(没启动的，想使用的话需要在编译的时候加上)
--without开头的，默认是启用的(不想启用此模块时，可以在编译的时候加上这个参数)
#  --help                             print this message
#  --prefix=PATH                      指定安装目录
#  --sbin-path=PATH                   指定二进制执行程序文件存放位置。
#  --modules-path=PATH                指定第三方模块的存放路径
#  --conf-path=PATH                   指定配置文件nginx.conf存放位置
#  --error-log-path=PATH              指定错误日志存放位置
#  --pid-path=PATH                    指定nginx.pid文件存放位置
#  --lock-path=PATH                   指定nginx.lock文件存放位置
#  --user=USER                        指定程序运行时的非特权用户
#  --group=GROUP                      指定程序运行时的非特权用户组
#  --build=NAME                       set build name
#  --builddir=DIR                     指定编译目录
#  --with-select_module               enable select module
#  --without-select_module            disable select module
#  --with-poll_module                 enable poll module
#  --without-poll_module              disable poll module
#  --with-threads                     enable thread pool support
#  --with-file-aio                    enable file AIO support
#  --with-http_ssl_module             enable ngx_http_ssl_module
#  --with-http_v2_module              enable ngx_http_v2_module
#  --with-http_realip_module          enable ngx_http_realip_module
#  --with-http_addition_module        enable ngx_http_addition_module
#  --with-http_xslt_module            enable ngx_http_xslt_module
#  --with-http_xslt_module=dynamic    enable dynamic ngx_http_xslt_module
#  --with-http_image_filter_module    enable ngx_http_image_filter_module
#  --with-http_image_filter_module=dynamic    enable dynamic ngx_http_image_filter_module
#  --with-http_geoip_module           enable ngx_http_geoip_module
#  --with-http_geoip_module=dynamic   enable dynamic ngx_http_geoip_module
#  --with-http_sub_module             enable ngx_http_sub_module
#  --with-http_dav_module             enable ngx_http_dav_module
#  --with-http_flv_module             enable ngx_http_flv_module
#  --with-http_mp4_module             enable ngx_http_mp4_module
#  --with-http_gunzip_module          enable ngx_http_gunzip_module
#  --with-http_gzip_static_module     enable ngx_http_gzip_static_module
#  --with-http_auth_request_module    enable ngx_http_auth_request_module
#  --with-http_random_index_module    enable ngx_http_random_index_module
#  --with-http_secure_link_module     enable ngx_http_secure_link_module
#  --with-http_degradation_module     enable ngx_http_degradation_module
#  --with-http_slice_module           enable ngx_http_slice_module
#  --with-http_stub_status_module     enable ngx_http_stub_status_module
#  --without-http_charset_module      disable ngx_http_charset_module
#  --without-http_gzip_module         disable ngx_http_gzip_module
#  --without-http_ssi_module          disable ngx_http_ssi_module
#  --without-http_userid_module       disable ngx_http_userid_module
#  --without-http_access_module       disable ngx_http_access_module
#  --without-http_auth_basic_module   disable ngx_http_auth_basic_module
#  --without-http_autoindex_module    disable ngx_http_autoindex_module
#  --without-http_geo_module          disable ngx_http_geo_module
#  --without-http_map_module          disable ngx_http_map_module
#  --without-http_split_clients_module disable ngx_http_split_clients_module
#  --without-http_referer_module      disable ngx_http_referer_module
#  --without-http_rewrite_module      disable ngx_http_rewrite_module
#  --without-http_proxy_module        disable ngx_http_proxy_module
#  --without-http_fastcgi_module      disable ngx_http_fastcgi_module
#  --without-http_uwsgi_module        disable ngx_http_uwsgi_module
#  --without-http_scgi_module         disable ngx_http_scgi_module
#  --without-http_memcached_module    disable ngx_http_memcached_module
#  --without-http_limit_conn_module   disable ngx_http_limit_conn_module
#  --without-http_limit_req_module    disable ngx_http_limit_req_module
#  --without-http_empty_gif_module    disable ngx_http_empty_gif_module
#  --without-http_browser_module      disable ngx_http_browser_module
#  --without-http_upstream_hash_module   disable ngx_http_upstream_hash_module
#  --without-http_upstream_ip_hash_module  disable ngx_http_upstream_ip_hash_module
#  --without-http_upstream_least_conn_module  disable ngx_http_upstream_least_conn_module
#  --without-http_upstream_keepalive_module   disable ngx_http_upstream_keepalive_module
#  --without-http_upstream_zone_module      disable ngx_http_upstream_zone_module
#  --with-http_perl_module            enable ngx_http_perl_module
#  --with-http_perl_module=dynamic    enable dynamic ngx_http_perl_module
#  --with-perl_modules_path=PATH      set Perl modules path
#  --with-perl=PATH                   set perl binary pathname
#  --http-log-path=PATH               set http access log pathname
#  --http-client-body-temp-path=PATH  set path to store http client request body temporary files
#  --http-proxy-temp-path=PATH        set path to store http proxy temporary files
#  --http-fastcgi-temp-path=PATH      set path to store http fastcgi temporary files
#  --http-uwsgi-temp-path=PATH        set path to store http uwsgi temporary files
#  --http-scgi-temp-path=PATH         set path to store http scgi temporary files
#  --without-http                     disable HTTP server
#  --without-http-cache               disable HTTP cache
#  --with-mail                        enable POP3/IMAP4/SMTP proxy module
#  --with-mail=dynamic                enable dynamic POP3/IMAP4/SMTP proxy module
#  --with-mail_ssl_module             enable ngx_mail_ssl_module
#  --without-mail_pop3_module         disable ngx_mail_pop3_module
#  --without-mail_imap_module         disable ngx_mail_imap_module
#  --without-mail_smtp_module         disable ngx_mail_smtp_module
#  --with-stream                      enable TCP/UDP proxy module
#  --with-stream=dynamic              enable dynamic TCP/UDP proxy module
#  --with-stream_ssl_module           enable ngx_stream_ssl_module
#  --with-stream_realip_module        enable ngx_stream_realip_module
#  --with-stream_geoip_module         enable ngx_stream_geoip_module
#  --with-stream_geoip_module=dynamic enable dynamic ngx_stream_geoip_module
#  --with-stream_ssl_preread_module   enable ngx_stream_ssl_preread_module
#  --without-stream_limit_conn_module disable ngx_stream_limit_conn_module
#  --without-stream_access_module     disable ngx_stream_access_module
#  --without-stream_geo_module        disable ngx_stream_geo_module
#  --without-stream_map_module        disable ngx_stream_map_module
#  --without-stream_split_clients_module   disable ngx_stream_split_clients_module
#  --without-stream_return_module     disable ngx_stream_return_module
#  --without-stream_upstream_hash_module   disable ngx_stream_upstream_hash_module
#  --without-stream_upstream_least_conn_module   disable ngx_stream_upstream_least_conn_module
#  --without-stream_upstream_zone_module  disable ngx_stream_upstream_zone_module
#  --with-google_perftools_module     enable ngx_google_perftools_module
#  --with-cpp_test_module             enable ngx_cpp_test_module
#  --add-module=PATH                  enable external module
#  --add-dynamic-module=PATH          enable dynamic external module
#  --with-compat                      dynamic modules compatibility
#  --with-cc=PATH                     set C compiler pathname
#  --with-cpp=PATH                    set C preprocessor pathname
#  --with-cc-opt=OPTIONS              set additional C compiler options
#  --with-ld-opt=OPTIONS              set additional linker options
#  --with-cpu-opt=CPU                 build for the specified CPU, valid values:pentium, pentiumpro, pentium3, pentium4,athlon, opteron, sparc32, sparc64, ppc64
#  --without-pcre                     disable PCRE library usage
#  --with-pcre                        force PCRE library usage
#  --with-pcre=DIR                    设置pcre源码目录路径
#  --with-pcre-opt=OPTIONS            set additional build options for PCRE
#  --with-pcre-jit                    build PCRE with JIT compilation support
#  --with-zlib=DIR                    set path to zlib library sources
#  --with-zlib-opt=OPTIONS            set additional build options for zlib
#  --with-zlib-asm=CPU                use zlib assembler sources optimized for the specified CPU, valid values:pentium, pentiumpro
#  --with-libatomic                   force libatomic_ops library usage
#  --with-libatomic=DIR               set path to libatomic_ops library sources
#  --with-openssl=DIR                 set path to OpenSSL library sources
#  --with-openssl-opt=OPTIONS         set additional build options for OpenSSL
#  --with-debug                       enable debug logging

$ groupadd nginx && \
  useradd nginx -s /sbin/nologin -M -g nginx && \
  mkdir -p /opt/nginx-1.17.6/logs

$ ./configure \
--prefix=/opt/nginx-1.17.6 \
--user=nginx \
--group=nginx \
--sbin-path=/opt/nginx-1.17.6/nginx \
--error-log-path=/opt/nginx-1.17.6/logs/error.log \
--conf-path=/opt/nginx-1.17.6/nginx.conf \
--pid-path=/opt/nginx-1.17.6/nginx.pid \
--with-pcre \
--with-openssl=/usr/lib64/openssl \
--with-http_stub_status_module
```

### ⑤编译安装

```bash
# make命令将源代码编译为二进制文件
$ make
# 根据配置阶段指定的路径和功能将软件以特定的方式安装到指定位置
$ make install
```

### ⑥设置环境变量

```bash
ln -s /opt/nginx-1.17.6/nginx /usr/bin/nginx
```

## 3.  启动 

手动控制Nginx的生命周期

```bash
$ nginx -t  #启动测试
$ nginx     #启动
```

托管给Systemd

```bash
$ bash -c 'cat > /usr/lib/systemd/system/nginx.service << EOF 
[Unit]
Description=The nginx HTTP and reverse proxy server
After=syslog.target network.target remote-fs.target nss-lookup.target
[Service]
Type=forking
PIDFile=/opt/nginx-1.17.6/nginx.pid
ExecStartPre=/opt/nginx-1.17.6/nginx -t
ExecStart=/opt/nginx-1.17.6/nginx
ExecReload=/bin/kill -s HUP /opt/nginx-1.17.6/nginx.pid
ExecStop=/bin/kill -s QUIT /opt/nginx-1.17.6/nginx.pid
PrivateTmp=true
[Install]
WantedBy=multi-user.target
EOF' && \
  systemctl daemon-reload && \
  systemctl enable nginx.service && \
  systemctl start nginx.service
```

## 4. 验证

```bash
# 查看监听的端口
$ lsof -i :80
$ netstat -lanp |grep 80
# 使用命令行工具访问页面
$ curl 127.0.0.1
$ wget 127.0.0.1
# 查看进程
$ ps -ef | grep nginx
# root 2564 1  0 23:21 ? 00:00:00 nginx: master process /opt/nginx-1.17.6/nginx
# nginx 2565 2564 0 23:21 ? 00:00:00 nginx: worker process
```

![image-20191126222009962](../assets/nginx-1.png)



# 三、Nginx目录结构

 编译安装的目录结构 

```bash
#由于编译时指定了相关路径
$ tree /opt/nginx-1.17.6
/opt/nginx-1.17.6
├── 3party_module
├── client_body_temp
├── fastcgi.conf
├── fastcgi.conf.default
├── fastcgi_params
├── fastcgi_params.default
├── fastcgi_temp
├── html                                    #站点目录
│   ├── 50x.html                                #错误页
│   └── index.html                            #首页
├── koi-utf
├── koi-win
├── logs                                  #日志目录
│   ├── access.log                        #nginx访问日志
│   └── error.log                         #Nginx的错误日志
├── mime.types                            #媒体类型
├── mime.types.default
├── nginx                                 #Nginx的二进制启动命令脚本
├── nginx.conf                            #Nginx的主要配置文件
├── nginx.conf.default
├── nginx.pid                             #Nginx所有的进程号文件
├── nginx-rtmp-module
├── proxy_temp                            #临时目录
├── scgi_params                
├── scgi_params.default
├── scgi_temp
├── uwsgi_params
├── uwsgi_params.default
├── uwsgi_temp
└── win-utf
```

# 四、命令行参数

```bash
$ nginx -s signal
#Where signal may be one of the following:
#    stop — fast shutdown
#    quit — graceful shutdown
#    reload — 重新加载配置文件
#    reopen — reopening the log files

Nginx重新加载配置文件的过程：主进程接受到加载信号后：
1、首先会校验配置的语法，然后生效新的配置，
2、如果成功，则主进程会启动新的工作进程，同时发送终止信号给旧的工作进程。
3、否则主进程回退配置，继续工作。
在第二步，旧的工作进程收到终止信号后，会停止接收新的连接请求，知道所有现有的请求处理完，然后退出。

$ nginx -t #检查配置文件语法是否错误，并尝试启动
$ nginx -q # suppress non-error messages during configuration testing. 
$ nginx -T # same as -t, but additionally dump configuration files to standard output (1.9.2).
$ nginx    #启动Nginx
$ nginx -v #查看nginx的版本
$ nginx -V #查看nginx的版本，编译器版本，编译时的参数等
$ nginx -p prefix # set nginx path prefix, i.e. a directory that will keep server files (default value is /usr/local/nginx).
$ nginx -c file  # 指定配置文件（不使用默认路径下的配置文件）
$ nginx -? | -h  # print help for command-line parameters.
$ nginx -g directives # set global configuration directives, for example,                            #nginx -g "pid /var/run/nginx.pid; worker_processes `sysctl -n hw.ncpu`;" 
```

# 五、Nginx模块



# 六、示例配置文件





# 七、问题

## 0. Nginx添加模块并不停服升级

不管Nginx是用YUM二进制还是源码编译方式安装的，后续如果有新需求是现有Nginx模块无法满足，需要添加新模块才能完成的情况时，都是要对Nginx进行重新编译安装，然后不停服，不能影响现有的业务地平滑升级 （该操作有风险，需在开发环境测试通过再在生产环境进行操作）

**① 查看现有的nginx编译参数**

```bash
nginx -V
# 或者
/opt/nginx1.17.6/nginx -V
```

**② 备份旧版本的nginx可执行文件** 

期间nginx不会停止服务

```bash
mv /opt/nginx1.17.6/nginx /opt/nginx1.17.6/nginx.bak
```

**③ 安装编译必备组件**

**④ 下载相同版本的nginx源码包**

**⑤ 下载第三方模块**

**⑥ 配置编译参数**

要加上原有的编译参数

**⑦ 编译新的Nginx**

 只make, 不要make install，不然会覆盖原来已安装的nginx

**⑧ 替换Nginx文件**

**⑨ 修改新配置文件， 并检查配置文件语法****

**⑩ 新配置的平滑升级**

```bash
$ kill -USR2 旧Nginx主进程号或进程文件路径
# 此时旧的Nginx主进程将会把自己的进程文件改名为.oldbin，然后执行新版Nginx。新旧Nginx会同时运行，共同处理请求。
这时要逐步停止旧版 Nginx
$ kill -WINCH 旧Nginx主进程号
# 慢慢旧Nginx进程就都会随着任务执行完毕而退出，新的Nginx进程会逐渐取代旧进程。
```

## 1. 启动Nginx时报“nginx: [emerg] getpwnam("nginx") failed”

 **原因**：nginx用户没有创建成功 

## 2. 浏览器，curl、wget等访问不了nginx页面

 **原因**：可能是没有关闭SELinux和防火墙 ，检查一下

## 3. 访问资源403的问题排查

通过yum安装的nginx一切正常，但是访问时报403，于是查看nginx日志，路径为/var/log/nginx/error.log。打开日志发现报错Permission denied，详细报错如下：

```bash
open() "/data/www/1.txt" failed (13: Permission denied), client: 192.168.1.194, server: www.web1.com, request: "GET /1.txt HTTP/1.1", host: "www.web1.com"
```

**原因：**

- 1、由于启动用户和nginx工作用户不一致所致

  查看nginx的启动用户，发现是nobody，而为是用root启动的

  ```bash
  ps aux | grep "nginx: worker process" | awk'{print $1}'
  ```
  
  **解决方案：**将nginx.config中的user改为和启动用户一致

- 2、配置文件中指定的文件

  例如配置文件中index index.html index.htm这行中的指定的文件。

    ```bash
    server {  
       listen 80;  
       server_name localhost;  
       index index.php index.html;  
       root /data/www/;
    }
    ```
   如果在/data/www/下面没有index.php,index.html的时候，直接访问文件会报403 forbidden。
  
   **解决方案：**创建一下相应的文件

- 3、权限问题，如果nginx没有web目录的操作权限，也会出现403错误。
	**解决办法：**修改web目录的读写权限，或者是把nginx的启动用户改成目录的所属用户，重启Nginx即可解决
	
    ```bash
    chmod -R 777 /data/www/
    ```

- 4、SELinux设置为开启状态（enabled）的原因。

  查看SELinux的状态

    ```bash
    $ getenforce
    Enforcing 为开启状态
    ```

    **解决方案：**

    ①临时或永久关闭Selinux
  
    ```bash
    #临时关别Selinux
    setenforce 0
    ```