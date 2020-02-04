#!/usr/bin/env bash


# 1.导出整个数据库
# mysqldump -u 用户名 -p 数据库名 > 导出的文件名
mysqldump -u root -p db1 > db1.sql

# 2.导出一个表
# mysqldump -u 用户名 -p 数据库名 表名> 导出的文件名
mysqldump -u dbuser -p db1 table1> db1_table1.sql

# 3.导出一个数据库结构
mysqldump -u dbuser -p -d --add-drop-table db1 > /opt/tmp/db1.sql
# -d 没有数据
# --add-drop-table 在每个create语句之前增加一个drop table

# 4.导入数据库
# 常用source 命令
# 进入mysql数据库控制台，如
mysql -u root -p
mysql>use db1
# 然后使用source命令，后面参数为脚本文件(如这里用到的.sql)
mysql>source /opt/tmp/db1.sql



# Backup
docker exec CONTAINER /usr/bin/mysqldump -u root --password=root DATABASE > backup.sql

# Restore
cat backup.sql | docker exec -i CONTAINER /usr/bin/mysql -u root --password=root DATABASE
