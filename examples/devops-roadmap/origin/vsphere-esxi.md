



# ESXI 管理常用命令

## esxcli

### 维护模式管理

```bash
esxcli system maintenanceMode {cmd} [cmd options]

Available Commands:
  get                   获取系统维护状态
  set                   Enable or disable the maintenance mode of the system.
  	-e|--enable           开启维护模式 (必须)
    -t|--timeout=<long>   多少秒后进入维护模式 (默认0秒)
    -m|--vsanmode=<str>   在主机进入维护模式(默认ensureObjectAccessibility)之前，VSAN服务必须执行														的操作。允许的值是:
														ensureObjectAccessibility:
																在进入维护模式之前，从磁盘中提取数据以确保虚拟SAN集群中的对象可访问性。
														evacuateAllData:在进入维护模式之前，从磁盘中撤离所有数据。
														noAction:在进入维护模式之前，不要将虚拟SAN数据移出磁盘。

```

### 关机重启管理（必须进入维护模式）

```bash
esxcli system shutdown {cmd} [cmd options]

Available Commands:
  poweroff              断开电源
    -d|--delay=<long>     多少秒后关机，范围在10-4294967295
    -r|--reason=<str>     执行该操作的原因
  reboot                重启系统
    -d|--delay=<long>     多少秒后关机，范围在10-4294967295
    -r|--reason=<str>     执行该操作的原因
```

### 系统时间管理

```bash
esxcli system time set [cmd options]

Cmd options:
  -d|--day=<long>       Day
  -H|--hour=<long>      Hour
  -m|--min=<long>       Minute
  -M|--month=<long>     Month
  -s|--sec=<long>       Second
  -y|--year=<long>      Year
```



