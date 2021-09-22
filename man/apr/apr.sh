
# https://blog.csdn.net/a32245aa/article/details/78629487
# centos
yum install -y autoconf libtool
# ubuntu
apt install autoconf libtool-bin

wget   http://apache.etoak.com//apr/apr-1.4.6.tar.gz
wget   http://apache.etoak.com//apr/apr-util-1.4.1.tar.gz

# 3.安装apr
tar  zxvf    apr-1.4.6.tar.gz
cd   apr-1.4.6
./buildconf  # 重要，安装了很多次没有成功就是因为这个
./configure  --prefix=/usr/local/apr/
make
make install

# 4.安装apr-util
tar  zxvf  apr-util-1.4.1.tar.gz
cd   apr-util-1.4.1
./configure  --prefix=/usr/local/apr-util   --with-apr=/usr/loca/apr
make
make install


### 交叉编译
### apr
# https://www.javaroad.cn/questions/87215
# https://blog.csdn.net/m0_37263637/article/details/78590853
./configure --prefix = / usr / arm-linux-gnueabi / apr --host = arm-linux-gnueabi CC ="arm-linux-gnueabi-gcc" CXX="arm-linux-gnueabi-g"


CREATE TABLE `DEVICE_TABLE`
(
    `ID`         		integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    `parent_device_id`     text    default '',
    `node_id`        integer default -1,
    `device_id`         text    default '',
    `token`         text    default '',
    `name`         text    default '',
    `code`         text    default '',
    `description`         text    default '',
    `manufacturer_id`         text    default '',
    `model`         text    default '',
    `product_id`         text    default '',
    `fw_version`         integer    default -1,
    `sw_version`         integer    default -1,
    `event_time`         integer    default -1,
    `status`         text    default '',
    `extension_info` text    default ''
);

{"device645","142160002267","11111111111111111111111111111111",1,"142160002267",3,0}


