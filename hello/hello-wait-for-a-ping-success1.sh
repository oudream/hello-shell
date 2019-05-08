#!/bin/bash
printf "%s" "waiting for ServerXY ..."
while ! ping -c 1 -n -w 1 10.31.58.123 &> /dev/null
do
    sleep 1  
    printf "%c" "."
done
printf "\n%s\n"  "Server is back online"
