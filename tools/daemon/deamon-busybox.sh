#!/bin/sh

iNum=10
time=600
program=/usr/bin/tk-app/app/tkiec104_server

while(true)
do
  sn=`ps -ef | grep $program | grep -v grep | awk '{print $2}'`
  if [[ "${sn}" == "" ]]; then
#               busybox cp *.log /tmp/
#               busybox rm *.log
#                busybox nohup ${program} 1>> tkiec104_server.log 2>&1 &
    busybox nohup /usr/bin/tk-app/app/tkiec104_server 1>> /tkiec104_server.log 2>&1 &
    echo start ok !
  else
    echo running
  fi
  if [[ $iNum -le 0 ]]; then
    busybox cp /tkiec104_server.log /tmp/
#    busybox rm tkiec104_server.log
    echo > /tkiec104_server.log
    let iNum=10
    echo $iNum
  fi
  let "iNum--"
  echo $iNum
  busybox sleep 5
  echo $iNum
done
