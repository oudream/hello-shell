#!/bin/bash

echo ${'getenv "isdebug"'}

DEBUG()
{
    if [ "$isdebug" = "true" ]; then
        $@　　
    fi
    echo $#
    echo $isdebug
}

a=1

DEBUG echo "a=$a"

if [ "$a" -eq 1 ]
then
     b=2
else
     b=1
fi

DEBUG echo "b=$b"

c=3

DEBUG echo "c=$c"