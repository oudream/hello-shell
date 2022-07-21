#!/usr/bin/env bash

docker run -d --name psql1 --restart always \
  -e POSTGRES_USER='postgres' \
  -e POSTGRES_PASSWORD='Aa.123456' \
  -e ALLOW_IP_RANGE=0.0.0.0/0 \
	-v /opt/psql1/data:/var/lib/postgresql \
  -p 5432:5432 \
	postgres:14.3

# ALLOW_IP_RANGE=0.0.0.0/0
# or
# 找到如下图所示 IPv4 local connection 下面的参数，根据自己需求修改允许的IP，局域网内则设置为192.168.1.0/24，全部允许则设置为 0.0.0.0/0
vim /var/lib/postgresql/data/pg_hba.conf
# 修改 listen_address = '*'
vim /var/lib/postgresql/data/postgresql.conf


# login by db's postgres user
psql --host=localhost --dbname=postgres --username=postgres
# login by UNIX user
sudo -u postgres psql
sudo -u postgres psql postgres
# sql
sudo -u postgres psql -c "select version();"


  psql [OPTION]... [DBNAME [USERNAME]]

# General options:
  -c, --command=COMMAND    # run only single command (SQL or internal) and exit
  -d, --dbname=DBNAME      # database name to connect to (default: "root")
  -f, --file=FILENAME      # execute commands from file, then exit
  -l, --list               # list available databases, then exit
  -v, --set=, --variable=NAME=VALUE
                           # set psql variable NAME to VALUE
                           # (e.g., -v ON_ERROR_STOP=1)
  -V, --version            # output version information, then exit
  -X, --no-psqlrc          # do not read startup file (~/.psqlrc)
  -1 ("one"), --single-transaction
                           # execute as a single transaction (if non-interactive)
  -?, --help[=options]     # show this help, then exit
      --help=commands      # list backslash commands, then exit
      --help=variables     # list special variables, then exit

# Input and output options:
  -a, --echo-all           # echo all input from script
  -b, --echo-errors        # echo failed commands
  -e, --echo-queries       # echo commands sent to server
  -E, --echo-hidden        # display queries that internal commands generate
  -L, --log-file=FILENAME  # send session log to file
  -n, --no-readline        # disable enhanced command line editing (readline)
  -o, --output=FILENAME    # send query results to file (or |pipe)
  -q, --quiet              # run quietly (no messages, only query output)
  -s, --single-step        # single-step mode (confirm each query)
  -S, --single-line        # single-line mode (end of line terminates SQL command)

# Output format options:
  -A, --no-align           # unaligned table output mode
  -F, --field-separator=STRING
                           # field separator for unaligned output (default: "|")
  -H, --html               # HTML table output mode
  -P, --pset=VAR[=ARG]     # set printing option VAR to ARG (see \pset command)
  -R, --record-separator=STRING
                           # record separator for unaligned output (default: newline)
  -t, --tuples-only        # print rows only
  -T, --table-attr=TEXT    # set HTML table tag attributes (e.g., width, border)
  -x, --expanded           # turn on expanded table output
  -z, --field-separator-zero
                           # set field separator for unaligned output to zero byte
  -0, --record-separator-zero
                           # set record separator for unaligned output to zero byte

# Connection options:
  -h, --host=HOSTNAME      # database server host or socket directory (default: "/var/run/postgresql")
  -p, --port=PORT          # database server port (default: "5432")
  -U, --username=USERNAME  # database user name (default: "root")
  -w, --no-password        # never prompt for password
  -W, --password           # force password prompt (should happen automatically)



#    一、安装
# centos7 install postgresql13
sudo yum -y install https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
sudo yum -y update
# yum search postgresql13
sudo yum -y install postgresql13-server postgresql13.x86_64 postgresql13-odbc.x86_64
sudo vim /etc/profile
# > export PATH=$PATH:/usr/pgsql-13/bin
sudo vi /var/lib/pgsql/13/data/postgresql.conf
# > listen_addresses = '*'
sudo vi /var/lib/pgsql/13/data/pg_hba.conf
# 最后一行增加：Accept from anywhere (not recommended)
# > host all all 0.0.0.0/0 md5
sudo postgresql-13-setup initdb
sudo systemctl start postgresql-13
sudo systemctl enable postgresql-13
su postgres
psql
alter user postgres with password '123456';

