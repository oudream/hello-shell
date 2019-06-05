#!/bin/bash

function testFor1() {
    for (( i = 0 ; i < 10 ; i++ ))
    do
        let j=${i}+2
        echo "Element [$i]: "
    done
}

testFor1

