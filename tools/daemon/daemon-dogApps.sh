#!/bin/sh

while [ 1 ]
do
    ps -fe | grep -v grep | grep /usr/sbin/appMBMid

    if [ $? -eq 1 ]
    then
        /usr/sbin/appMBMid &
        #echo "[dogApps-$?]:restart appMBMid ! "
    fi

    sleep 20s
done