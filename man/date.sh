#!/usr/bin/env bash


date --set="2015-09-30 10:05:59.990"

watch date && echo $1


datename=$(date +%Y%m%d-%H%M%S)

cat > script1.sh <<EOF
function shownow {
    clear;
    local now1=$(date '+%d/%m/%Y %H:%M:%S');
    echo "$now1";
}
shownow
EOF

watch ./script1.sh

watch -n X ./script1.sh

while sleep X; do ./script1.sh; done

while :; do clear; date; $1; sleep 2; done

watch date && echo $1

watch echo $(date '+%d/%m/%Y %H:%M:%S') && echo $?

watch clear && echo $(date '+%d/%m/%Y %H:%M:%S')
