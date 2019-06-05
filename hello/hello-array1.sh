#!/bin/bash

function testArray1() {
    NAME[0]="Zara"
    NAME[1]="Qadir"
    NAME[2]="Mahnaz"
    NAME[3]="Ayan"
    NAME[4]="Daisy"
    echo "First Index: ${NAME[0]}"
    echo "Second Index: ${NAME[1]}"
    echo "All Items: ${NAME[*]}"
    echo "All Items: ${NAME[@]}"
    echo "Count: ${#NAME[*]}"
    echo "Count: ${#NAME[@]}"
}
testArray1

function testArray2() {
    NAME[0]="Zara"
    NAME[1]="Qadir"
    NAME[2]="Mahnaz"
    NAME[3]="Ayan"
    NAME[4]="Daisy"
    # 切片
    arr2=${NAME[*]:1:3}
    echo "After Slice All Items: ${arr2[@]}"
    # 替换
    arr3=${NAME[*]/Ayan/Oudream}
    echo "After Replace All Items: ${arr3[@]}"
    # 删除
    arr4=${NAME[*]/Mahnaz/}
    echo "After Delete All Items: ${arr4[@]}"
}
testArray2

function testArray3() {
    my_array=(A B "C" D)
    echo "第一个元素为: ${my_array[0]}"
    echo "第二个元素为: ${my_array[1]}"
    echo "第三个元素为: ${my_array[2]}"
    echo "第四个元素为: ${my_array[3]}"
}
testArray3

function testArray4() {
    my_array[0]=A
    my_array[1]=B
    my_array[2]=C
    my_array[3]=D
    echo "数组元素个数为: ${#my_array[*]}"
    echo "数组元素个数为: ${#my_array[@]}"
    my_array+=(E)
    my_array+=(F)
    echo "数组元素个数为: ${#my_array[*]}"
    echo "数组元素个数为: ${#my_array[@]}"
}
testArray4

function testArray5() {
    local arr1=(a b c)
    if [[ "${arr1[@]}" =~ "a" ]] ;
    #if [["a" in ${arr1[*]}]];
    then
      echo 'a yes'
    else
      echo 'a no'
    fi
}
testArray5

function testArray6() {
    local arr1=(a b c)
    if echo "${arr1[@]}" | grep -w "a" &>/dev/null; then
        echo "Found"
    else
        echo "NO Found"
    fi
}
testArray6