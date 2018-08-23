#!/bin/sh

function testSelect1() {
    select i in a b c d
    do
        case $i in 
            a)
                echo "Your choice is a"
            ;;
            b)
                echo "Your choice is b"
            ;;
            c)
                echo "Your choice is c"
            ;;
            d)
                echo "Your choice is d"
            ;;
            *)
                echo "Wrong choice! exit!"
                break 1
            ;;
        esac
    done
}

testSelect1
