### build
```shell
git clone https://github.com/eclipse/mosquitto.git
git clone https://github.com/troydhanson/uthash.git
cp uthash/src/* mosquitto/include
cd mosquitto
# v2.0.14: 17 Nov 2021 
git checkout fd0e398
# build amd64
mkdir cmake-build-local && cd cmake-build-local
cmake -DWITH_CJSON=no -DWITH_TLS=no -DWITH_BUNDLED_DEPS=no -DWITH_DOCS=no -DDOCUMENTATION=OFF ..
# build arm64
mkdir cmake-build-linaro64 &&cd cmake-build-linaro64
cmake -DWITH_CJSON=no -DWITH_TLS=no -DWITH_BUNDLED_DEPS=no -DWITH_DOCS=no -DDOCUMENTATION=OFF -D CMAKE_TOOLCHAIN_FILE="/opt/dev/hello_iec104/build/aarch64/linaro/toolchainfile.cmake" ..
# build arm32
mkdir cmake-build-linaro32 &&cd cmake-build-linaro32
cmake -DWITH_CJSON=no -DWITH_TLS=no -DWITH_BUNDLED_DEPS=no -DWITH_DOCS=no -DDOCUMENTATION=OFF -D CMAKE_TOOLCHAIN_FILE="/opt/dev/hello_iec104/build/armv7/linaro/toolchainfile.cmake" ..
#
make -j 8
#
mkdir -p /opt/deploy/amd64/mosquitto/
cp src/mosquitto /opt/deploy/amd64/mosquitto/
cp client/mosquitto_pub /opt/deploy/amd64/mosquitto/
cp client/mosquitto_rr /opt/deploy/amd64/mosquitto/
cp client/mosquitto_sub /opt/deploy/amd64/mosquitto/
cp lib/libmosquitto.so.1 /opt/deploy/amd64/mosquitto/
```


### download
- https://mosquitto.org/download/
- https://mosquitto.org/files/binary/win64/mosquitto-2.0.11-install-windows-x64.exe
- ubuntu
```shell
sudo apt install mosquitto mosquitto-clients
# centos 
sudo yum -y install epel-release
sudo yum install mosquitto mosquitto-clients
# service
sudo systemctl enable mosquitto
sudo systemctl restart mosquitto
# QA
# - https://blog.clang.cn/809.html
# invoke-rc.d: syntax error: unknown option "--skip-systemd-native"
# 首先查看init-system-helpers有什么版本可以安装：
sudo apt-cache policy init-system-helpers
# 看结果有1.22版本可以安装，使用命令安装：
sudo apt-get install init-system-helpers=1.22
#
# test
mosquitto_sub -h localhost -t test
mosquitto_pub -h localhost -t test -m "hello world"
```

### org
- https://mosquitto.org/
- https://github.com/eclipse/mosquitto
- https://mosquitto.org/man/mosquitto_ctrl-1.html

### setting
```shell
#设置不允许匿名登录
allow_anonymous false
#设置账户密码文件位置为C:\MosquittoTest\pwfile.example
password_file /MosquittoTest/pwfile.example
```

### user, password
```shell
mosquitto_passwd /MosquittoTest/pwfile.example dissun
# 111111
```

### mosquitto
```shell
mosquitto -c /etc/mosquitto/mosquitto.conf
```

### 订阅消息
```
mosquitto_sub -u dissun -P 111111 -t 'dissun/topic' -v
mosquitto_sub -t '/5g/data/request' -v
mosquitto_sub -t '+/get/request/datacenter/model' -v

mosquitto_sub -t 'Tk_mqtt_jiexi/get/request/datacenter/model' -v
mosquitto_sub -t 'Tk_mqtt_jiexi/set/request/datacenter/model' -v
mosquitto_sub -t 'Tk_mqtt_jiexi/get/request/datacenter/guid' -v
mosquitto_sub -t 'Tk_mqtt_jiexi/set/request/datacenter/register' -v

mosquitto_sub -t 'datacenter/get/response/Tk_mqtt_jiexi/model' -v
mosquitto_sub -t 'datacenter/set/response/Tk_mqtt_jiexi/model' -v
mosquitto_sub -t 'datacenter/get/response/Tk_mqtt_jiexi/guid' -v
mosquitto_sub -t 'datacenter/set/response/Tk_mqtt_jiexi/register' -v
mosquitto_sub -t 'Tk_mqtt_jiexi/notify/event/datacenter/Meter_single/Meter_single_dd0e6320-8adf-4f1c-be97-529f82087496' -v
```

