###
- https://github.com/influxdata/influxdb/releases
```shell
# amd64
wget https://dl.influxdata.com/influxdb/releases/influxdb2-client-2.6.0-linux-amd64.tar.gz
tar xvfz influxdb2-client-2.6.0-linux-amd64.tar.gz

# arm64
wget https://dl.influxdata.com/influxdb/releases/influxdb2-client-2.6.0-linux-arm64.tar.gz
tar xvfz influxdb2-client-2.6.0-linux-arm64.tar.gz
```


### backup
- https://www.sunzhongwei.com/influxdb-20-data-backup-recovery-exportimport?from=sidebar
- https://docs.influxdata.com/influxdb/v2.5/backup-restore/backup/
```shell
./influx auth list -t Qkfq2ZiSwjOasvgN8LvlKJSH_zsrUNbXOhqItCjRao-gyvaLc4ooj-wWlYP1uzhOrIP7N34rsTVwA5ZK_rIqyA==

./influx auth list --host http://10.50.52.235:7809 -t wLGX2AvqqNwjQKWq3-1yaIRvi-HsJLljCXMRc2G7BPW9FI5RUVGAc-kgBOupy-lOKM-c15ryrfJ9R18S6rKwxw==

# 必须使用初始用户toekn
./influx backup /opt/tmp/bak-influxdb2 --host http://10.50.52.218:7809 -t lqKwb3f6DtH9wqJGB6V8_K4q1tg8aPFvjLgDuAyZp2DZyDykVEQts3PH42CjY7_nw1MFlzXgJmjbKkzfM-QQqA==

./influx restore /opt/tmp/bak-influxdb2 --host http://10.50.52.218:7809 --full -t lqKwb3f6DtH9wqJGB6V8_K4q1tg8aPFvjLgDuAyZp2DZyDykVEQts3PH42CjY7_nw1MFlzXgJmjbKkzfM-QQqA==
```

### help
```shell
./infux auth -h
```
```shell
USAGE:
   influx [command]

HINT: If you are looking for the InfluxQL shell from 1.x, run "influx v1 shell"

COMMANDS:
   version              Print the influx CLI version
   write                Write points to InfluxDB
   bucket               Bucket management commands
   completion           Generates completion scripts
   query                Execute a Flux query
   config               Config management commands
   org, organization    Organization management commands
   delete               Delete points from InfluxDB
   user                 User management commands
   task                 Task management commands
   telegrafs            List Telegraf configuration(s). Subcommands manage Telegraf configurations.
   dashboards           List Dashboard(s).
   export               Export existing resources as a template
   secret               Secret management commands
   v1                   InfluxDB v1 management commands
   auth, authorization  Authorization management commands
   apply                Apply a template to manage resources
   stacks               List stack(s) and associated templates. Subcommands manage stacks.
   template             Summarize the provided template
   bucket-schema        Bucket schema management commands
   scripts              Scripts management commands
   ping                 Check the InfluxDB /health endpoint
   setup                Setup instance with initial user, org, bucket
   backup               Backup database
   restore              Restores a backup directory to InfluxDB
   remote               Remote connection management commands
   replication          Replication stream management commands
   server-config        Display server config
   help, h              Shows a list of commands or help for one command

GLOBAL OPTIONS:
   --help, -h  show help

```
