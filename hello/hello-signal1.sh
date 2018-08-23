#!/bin/bash
trap "func" 2
func() {
   read -p "Terminate theprocess? (Y/N): " input
   if [ $input in ("Y" "U" "I") ]; then
        exit
        echo "exit"
   else
        echo $input
   fi
}
for i in {1..10}; do
   echo $i
   sleep 1
done
