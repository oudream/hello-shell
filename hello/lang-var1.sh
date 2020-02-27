#!/bin/bash

vip3="vip3333" # can not have space
m=3
val=`eval echo '$'vip$m`
echo $val # vip3333

echo "---"

function show() {
    showVar1=showVar1Name # global scope
    local showVar2=showVar2Name # function scope
    ShowVar3=showVar2Name # case sensitive
	echo $1
	echo script:$0
	echo script:$1
	echo ${showVar1}
	echo ${showVar2}
	echo ${showVar3}
}

show "abc"

echo $1
echo "--- ---"
echo ${showVar1}
echo ${showVar2}
echo ${showVar3}


echo -e "\033[41;36m something here \033[0m" 
printf '\33[0n'

