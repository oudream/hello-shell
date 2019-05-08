#!/bin/bash
trap "func" 2
func() {
   read -p "Terminate theprocess? (Y/N): " input
   Array3=("Y" "U" "I") # is ok 1
   if [[ ${Array3[$input]} ]]; then # is ok 1
   # if [ $input in ("Y" "U" "I") ]; then 
        exit
        echo "exit"
   else
        echo $input
   fi
}

echo "You can input Ctrl+C interrupt the loop!"

for i in {1..10}; do
   echo $i
   sleep 1
done
