

###
```sql
select * from METER_TABLE_03001DY00011052000006505;
```

### last row
```sql
SELECT * FROM TABLE WHERE ID = (SELECT MAX(ID) FROM TABLE);
```

### 分页
```sql
--- 查询第一行起的5行数据，可以有两种语句： 
select * from T_user limit 5 offset 0; 
-- or 
select * from  T_user limit 0,5;
```

### 解决数据删除后占用空间不变的问题
```sql
VACUUM
```

### 判断表
```sql
select * from sqlite_master
SELECT COUNT(*) AS COUNTER FROM `sqlite_master` WHERE `type`='table' AND `name`='YC_POINT_TABLE';
SELECT * FROM `sqlite_master` WHERE `type`='table';
SELECT `type`, `name`, `tbl_name` FROM `sqlite_master` WHERE `type`='table';
```

### 查询与判断列
```sql
PRAGMA  table_info([USER_LOGIN])
```

### sqlite cli
- https://sqlite.org/cli.html
```shell
sudo apt-get ins
tall zlib1g-dev
# or
sudo apt-get install zlib-dev
#
wget https://www.sqlite.org/2021/sqlite-autoconf-3360000.tar.gz
tar zxvf sqlite-autoconf-3360000.tar.gz
cd sqlite-autoconf-3360000
gcc -o sqlite3 shell.c sqlite3.c -ldl -lpthread -lz -lm
```

### add column
```sql
ALTER TABLE t1 ADD f3 TEXT AFTER f2;
ALTER TABLE `t1` ADD `f3` text NOT NULL DEFAULT '';
UPDATE t1 SET f3='';

```
```sql
ALTER TABLE `camera` ADD `camera_check_url` TEXT AFTER `camera_en`;
UPDATE `camera` SET `camera_check_url`='';

```


###
```text
1. sqlite_master
The sqlite_master table contains the following columns:
Column Name	Description
type	The type of database object such as table, index, trigger or view.
name	The name of the database object.
tbl_name	The table name that the database object is associated with.
rootpage	Root page.
sql	SQL used to create the database object.

2. sqlite_sequence
The sqlite_sequence table contains the following columns:
Column Name	Description
name	The table name associated with the AUTOINCREMENT column.
seq	The last sequence number used in the AUTOINCREMENT column.

3. sqlite_stat1
The sqlite_stat1 table contains the following columns:
Column Name	Description
tbl	The table name that was analyzed.
idx	The name of the index that was analyzed.
stat	Information about the table and indexes analyzed that will be later used by the query optimizer.
```


### DDL
```sql
DELETE FROM students WHERE stuid = uid;
```