### 发布消息
```shell
mosquitto_pub -u dissun -P 111111 -t 'dissun/topic' -m '腰疼不加班'
mosquitto_pub -t '/5g/data/reply' -m '腰疼不加班'
mosquitto_pub -t 'cns/get/request/bizInfo' -m '{"timestamp":"2022-08-02 23:15:05"}'
mosquitto_pub -t 'cns/get/request/bizUpdate' -m '{"timestamp":"2022-08-02 22:03:59","status":1,"total":1,"current":1,"uuid":3,"body":{"mac":"eeeeabababab","operation":1,"info":[{"bizNum":0,"appName":"appMsgRecv","lvl":5},{"bizNum":0,"appName":"appMsgSendUp","lvl":6},{"bizNum":0,"appName":"propReport","lvl":7},{"bizNum":0,"appName":"northLinkGuard","lvl":8},{"bizNum":8,"appName":"mqttXinTong","lvl":9}]}}'

# model get
mosquitto_pub -t 'datacenter/get/response/Tk_mqtt_jiexi/model' -m '{"token":"7008000194448982020","timestamp":"2019-03-01T09:30:09.230+0800","body":[{"model":"Meter_single","body":[{"name":"tgP","type":"float","unit":"kW","deadzone":"0.01","ratio":"1","isReport":"1","userdefine":"总有功功率"},{"name":"tgPa","type":"float","unit":"kW","deadzone":"0.01","ratio":"1","isReport":"1","userdefine":"A相有功功率 "},{"name":"tgPb","type":"float","unit":"kW","deadzone":"0.01","ratio":"1","isReport":"1","userdefine":"B相有功功率 "},{"name":"tgPc","type":"float","unit":"kW","deadzone":"0.01","ratio":"1","isReport":"1","userdefine":"C相有功功率 "},{"name":"tgUa","type":"float","unit":"V","deadzone":"0.01","ratio":"1","isReport":"1","userdefine":"A相电压"},{"name":"tgUb","type":"float","unit":"V","deadzone":"0.01","ratio":"1","isReport":"1","userdefine":"B相电压"},{"name":"tgUc","type":"float","unit":"V","deadzone":"0.01","ratio":"1","isReport":"1","userdefine":"C相电压"},{"name":"tgIa","type":"float","unit":"A","deadzone":"0.01","ratio":"1","isReport":"1","userdefine":"A相电流"},{"name":"tgIb","type":"float","unit":"A","deadzone":"0.01","ratio":"1","isReport":"1","userdefine":"B相电流"},{"name":"tgIc","type":"float","unit":"A","deadzone":"0.01","ratio":"1","isReport":"1","userdefine":"C相电流"},{"name":"tgI0","type":"float","unit":"A","deadzone":"0.01","ratio":"1","isReport":"1","userdefine":"零线电流"},{"name":"tgSupWh","type":"float","unit":"kWh","deadzone":"0.01","ratio":"1","isReport":"1","userdefine":"正向有功总电能"},{"name":"tgSupWhA","type":"float","unit":"kWh","deadzone":"0.01","ratio":"1","isReport":"1","userdefine":"A相正向有功电能"},{"name":"tgSupWhB","type":"float","unit":"kWh","deadzone":"0.01","ratio":"1","isReport":"1","userdefine":"B相正向有功电能"},{"name":"tgSupWhC","type":"float","unit":"kWh","deadzone":"0.01","ratio":"1","isReport":"1","userdefine":"C相正向有功电能"}]}]}' 
mosquitto_pub -t 'datacenter/get/response/Tk_mqtt_jiexi/model' -m '{"token":"7008000194448982020","timestamp":"2019-03-01T09:30:09.230+0800","body":[]}' 

mosquitto_pub -t 'datacenter/set/response/Tk_mqtt_jiexi/model' -m '{"token":"7008000194448982020","timestamp":"2019-03-01T09:30:09.230+0800","status":"OK"}'
mosquitto_pub -t 'datacenter/set/response/Tk_mqtt_jiexi/model' -m '{"token":"7008000194448982020","timestamp":"2019-03-01T09:30:09.230+0800","status":"FAILURE"}'

mosquitto_pub -t 'datacenter/get/response/Tk_mqtt_jiexi/guid' -m '{"token":"234","timestamp":"2019-03-01T09:30:09.230+0800","body":[{"model":"Meter_single","port":"RS485-1","addr":"1","desc":"066c8751-427e-4980-b972-19b4be3c724b","guid":"dd0e6320-8adf-4f1c-be97-529f82087496","dev":"Meter_single_dd0e6320-8adf-4f1c-be97-529f82087496"}]}'
mosquitto_pub -t 'datacenter/get/response/Tk_mqtt_jiexi/guid' -m '{"token":"234","timestamp":"2019-03-01T09:30:09.230+0800","body":[]}'

mosquitto_pub -t 'datacenter/set/response/Tk_mqtt_jiexi/register' -m '{"token":"7008000194448982020","timestamp":"2019-03-01T09:30:09.230+0800","status":"OK"}'
mosquitto_pub -t 'datacenter/set/response/Tk_mqtt_jiexi/register' -m '{"token":"7008000194448982020","timestamp":"2019-03-01T09:30:09.230+0800","status":"FAILURE"}'

```


