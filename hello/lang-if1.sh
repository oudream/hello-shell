#!/bin/bash

function strcmp ()
{
    [ "$1" = "$2" ] && return 0

    [ "${1}" '<' "${2}" ] > /dev/null && return -1

    return 1
}

# Error:    if [[ ${str1} =='x' ]]; then
# OK:       if [[ ${str1} == 'x' ]]; then
# Error:    if [[${str1} == 'x' ]]; then
# OK:       if [ ${str1} == 'x' ]; then
# so: space is important
function testIf1() {
    local arr1=(a b c)
    if [[ "${arr1[@]}" =~ "a" ]] ;
    #if [["a" in ${arr1[*]}]];
    then
      echo 'a yes'
    else
      echo 'a no'
    fi
    for constant in ${arr1[@]}
    do
        if [[ ${constant} == 'a' ]]; then
            echo 'yes'${constant}
        else
            echo 'no'${constant}
        fi
    done

    echo '---'
    strcmp 'x' 'b'
    echo $?

    str1='x'
    if [[ ${str1} == 'x' ]]; then
        echo 'yes'${str1}
    else
        echo 'no'${str1}
    fi
}
testIf1