# linux
#    首先，安装PostgreSQL客户端。
sudo apt-get install postgresql-client
#
#    然后，安装PostgreSQL服务器。
sudo apt-get install postgresql
#
#    正常情况下，安装完成后，PostgreSQL服务器会自动在本机的5432端口开启。
#
#    如果还想安装图形管理界面，可以运行下面命令，但是本文不涉及这方面内容。
sudo apt-get install pgadmin3
#
# macos
https://postgresapp.com/
#
#    二、添加新用户和新数据库
#
#    初次安装后，默认生成一个名为postgres的数据库和一个名为postgres的数据库用户。这里需要注意的是，同时还生成了一个名为postgres的Linux系统用户。
#
#    下面，我们使用postgres用户，来生成其他用户和新数据库。好几种方法可以达到这个目的，这里介绍两种。
#
#    第一种方法，使用PostgreSQL控制台。
#
#    首先，新建一个Linux新用户，可以取你想要的名字，这里为dbuser1。
sudo adduser dbuser1
#    然后，切换到postgres用户。
sudo su - postgres
#    下一步，使用psql命令登录PostgreSQL控制台。
psql
#    这时相当于系统用户postgres以同名数据库用户的身份，登录数据库，这是不用输入密码的。
#    如果一切正常，系统提示符会变为"postgres=#"，表示这时已经进入了数据库控制台。以下的命令都在控制台内完成。
#
#    第一件事是使用\password命令，为postgres用户设置一个密码。
    \password postgres
#
#    第二件事是创建数据库用户dbuser1（刚才创建的是Linux系统用户），并设置密码。
CREATE USER dbuser1 WITH PASSWORD 'password';
#
#    第三件事是创建用户数据库，这里为exampledb，并指定所有者为dbuser1。
CREATE DATABASE exampledb OWNER dbuser1;
#
#    第四件事是将exampledb数据库的所有权限都赋予dbuser1，否则dbuser1只能登录控制台，没有任何数据库操作权限。
#
GRANT ALL PRIVILEGES ON DATABASE exampledb to dbuser1;
#
#    最后，使用\q命令退出控制台（也可以直接按ctrl+D）。
    \q
#
#    第二种方法，使用shell命令行。
#
#    添加新用户和新数据库，除了在PostgreSQL控制台内，还可以在shell命令行下完成。
#    这是因为PostgreSQL提供了命令行程序createuser和createdb。还是以新建用户dbuser1和数据库exampledb为例。
#
#    首先，创建数据库用户dbuser1，并指定其为超级用户。
sudo -u postgres createuser --superuser dbuser1
#
#    然后，登录数据库控制台，设置dbuser1用户的密码，完成后退出控制台。
sudo -u postgres psql
#
    \password dbuser1
#
    \q
#
#    接着，在shell命令行下，创建数据库exampledb，并指定所有者为dbuser1。
#
sudo -u postgres createdb -O dbuser1 exampledb
#
#    三、登录数据库
#
#    添加新用户和新数据库以后，就要以新用户的名义登录数据库，这时使用的是psql命令。
psql -U dbuser1 -d exampledb -h 127.0.0.1 -p 5432
#
#    上面命令的参数含义如下：-U指定用户，-d指定数据库，-h指定服务器，-p指定端口。
#
#    输入上面命令以后，系统会提示输入dbuser1用户的密码。输入正确，就可以登录控制台了。
#
#    psql命令存在简写形式。如果当前Linux系统用户，同时也是PostgreSQL用户，则可以省略用户名（-U参数的部分）。
#    举例来说，我的Linux系统用户名为ruanyf，且PostgreSQL数据库存在同名用户，
#    则我以ruanyf身份登录Linux系统后，可以直接使用下面的命令登录数据库，且不需要密码。
psql exampledb

