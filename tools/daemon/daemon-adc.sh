#!/bin/sh

while(true)
do
    sleep 10

    cd /userdata/tk_mqtt_adc || continue

    # shellcheck disable=SC2006
    pidApp=`ps -ef | grep tk_mqtt_tongke | grep -v grep | awk '{print $2}'`
    if [[ "${pidApp}" == "" ]]; then
        nohup /userdata/tk_mqtt_adc/tk_mqtt_tongke --mqtt-ip "192.168.91.30" --mqtt-port 1883 --mqtt-client-id 7d52c1e0-bb0c-11ec-8b1f-cb770b60e7ec --mqtt-password qxVPFLlRZMvTrKPxWqth --iot-push-interval 60 1>/dev/null 2>&1 &
        echo start tk_mqtt_tongke ok.
    else
        echo tk_mqtt_tongke is running.
    fi

    # shellcheck disable=SC2006
    pidApp=`ps -ef | grep adc1 | grep -v grep | awk '{print $2}'`
    if [[ "${pidApp}" == "" ]]; then
        nohup /userdata/tk_mqtt_adc/adc1 --app-config adc1.yaml 1>/dev/null 2>&1 &
        echo start adc1 ok.
    else
        echo adc1 is running.
    fi

    # shellcheck disable=SC2006
    pidApp=`ps -ef | grep adc2 | grep -v grep | awk '{print $2}'`
    if [[ "${pidApp}" == "" ]]; then
        nohup /userdata/tk_mqtt_adc/adc2 --app-config adc2.yaml 1>/dev/null 2>&1 &
        echo start adc2 ok.
    else
        echo adc2 is running.
    fi

    # shellcheck disable=SC2006
    pidApp=`ps -ef | grep adc3 | grep -v grep | awk '{print $2}'`
    if [[ "${pidApp}" == "" ]]; then
        nohup /userdata/tk_mqtt_adc/adc3 --app-config adc3.yaml 1>/dev/null 2>&1 &
        echo start adc3 ok.
    else
        echo adc3 is running.
    fi

done
