#!/bin/sh

while(true)
do
    sleep 10

    cd /opt/teamviewer/tv_bin || continue

    # shellcheck disable=SC2006
    pidApp=`ps -ef | grep TeamViewer | grep -v grep | awk '{print $2}'`
    if [ "${pidApp}" = "" ]; then
        nohup /opt/teamviewer/tv_bin/TeamViewer -r 1>/opt/teamviewer/teamviewer.out 2>&1 &
        echo start teamviewer ok.
    else
        echo teamviewer is running.
    fi

done
