#!/bin/sh

let filemaxsize=1024*1024*50
filename=/userdata/tk-iec104-server/tkiec104_server.log
program=/userdata/tk-iec104-server/tkiec104_server

while(true)
do
    sn=`ps -ef | grep ${program} | grep -v grep | awk '{print $2}'`
    if [[ "${sn}" == "" ]]; then
        cp /userdata/tk-iec104-server/*.log /userdata/tk-iec104-server/logs/
        rm /userdata/tk-iec104-server/*.log
        nohup ${program} --network-name eth1 1>> /userdata/tk-iec104-server/tkiec104_server.log 2>&1 &
#           echo start ok !
#       else
#           echo running
    fi

    filesize=`ls -l ${filename} | awk '{print $5}'`
    if [[ ${filesize} -ge ${filemaxsize} ]]; then
        cp /userdata/tk-iec104-server/tkiec104_server.log /userdata/tk_iec104_server/logs/
        cat /dev/null > /userdata/tk-iec104-server/tkiec104_server.log
    fi
    sleep 10
done
