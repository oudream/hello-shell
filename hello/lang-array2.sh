#!/bin/bash

function testArray1() {
    array1=([value1]=1 value2 valueN) 

    # set up array of constants
    declare -A array
    for constant in foo bar baz
    do
        array[$constant]=1
    done

    # test for existence
    test1="bar"
    test2="xyzzy"

    if [[ ${array[$test1]} ]]; then echo "$test1 Exists"; else echo "$test1 does not exist"; fi    # Exists
    if [[ ${array[$test2]} ]]; then echo "$test2 Exists"; else echo "$test2 does not exist"; fi    # doesn't

    echo "${array[@]}"
}

testArray1

echo ${array[@]}
echo ${array1[@]}
