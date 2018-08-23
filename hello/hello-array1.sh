#!/bin/bash

function testArray1() {
      NAME[0]="Zara"
      NAME[1]="Qadir"
      NAME[2]="Mahnaz"
      NAME[3]="Ayan"
      NAME[4]="Daisy"
      echo "First Index: ${NAME[0]}"
     echo "Second Index: ${NAME[1]}"
}

testArray1

function testArray2() {
    NAME[0]="Zara"
    NAME[1]="Qadir"
    NAME[2]="Mahnaz"
    NAME[3]="Ayan"
    NAME[4]="Daisy"
    echo "First Method: ${NAME[*]}"
    echo "Second Method: ${NAME[@]}"
}

testArray2

function testArray3() {
    my_array=(A B "C" D)
    echo "第一个元素为: ${my_array[0]}"
    echo "第二个元素为: ${my_array[1]}"
    echo "第三个元素为: ${my_array[2]}"
    echo "第四个元素为: ${my_array[3]}"
}

function testArray4() {
    my_array[0]=A
    my_array[1]=B
    my_array[2]=C
    my_array[3]=D
    echo "数组元素个数为: ${#my_array[*]}"
    echo "数组元素个数为: ${#my_array[@]}"
}

function testArray5() {
    local arr1=(a b c)
    if ['a' in ${arr1[*]}];
    then
      echo 'a yes'
    else
      echo 'a no'
    fi
}

testArray5