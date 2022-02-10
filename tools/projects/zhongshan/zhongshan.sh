export LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH

nohup /userdata/tk_mqtt_tongke/tk_mqtt_tongke --mqtt-ip "8.129.8.199" --mqtt-port 1883 --mqtt-client-id 2fb47010-31c7-11ec-9e3b-e1ba592b9dda --mqtt-password HVFGBdDIXYlHKHHQLpKo --iot-push-interval 30 --log-path "/userdata/tk_mqtt_tongke/tk_mqtt_tongke.log" --db-path-format "/userdata/tk_mqtt_tongke/gwdb/%s.db" 1> /dev/null 2>&1 &
/userdata/tk_mqtt_tongke/tk_mqtt_tongke --mqtt-ip "8.129.8.199" --mqtt-port 1883 --mqtt-client-id 2fb47010-31c7-11ec-9e3b-e1ba592b9dda --mqtt-password HVFGBdDIXYlHKHHQLpKo --iot-push-interval 30 --log-path "/userdata/tk_mqtt_tongke/tk_mqtt_tongke.log" --db-path-format "/userdata/tk_mqtt_tongke/gwdb/%s.db"
/userdata/tk_mqtt_tongke --mqtt-ip "8.129.8.199" --mqtt-port 1883 --mqtt-client-id d7601dc0-2991-11ec-9be5-973e10187aab --mqtt-password uYjZOzkMAMMYfFLCvufC --iot-push-interval 10 --db-path-format "/userdata/gwdb/%s.db"

cp libpaho-mqtt3a.so.1.3.9 /usr/lib64
cp libpaho-mqtt3c.so.1.3.9 /usr/lib64

cp gw_iot.db /userdata/gwdb/

rm libstdc++.so
rm libstdc++.so.6
ln -s libstdc++.so.6.0.24 libstdc++.so
ln -s libstdc++.so.6.0.24 libstdc++.so.6


sqlite3 /userdata/gwdb/appMBMid.db
