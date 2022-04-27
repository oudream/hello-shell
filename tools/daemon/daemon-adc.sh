#!/bin/sh

while(true)
do
    sleep 10

    cd /userdata/tk_mqtt_adc || continue

    # shellcheck disable=SC2006
    pidApp=`ps -ef | grep teamviewer | grep -v teamviewerd | grep -v grep | awk '{print $2}'`
    if [[ "${pidApp}" == "" ]]; then
        nohup nohup teamviewer -r 1>/opt/teamviewer/teamviewer.out 2>&1 &
        echo start teamviewer ok.
    else
        echo teamviewer is running.
    fi

done
