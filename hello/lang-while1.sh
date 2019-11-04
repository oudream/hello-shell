#!/usr/bin/env bash

helloWhile1(){
    sum=0

    i=1

    while(( i <= 100 ))
    do
         let "sum+=i"
         let "i += 2"
    done

    echo "sum=$sum"
}
#helloWhile1


helloWhile2(){
    echo "Please input the num(1-10) "
    read num

    while [[ "$num" != 4 ]]
    do
       if [ "$num" -lt 4 ]
       then
            echo "Too small. Try again!"
            read num
       elif [ "$num" -gt 4 ]
       then
             echo "To high. Try again"
             read num
       else
           exit 0
        fi
    done

    echo "Congratulation, you are right! "
}
#helloWhile2

helloWhile3(){
    echo "Please input the num "
    read num

    sum=0
    i=1

    signal=0

    while [[ "$signal" -ne 1 ]]
    do
        if [ "$i" -eq "$num" ]
        then
           let "signal=1"
           let "sum+=i"
           echo "1+2+...+$num=$sum"
        else
           let "sum=sum+i"
           let "i++"
        fi
    done
}
helloWhile3