
### 部署目录清单
![](./images/Snipaste_2021-09-10_16-15-20.png)

### 1.step 通过相关工具上传目录 rk8010 到网关: /userdata/rk8010

### 2.step 部署文件到相应目录
```shell

# 
rm -rf /userdata/gwdb /userdata/srsSrv /userdata/tk_tfroom /userdata/tk5web /userdata/tk-docker
#
cp -r /userdata/rk8010/gwdb /userdata/
cp -r /userdata/rk8010/srsSrv /userdata/
cp -r /userdata/rk8010/tk_tfroom /userdata/
cp -r /userdata/rk8010/tk5web /userdata/
cp -r /userdata/rk8010/tk-docker /userdata/
#
chmod +x /userdata/srsSrv/srs
chmod +x /userdata/tk_tfroom/bin/tk_tfroom
chmod +x /userdata/tk5web/tk5web

# myapp
rm -rf /usr/sbin/web /usr/sbin/myapp /usr/sbin/route.txt /usr/sbin/tk5web /usr/sbin/tk-docker
#
cp -r /userdata/rk8010/web /usr/sbin/
cp /userdata/rk8010/upgradeboot /usr/sbin/
cp /userdata/rk8010/myapp /usr/sbin/
cp /userdata/rk8010/route.txt /usr/sbin/
cp /userdata/rk8010/self.crt /usr/sbin/
cp /userdata/rk8010/self.key /usr/sbin/
#
chmod +x /usr/sbin/upgradeboot
chmod +x /usr/sbin/myapp

# tools: runsv sqlite3
cp /userdata/rk8010/runsv /usr/sbin
cp /userdata/rk8010/sqlite3 /usr/sbin
chmod +x /usr/sbin/runsv
chmod +x /usr/sbin/sqlite3

```

### 3.step 视频AI的库升级
```shell
cp /usr/lib/librockchip_mpp.so /usr/lib/librockchip_mpp.so.bak
cp /usr/lib/librockchip_mpp.so.0 /usr/lib/librockchip_mpp.so.0.bak
cp /usr/lib/librockchip_mpp.so.1 /usr/lib/librockchip_mpp.so.1.bak

cp /userdata/rk8010/tk_tfroom/rknn_use/librockchip_mpp.so /usr/lib/librockchip_mpp.so
cp /userdata/rk8010/tk_tfroom/rknn_use/librockchip_mpp.so.0 /usr/lib/librockchip_mpp.so.0
cp /userdata/rk8010/tk_tfroom/rknn_use/librockchip_mpp.so.1 /usr/lib/librockchip_mpp.so.1
```

### 4.step 视频AI的License
> 在设备上先运行getSerialTxt_aarch64这个程序，获得一个 LocalSerial.txt  文件   
> 然后拷贝到SerialTxtEncode.exe程序的目录下，运行上面那个程序就可以生成对应的密钥文件
> 然后拷贝 serialcode.sys 到目录 /userdata/tk_tfroom/ai/ 下
```shell
cd /userdata/tk_tfroom && ./getSerialTxt_aarch64
# cp LocalSerial.txt to Local
```

### 5.step autostart
```shell
#
cat > /userdata/tk_tfroom/bin/start.sh <<EOF
sleep 10
cd /userdata/tk_tfroom/bin
source /userdata/tk_tfroom/bin/enEnv.sh
/usr/sbin/runsv -- /userdata/tk_tfroom/bin/tk_tfroom -c /userdata/tk_tfroom/cfg/rknn_ai.xml 1> /var/log/tk_tfroom.log 2>&1 &
EOF
chmod +x /userdata/tk_tfroom/bin/start.sh

#
cat > /etc/init.d/S99_start_tfroom <<EOF
cd /userdata/srsSrv
/usr/sbin/runsv -- /userdata/srsSrv/srs -c /userdata/srsSrv/tk_rknn_rtmp_flv.conf 1> /var/log/tk_srs.log 2>&1 &
echo "S99_start_tfroom srs start \$(date)" >> /opt/auto_start.log
cd /userdata/tk_tfroom/bin
sh /userdata/tk_tfroom/bin/start.sh &
echo "S99_start_tfroom tk_tfroom start \$(date)" >> /opt/auto_start.log
EOF
chmod +x /etc/init.d/S99_start_tfroom

#
cat > /etc/init.d/S99_start_tk5web <<EOF
/usr/sbin/runsv -- /userdata/tk5web/tk5web -d "/userdata/tk5web" 1> /var/log/tk5web.log 2>&1 &

nohup /opt/tk5web/tk5web -d "/opt/tk5web" 1> /var/log/tk5web.log 2>&1 &
nohup /userdata/tk5web/tk5web -d "/userdata/tk5web" 1> /dev/null 2>&1 &

echo "S99_start_tk5web start \$(date)" >> /opt/auto_start.log
EOF
chmod +x /etc/init.d/S99_start_tk5web
```

### 6.step update ai web
```shell
# link dir
ln -s /userdata/shm /usr/sbin/web/alarm_images
ln -s /userdata/shm /userdata/tk5web/assets/alarm_images
ln -s /usr/sbin/myapp /usr/sbin/myapp_backup
#
rm -rf /usr/sbin/web/ai
# copy ai.web.tar ai to /usr/sbin/web
# /usr/sbin/web
cd /usr/sbin/web && rm -rf /usr/sbin/web/ai && tar xvf ai.web.tar
```

### 测试的流地址
```text
rtsp://tk:tk123456@192.168.91.121:80/ch0_0.264
rtsp://admin:tk123456@192.168.91.120:554/h264/ch1/main/av_stream

```