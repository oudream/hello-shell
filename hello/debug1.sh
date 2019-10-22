#!/bin/bash

trap 'echo “before execute line:$LINENO, a=$a,b=$b,c=$c”' DEBUG
a=1
if [ "$a" -eq 1 ]
then
    b=2
else
    b=1
fi
c=3
echo "end"

function testDebug1() {
    trap 'echo “before execute line:$LINENO, a=$a,b=$b,c=$c”' DEBUG
    local a=1
    if [ "$a" -eq 1 ]
    then
       local b=2
    else
       local b=1
    fi
    local c=3
    echo "end"
}

testDebug1

function testDebug2() {
    trap 'echo “before execute line:$LINENO, a=$a,b=$b,c=$c”' DEBUG
    local a=5
    local b=6
    local c=7
}

testDebug2