### 清远
- 平台端
```shell
mosquitto_sub -h 192.168.1.8 -p 1883 -u root -P root -t '/5g/data/reply'
mosquitto_pub -h 192.168.1.8 -p 1883 -u root -P root -t '/5g/data/request' -m '{"deviceid": "pdfcxd0006","action":"current_power"}'

mosquitto_sub -h 192.168.1.200 -p 1883 -u root -P root -t '/5g/data/reply'
mosquitto_pub -h 192.168.1.200 -p 1883 -u root -P root -t '/5g/data/reply' -m '{"deviceid": "3321001ABCD","action":"current_power"}'

mosquitto_sub -h 192.168.1.200 -p 1883 -u root -P root -t '/5g/data/reply'
./mosquitto_pub -h 14.21.56.4 -p 7806 -t '$oc/dev/s00234345235/set/request/rt' -m '{"deviceid": "3321001ABCD","action":"current_power"}'
./mosquitto_pub -h 14.21.56.4 -p 7806 -t '$oc/dev/SS_-adf0034f/set/request/alarm' -m '{"deviceid": "3321001ABCD","action":"current_power"}'
./mosquitto_pub -h 14.21.56.4 -p 7806 -t '$oc/dev/001232342410/get/response/rt' -m '{"deviceid": "3321001ABCD","action":"current_power"}'

```

```shell
mosquitto_pub -h 192.168.91.253 -p 1883 -t 'datacenter/set/response/Tk_mqtt_jiexi/model' -m '{"token":"7008000194448982020","timestamp":"2019-03-01T09:30:09.230+0800","status":"FAILURE"}'
```

```shell
$oc/devices/00000001/sys/events/up
$oc/devices/00000002/sys/events/up
$oc/devices/0000000$/sys/events/up

mosquitto_sub -h 127.0.0.1 -p 1883 -t 'oc/devices/0000000$/sys/events/up'
mosquitto_sub -h 127.0.0.1 -p 1883 -t '/oc/devices/0000000\$/sys/events/up'
mosquitto_pub -h 127.0.0.1 -p 1883 -t '$oc/devices/00000001/sys/events/up' -m '{"deviceid":"pdfcxd0001","action":"a"}'
mosquitto_pub -h 127.0.0.1 -p 1883 -t '$oc/devices/00000001/sys/events/up' -m '{"deviceid":"pdfcxd0002","action":"b"}'
mosquitto_pub -h 127.0.0.1 -p 1883 -t '$oc/devices/00000002/sys/events/up' -m '{"deviceid":"pdfcxd0003","action":"c"}'
mosquitto_pub -h 127.0.0.1 -p 1883 -t '$oc/devices/00000002/sys/events/up' -m '{"deviceid":"pdfcxd0004","action":"d"}'

```