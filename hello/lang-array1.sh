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

function strcmp ()
{
    [ "$1" = "$2" ] && return 0

    [ "${1}" '<' "${2}" ] > /dev/null && return -1

    return 1
}

function testArray5() {
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
    i1=4
    if ((${i1} < 5)); then # ok
#    if (${i1} < 5); then # error
#    if [[ ${i1} < 5 ]]; then # ok
#    if [[ ${str1} == 'x' ]]; then # ok
#    if [[ ${str1} == 'a' ]]; then # ok
        echo 'yes'${str1}
    else
        echo 'no'${str1}
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


testArray7(){
    local Array1=( "key1" "key2" "key3" "key4" "key5" "key6" "key7" "key8" "key9" "key10" )
    local Array2=( "key1" "key2" "key3" "key4" "key5" "key6" )
    local Array3=()
    for i in "${Array1[@]}"; do
        skip=
        for j in "${Array2[@]}"; do
            [[ $i == $j ]] && { skip=1; break; }
        done
        [[ -n $skip ]] || Array3+=("$i")
    done
    declare -p Array3
}
testArray7

function testArray8() {
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
testArray8

testArray8_1(){
    echo ${array[@]}
    echo ${array1[@]}
}
testArray8_1

testArraySum1(){
    array=( 2, 4, 6, 8, 10, 12, 14, 16, 18, 20 )
#    I've done it this way but I want to use an array and then sum up the numbers in a shell script.
    num1=2
    num2=4
    num3=8
    num4=10
    num5=12
    num6=14
    num7=16
    num8=18
    num9=20
    sum=$((num1+num2+num3+num4+num5+num6+num7+num8+num9))
    echo "The sum is: $sum"
}
testArraySum1
testArraySum1_1(){
    array=( 2, 4, 6, 8, 10, 12, 14, 16, 18, 20)
    echo "${array[@]/,/+}" | bc
}
testArraySum1_1

testArrayExist1(){
    if [[ " ${arr[*]} " == *" d "* ]]; then
        echo "arr contains d"
    fi
}
array_contains () {
    local seeking=$1; shift
    local in=1
    for element; do
        if [[ $element == "$seeking" ]]; then
            in=0
            break
        fi
    done
    return $in
}
testArrayExist2(){
    arr=(a b c "d e" f g)
    array_contains "a b" "${arr[@]}" && echo yes || echo no    # no
    array_contains "d e" "${arr[@]}" && echo yes || echo no    # yes
}