#
#    此时，如果PostgreSQL内部还存在与当前系统用户同名的数据库，则连数据库名都可以省略。
#    比如，假定存在一个叫做ruanyf的数据库，则直接键入psql就可以登录该数据库。
psql
#
#    另外，如果要恢复外部数据，可以使用下面的命令。
psql exampledb < exampledb.sql
#
#    四、控制台命令
#
#    除了前面已经用到的\password命令（设置密码）和\q命令（退出）以外，控制台还提供一系列其他命令。
#
\h   # 查看SQL命令的解释，比如\h select。
\?   # 查看psql命令列表。
\l   # 列出所有数据库。
\c [database_name]   # 连接其他数据库。
\d   # 列出当前数据库的所有表格。
\d [table_name]    列出某一张表格的结构。
\du  # 列出所有用户。
\e   # 打开文本编辑器。
\conninfo    列出当前数据库和连接的信息。

### 执行外部SQL文件
# 连接db后执行SQL文件
psql -d db1 -U user1
\i /path1/xxx.sql
# 直接通过psql命令执行SQL文件
psql -d db1 -U user1 -f /path1/xxx.sql


#
#    五、数据库操作
#
#    基本的数据库操作，就是使用一般的SQL语言。
#
#    创建数据库用户dbuser1，并设置密码。
CREATE USER dbuser1 WITH PASSWORD '123456';
#
#    创建用户数据库，这里为db1，并指定所有者为dbuser1。
CREATE DATABASE db1 OWNER dbuser1;
#
#    权限 将exampledb数据库的所有权限都赋予dbuser1，否则dbuser1只能登录控制台，没有任何数据库操作权限。
GRANT ALL PRIVILEGES ON DATABASE db1 to dbuser1;
#
#    # 删除数据库 （也可以用 postgresql 的命令工具 dropdb）
DROP DATABASE [ IF EXISTS ] db1
#
#    # 创建新表
CREATE TABLE user_tbl(name VARCHAR(20), signup_date DATE);
#
#    # 插入数据
INSERT INTO user_tbl(name, signup_date) VALUES('张三', '2013-12-22');
#
#    # 选择记录
SELECT * FROM user_tbl;
#
#    # 更新数据
UPDATE user_tbl set name = '李四' WHERE name = '张三';
#
#    # 删除记录
DELETE FROM user_tbl WHERE name = '李四' ;
#
#    # 添加栏位
ALTER TABLE user_tbl ADD email VARCHAR(40);
#
#    # 更新结构
ALTER TABLE user_tbl ALTER COLUMN signup_date SET NOT NULL;
#
#    # 更名栏位
ALTER TABLE user_tbl RENAME COLUMN signup_date TO signup;
#
#    # 删除栏位
ALTER TABLE user_tbl DROP COLUMN email;
#
#    # 表格更名
ALTER TABLE user_tbl RENAME TO backup_tbl;
#
#    # 删除表格
DROP TABLE IF EXISTS backup_tbl;






### in psql process
# General
  \copyright             # show PostgreSQL usage and distribution terms
  \crosstabview [COLUMNS]#  execute query and display results in crosstab
  \errverbose            # show most recent error message at maximum verbosity
  \g [FILE] or ;         # execute query (and send results to file or |pipe)
  \gexec                 # execute query, then execute each value in its result
  \gset [PREFIX]         # execute query and store results in psql variables
  \gx [FILE]             # as \g, but forces expanded output mode
  \q                     # quit psql
  \watch [SEC]           # execute query every SEC seconds
                         #
# Help                     #
  \? [commands]          # show help on backslash commands
  \? options             # show help on psql command-line options
  \? variables           # show help on special variables
  \h [NAME]              # help on syntax of SQL commands, * for all commands
                         #
