#!/bin/bash

function modifyAttr1() {
    local dir=$1
#    for filepath in ${dir}/*.h; do
    for filepath in ${dir}/*.{h,c}; do
#        for ((i=0; i<=3; i++)); do
#            ./MyProgram.exe "$filepath" "Logs/$(basename "$filepath" .txt)_Log$i.txt"
#        done
        echo ${filepath}
#        echo $(basename ${filepath} *.*)
#        fn=$(basename ${filepath})
#        echo $(basename -- ${fn})
        filename=$(basename -- "$filepath")
        extension="${filename##*.}"
        filename="${filename%.*}"
        echo "$filename"
        echo "$extension"
    done
}

function modifyAttr2() {
    local dir=$1
    for filepath in ${dir}/*.{h,c}; do
        chmod -x ${filepath}
        echo ${filepath}" chmod result: "$?
    done
}

modifyAttr2 "/ddd/algorithm/struct-c"
