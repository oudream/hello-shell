
### exit sqlite3
- Ctrl + D
```shell
.help
.exit
.quit
```

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

### DDL
```sql
DELETE FROM students WHERE stuid = uid;
```


### LEFT JION
```sql
SELECT `variabletransformertype`.`id`, `variabletransformertype`.`name` as `tname`, `transformerprotocoltype`.`name` as `pname`
FROM `variabletransformertype`
LEFT JOIN `transformerprotocoltype`
ON `variabletransformertype`.`protocoltypeid`=`transformerprotocoltype`.`id`;

SELECT * FROM `variabletransformer` WHERE `protocoltype`='c3f9f897-954b-4c79-87df-b6e57bb52a6b';
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


###
```shell
sqlite> .help
.auth ON|OFF             Show authorizer callbacks
.backup ?DB? FILE        Backup DB (default "main") to FILE
.bail on|off             Stop after hitting an error.  Default OFF
.binary on|off           Turn binary output on or off.  Default OFF
.cd DIRECTORY            Change the working directory to DIRECTORY
.changes on|off          Show number of rows changed by SQL
.check GLOB              Fail if output since .testcase does not match
.clone NEWDB             Clone data into NEWDB from the existing database
.databases               List names and files of attached databases
.dbconfig ?op? ?val?     List or change sqlite3_db_config() options
.dbinfo ?DB?             Show status information about the database
.dump ?OBJECTS?          Render database content as SQL
.echo on|off             Turn command echo on or off
.eqp on|off|full|...     Enable or disable automatic EXPLAIN QUERY PLAN
.excel                   Display the output of next command in spreadsheet
.exit ?CODE?             Exit this program with return-code CODE
.expert                  EXPERIMENTAL. Suggest indexes for queries
.explain ?on|off|auto?   Change the EXPLAIN formatting mode.  Default: auto
.filectrl CMD ...        Run various sqlite3_file_control() operations
.fullschema ?--indent?   Show schema and the content of sqlite_stat tables
.headers on|off          Turn display of headers on or off
.help ?-all? ?PATTERN?   Show help text for PATTERN
.import FILE TABLE       Import data from FILE into TABLE
.imposter INDEX TABLE    Create imposter table TABLE on index INDEX
.indexes ?TABLE?         Show names of indexes
.limit ?LIMIT? ?VAL?     Display or change the value of an SQLITE_LIMIT
.lint OPTIONS            Report potential schema issues.
.load FILE ?ENTRY?       Load an extension library
.log FILE|off            Turn logging on or off.  FILE can be stderr/stdout
.mode MODE ?TABLE?       Set output mode
.nullvalue STRING        Use STRING in place of NULL values
.once ?OPTIONS? ?FILE?   Output for the next SQL command only to FILE
.open ?OPTIONS? ?FILE?   Close existing database and reopen FILE
.output ?FILE?           Send output to FILE or stdout if FILE is omitted
.parameter CMD ...       Manage SQL parameter bindings
.print STRING...         Print literal STRING
.progress N              Invoke progress handler after every N opcodes
.prompt MAIN CONTINUE    Replace the standard prompts
.quit                    Exit this program
.read FILE               Read input from FILE
.restore ?DB? FILE       Restore content of DB (default "main") from FILE
.save FILE               Write in-memory database into FILE
.scanstats on|off        Turn sqlite3_stmt_scanstatus() metrics on or off
.schema ?PATTERN?        Show the CREATE statements matching PATTERN
.selftest ?OPTIONS?      Run tests defined in the SELFTEST table
.separator COL ?ROW?     Change the column and row separators
.sha3sum ...             Compute a SHA3 hash of database content
.shell CMD ARGS...       Run CMD ARGS... in a system shell
.show                    Show the current values for various settings
.stats ?ARG?             Show stats or turn stats on or off
.system CMD ARGS...      Run CMD ARGS... in a system shell
.tables ?TABLE?          List names of tables matching LIKE pattern TABLE
.testcase NAME           Begin redirecting output to 'testcase-out.txt'
.testctrl CMD ...        Run various sqlite3_test_control() operations
.timeout MS              Try opening locked tables for MS milliseconds
.timer on|off            Turn SQL timer on or off
.trace ?OPTIONS?         Output each SQL statement as it is run
.vfsinfo ?AUX?           Information about the top-level VFS
.vfslist                 List all available VFSes
.vfsname ?AUX?           Print the name of the VFS stack
.width NUM1 NUM2 ...     Set minimum column widths for columnar output
```
