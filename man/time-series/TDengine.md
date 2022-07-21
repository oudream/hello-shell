
### refer to
- https://docs.taosdata.com/reference/config/


### install download
- https://www.taosdata.com/all-downloads/
- https://www.taosdata.com/assets-download/TDengine-server-2.6.0.6-Linux-x64.tar.gz
- https://www.taosdata.com/assets-download/TDengine-server-2.6.0.6-Linux-aarch32.tar.gz
- https://www.taosdata.com/assets-download/TDengine-server-2.6.0.6-Linux-aarch64.tar.gz
- https://www.taosdata.com/assets-download/TDengine-client-2.6.0.6-Windows-x64.exe
- https://www.taosdata.com/assets-download/TDengine-client-2.6.0.6-Windows-x86.exe
```shell
wget https://www.taosdata.com/assets-download/TDengine-server-2.6.0.6-Linux-aarch64.tar.gz
wget https://www.taosdata.com/assets-download/TDengine-server-2.6.0.6-Linux-x64.tar.gz
tar gxvf TDengine-server-2.6.0.6-Linux-x64.tar.gz
mv TDengine-server-2.6.0.6-Linux-x64 tdengine
cd tdengine
./install.sh

systemctl start taosd
systemctl status taosd

```

### 排行
- https://db-engines.com/en/ranking/time+series+dbms


### docker 
```shell
docker run -d --name tdengine-tk227 --hostname="tk227" -p 6030-6049:6030-6049 -p 6030-6049:6030-6049/udp tdengine/tdengine:2.6.0.6
```

### bin
```shell
-r-xr-xr-x. 1 root root     7513 6月  23 15:20 remove.sh
-r-xr-xr-x. 1 root root       74 6月  23 15:20 run_taosd_and_taosadapter.sh
-r-xr-xr-x. 1 root root      939 6月  23 15:20 set_core.sh
-r-xr-xr-x. 1 root root     1233 6月  23 15:20 startPre.sh
-r-xr-xr-x. 1 root root   690656 6月  23 15:20 taos
-r-xr-xr-x. 1 root root 10759096 6月  23 15:20 taosadapter
-r-xr-xr-x. 1 root root  1658720 6月  23 15:20 taosBenchmark
-r-xr-xr-x. 1 root root  2494288 6月  23 15:20 taosd
-r-xr-xr-x. 1 root root     2950 6月  23 15:20 taosd-dump-cfg.gdb
-r-xr-xr-x. 1 root root  1548304 6月  23 15:20 taosdump
-r-xr-xr-x. 1 root root  1686432 6月  23 15:20 tarbitrator
-r-xr-xr-x. 1 root root 30762729 6月  23 15:20 tdengine-datasource-3.2.5.zip
-r-xr-xr-x. 1 root root   154571 6月  23 15:20 TDinsight-15167.json
-r-xr-xr-x. 1 root root    16881 6月  23 15:20 TDinsight.sh
```
```shell
taosd # TDengine 服务端可执行文件
taos # TDengine Shell 可执行文件
taosdump # 数据导入导出工具
taosBenchmark # TDengine 测试工具
remove.sh # 卸载 TDengine 的脚本，请谨慎执行，链接到/usr/bin 目录下的rmtaos命令。会删除 TDengine 的安装目录/usr/local/taos，但会保留/etc/taos、/var/lib/taos、/var/log/taos
taosadapter # 提供 RESTful 服务和接受其他多种软件写入请求的服务端可执行文件
tarbitrator # 提供双节点集群部署的仲裁功能
TDinsight.sh # 用于下载 TDinsight 并安装的脚本
set_core.sh # 用于方便调试设置系统生成 core dump 文件的脚本
taosd-dump-cfg.gdb # 用于方便调试 taosd 的 gdb 执行脚本。
```                                                            


### 
```shell
# 安装 TDengine 后，默认会在操作系统中生成下列目录或文件：
# 目录/文件	说明
/usr/local/taos/bin	# TDengine 可执行文件目录。其中的执行文件都会软链接到/usr/bin 目录下。
/usr/local/taos/driver # TDengine 动态链接库目录。会软链接到/usr/lib 目录下。
/usr/local/taos/examples # TDengine 各种语言应用示例目录。
/usr/local/taos/include	# TDengine 对外提供的 C 语言接口的头文件。
/etc/taos/taos.cfg	# TDengine 默认[配置文件]
/var/lib/taos # TDengine 默认数据文件目录。可通过[配置文件]修改位置。
/var/log/taos # TDengine 默认日志文件目录。可通过[配置文件]修改位置。
```