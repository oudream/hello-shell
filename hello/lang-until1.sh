#!/usr/bin/env bash

helloUntil1(){
    sum=0

    i=1

    until (( i > 100 ))
    do
         let "sum+=i"
         let "i += 2"
    done

    echo "sum=$sum"
}
helloUntil1

