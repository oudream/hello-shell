#!/bin/sh
vip3="vip3333"
m=3
val=`eval echo '$'vip$m`
echo $val # vip3333


function show() {
	echo $1
	echo script:$0
	echo script:$1
}

show "abc"

echo $1


echo -e "\033[41;36m something here \033[0m" 
printf '\33[0n'

