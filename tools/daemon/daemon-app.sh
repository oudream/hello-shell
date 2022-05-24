#!/bin/sh

while(true)
do
    sleep 10

    cd /usr/sbin || continue

    # shellcheck disable=SC2006
    pidApp=`ps -ef | grep tk_mqtt_tongke/tk_mqtt_tongke | grep -v grep | awk '{print $2}'`
    if [ -z ${pidApp} ]; then
        # nohup nohup teamviewer -r 1>/opt/teamviewer/teamviewer.out 2>&1 &
        echo start tk_mqtt_tongke ok.
    else
        echo tk_mqtt_tongke is running.
    fi

done
