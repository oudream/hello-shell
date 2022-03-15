
### 参考
- https://github.com/jeecgboot/jeecg-boot
- http://doc.jeecg.com/2043874
```text
# 报表
# http://www.jimureport.com/reportDemo
```



### 后端发布 jeecg-boot
- http://doc.jeecg.com/2043886
```shell
#（0）git clone https://gitee.com/limi_tech/jeecg-boot-limi.git
#（1）初始化数据库，要求mysql5.7+
#（2）修改项目配置文件（数据库配置、redis配置）
#（3）启动redis服务
#（4）启动项目&访问

git clone https://gitee.com/limi_tech/jeecg-boot-limi.git
git reset --hard
git checkout v3.0.0

cd jeecg-boot-limi/jeecg-boot
mvn package

vim jeecg-boot-module-system/src/main/resources/application-dev.yml
vim jeecg-boot-module-system/src/main/resources/application-prod.yml

# jeecg-boot-module-system/src/main/java/org/jeecg/JeecgSystemApplication.java
cd /opt/limi/jeecg-boot-limi/jeecg-boot
nohup java -jar ./jeecg-boot-module-system/target/jeecg-boot-module-system-3.0.jar --spring.profiles.active=dev 1>/opt/jeecg-boot-module-system.out 2>&1 &
tail -99f /opt/jeecg-boot-module-system.out
# 关掉项目：
ps -ef | grep java
kill 进程号 

cd /opt/limi/jeecg-boot-limi/jeecg-boot/jeecg-boot-module-system/target/
nohup java -Dspring.config.location=application.yml -Xmx1024m -Xms512m -Xmn128m -XX:PermSize=200M -XX:MaxPermSize=400M  -jar jeecg-boot-module-system-3.0.jar 1>/opt/jeecg-boot-module-system.out 2>&1 &
```



### 前端发布 ant-design-jeecg-vue
```shell
#（1）执行命令下载依赖
#（2）配置后台接口
#（3）启动项目

# 安装yarn
npm install -g yarn

# 下载依赖
yarn install

# 启动
yarn run serve

# 修改 localhost 为远程 API 地址 
vim .env.production
# vim .env.development
#

# 编译项目
yarn run build
# yarn run build --mode development
yarn run build --mode production

#
apt-get install nginx
# 安装后的目录结构为：
# 所有的配置文件都在/etc/nginx下，虚拟主机在/etc/nginx/sites-available
# 程序文件在/usr/sbin/nginx
# 日志放在了/var/log/nginx
# 并已经在/etc/init.d/下创建了启动脚本nginx
# 默认的虚拟主机的目录设置在了/var/www/html
#
cp -rf dist/* /var/www/html/


# Lints and fixes files
yarn run lint
```



### QA
### 让MYSQL不区分表名大小写的方法其实很简单：
```text
用ROOT登录，修改/etc/my.cnf.
在[mysqld]下加入一行：lower_case_table_names=1.
```
