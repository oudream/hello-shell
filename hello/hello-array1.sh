#!/bin/sh

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
    echo "First Index: ${NAME[0]}"
    echo "Second Index: ${NAME[1]}"
}