# Query Buffer             #
  \e [FILE] [LINE]       # edit the query buffer (or file) with external editor
  \ef [FUNCNAME [LINE]]  # edit function definition with external editor
  \ev [VIEWNAME [LINE]]  # edit view definition with external editor
  \p                     # show the contents of the query buffer
  \r                     # reset (clear) the query buffer
  \s [FILE]              # display history or save it to file
  \w FILE                # write query buffer to file
                         #
# Input/Output             #
  \copy ...              # perform SQL COPY with data stream to the client host
  \echo [STRING]         # write string to standard output
  \i FILE                # execute commands from file
  \ir FILE               # as \i, but relative to location of current script
  \o [FILE]              # send all query results to file or |pipe
  \qecho [STRING]        # write string to query output stream (see \o)
                         #
# Conditional              #
  \if EXPR               # begin conditional block
  \elif EXPR             # alternative within current conditional block
  \else                  # final alternative within current conditional block
  \endif                 # end conditional block


# Informational
  (options: S = show system objects, + = additional detail)
  \d[S+]                 # list tables, views, and sequences
  \d[S+]  NAME           # describe table, view, sequence, or index
  \da[S]  [PATTERN]      # list aggregates
  \dA[+]  [PATTERN]      # list access methods
  \db[+]  [PATTERN]      # list tablespaces
  \dc[S+] [PATTERN]      # list conversions
  \dC[+]  [PATTERN]      # list casts
  \dd[S]  [PATTERN]      # show object descriptions not displayed elsewhere
  \dD[S+] [PATTERN]      # list domains
  \ddp    [PATTERN]      # list default privileges
  \dE[S+] [PATTERN]      # list foreign tables
  \det[+] [PATTERN]      # list foreign tables
  \des[+] [PATTERN]      # list foreign servers
  \deu[+] [PATTERN]      # list user mappings
  \dew[+] [PATTERN]      # list foreign-data wrappers
  \df[antw][S+] [PATRN]  # list [only agg/normal/trigger/window] functions
  \dF[+]  [PATTERN]      # list text search configurations
  \dFd[+] [PATTERN]      # list text search dictionaries
  \dFp[+] [PATTERN]      # list text search parsers
  \dFt[+] [PATTERN]      # list text search templates
  \dg[S+] [PATTERN]      # list roles
  \di[S+] [PATTERN]      # list indexes
  \dl                    # list large objects, same as \lo_list
  \dL[S+] [PATTERN]      # list procedural languages
  \dm[S+] [PATTERN]      # list materialized views
  \dn[S+] [PATTERN]      # list schemas
  \do[S]  [PATTERN]      # list operators
  \dO[S+] [PATTERN]      # list collations
  \dp     [PATTERN]      # list table, view, and sequence access privileges
  \drds [PATRN1 [PATRN2]]# list per-database role settings
  \dRp[+] [PATTERN]      # list replication publications
  \dRs[+] [PATTERN]      # list replication subscriptions
  \ds[S+] [PATTERN]      # list sequences
  \dt[S+] [PATTERN]      # list tables
  \dT[S+] [PATTERN]      # list data types
  \du[S+] [PATTERN]      # list roles
  \dv[S+] [PATTERN]      # list views
  \dx[+]  [PATTERN]      # list extensions
  \dy     [PATTERN]      # list event triggers
  \l[+]   [PATTERN]      # list databases
  \sf[+]  FUNCNAME       # show a function's definition
  \sv[+]  VIEWNAME       # show a view's definition
  \z      [PATTERN]      # same as \dp

# Formatting
  \a                     # toggle between unaligned and aligned output mode
  \C [STRING]            # set table title, or unset if none
  \f [STRING]            # show or set field separator for unaligned query output
  \H                     # toggle HTML output mode (currently off)
  \pset [NAME [VALUE]]   # set table output option
                         # (NAME := {border|columns|expanded|fieldsep|fieldsep_zero|
                         # footer|format|linestyle|null|numericlocale|pager|
                         # pager_min_lines|recordsep|recordsep_zero|tableattr|title|
                         # tuples_only|unicode_border_linestyle|
                         # unicode_column_linestyle|unicode_header_linestyle})
  \t [on|off]            # show only rows (currently off)
  \T [STRING]            # set HTML <table> tag attributes, or unset if none
  \x [on|off|auto]       # toggle expanded output (currently off)

