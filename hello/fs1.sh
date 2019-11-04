#!/bin/bash

function scanDir1()
{
    echo "scanDir1"
    for f in *.sh; do echo "Processing $f file.."; chmod +x $f; done
}
scanDir1


function scanDir2()
{
    echo "scanDir1"
    find . -maxdepth 1 -type d | while read dir; do count=$(find "$dir" -type f | wc -l); echo "$dir : $count"; done
}
scanDir2


function mkdir1() {
    echo "mkdir -p a/b/c"
    mkdir -p a/b/c
}
mkdir1


readFile1(){
    #while read line
    #do
    #    echo $line
    #done < file(待读取的文件)
    while read line; do echo ${line}; done < /opt/fff/tmp/a.txt
}
readFile1

readFile2(){
    #cat file(待读取的文件) | while read line
    #do
    #    echo $line
    #done
    cat /opt/fff/tmp/a.txt | while read line; do echo ${line}; done
}

readFile3(){
    #for line in `cat file(待读取的文件)`
    #do
    #    echo $line
    #done
    for line in `cat /opt/fff/tmp/a.txt`; do echo ${line};done
}