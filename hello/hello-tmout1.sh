#!/bin/bash
# fileName: timeOut_example.sh
TMOUT=3
echo -n "What's your name? "
read NAME
if [ -z "$NAME" ]; then
	echo "No Input Here!"
else
	echo "Your Name is $NAME"
fi
