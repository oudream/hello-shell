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