# Connection
  \c[onnect] {[DBNAME|- USER|- HOST|- PORT|-] | conninfo}
                         # connect to new database (currently "db1")
  \conninfo              # display information about current connection
  \encoding [ENCODING]   # show or set client encoding
  \password [USERNAME]   # securely change the password for a user
                         #
# Operating System
  \cd [DIR]              # change the current working directory
  \setenv NAME [VALUE]   # set or unset environment variable
  \timing [on|off]       # toggle timing of commands (currently off)
  \! [COMMAND]           # execute command in shell or start interactive shell

# Variables
  \prompt [TEXT] NAME    # prompt user to set internal variable
  \set [NAME [VALUE]]    # set internal variable, or list all if no parameters
  \unset NAME            # unset (delete) internal variable

Large Objects
  \lo_export LOBOID FILE
  \lo_import FILE [COMMENT]
  \lo_list
  \lo_unlink LOBOID      # large object operations









### pgweb is postgresql's client
# https://github.com/sosedoff/pgweb
# Start server:
pgweb

# To enable multiple database sessions in pgweb, start the server with:
pgweb --sessions
pgweb --sessions --bind=0.0.0.0 --listen=2281

# You can also provide connection flags:
pgweb --host localhost --user myuser --db mydb

# install
# mac
wget https://github.com/sosedoff/pgweb/releases/download/v0.11.4/pgweb_darwin_amd64.zip
unzip pgweb_darwin_amd64.zip
# linux
wget https://github.com/sosedoff/pgweb/releases/download/v0.11.4/pgweb_linux_amd64.zip
unzip pgweb_linux_amd64.zip
mv pgweb_linux_amd64 /usr/local/bin/pgweb

pgweb --help

pgweb [OPTIONS]

# Application Options:
  -v, --version          # Print version
  -d, --debug            # Enable debugging mode
      --url=             # Database connection string
      --host=            # Server hostname or IP (default: localhost)
      --port=            # Server port (default: 5432)
      --user=            # Database user
      --pass=            # Password for user
      --db=              # Database name
      --ssl=             # SSL option
      --bind=            # HTTP server host (default: localhost)
      --listen=          # HTTP server listen port (default: 8081)
      --auth-user=       # HTTP basic auth user
      --auth-pass=       # HTTP basic auth password
  -s, --skip-open        # Skip browser open on start
      --sessions         # Enable multiple database sessions
      --prefix=          # Add a url prefix
      --readonly         # Run database connection in readonly mode
      --lock-session     # Lock session to a single database connection
  -b, --bookmark=        # Bookmark to use for connection. Bookmark files are stored under $HOME/.pgweb/bookmarks/*.toml
      --bookmarks-dir=   # Overrides default directory for bookmark files to search
      --no-pretty-json   # Disable JSON formatting feature for result export
      --no-ssh           # Disable database connections via SSH
      --connect-backend= # Enable database authentication through a third party backend
      --connect-token=   # Authentication token for the third-party connect backend
      --connect-headers= # List of headers to pass to the connect backend
      --no-idle-timeout  # Disable connection idle timeout
      --idle-timeout=    # Set connection idle timeout in minutes (default: 180)
      --cors             # Enable Cross-Origin Resource Sharing (CORS)
      --cors-origin=     # Allowed CORS origins (default: *)





### hello

CREATE USER dbuser1 WITH PASSWORD '123456';
CREATE DATABASE db1 OWNER dbuser1;
GRANT ALL PRIVILEGES ON DATABASE db1 to dbuser1;
psql --host=localhost --dbname=db1 --username=dbuser1




