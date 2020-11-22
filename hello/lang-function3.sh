#!/bin/bash

# https://stackoverflow.com/questions/8742783/returning-value-from-called-function-in-a-shell-script
# Echo strings
lockdir="somedir"
testlock(){
    retval=""
    if mkdir "$lockdir"
    then # Directory did not exist, but it was created successfully
         echo >&2 "successfully acquired lock: $lockdir"
         retval="true"
    else
         echo >&2 "cannot acquire lock, giving up on $lockdir"
         retval="false"
    fi
    echo "$retval"
}

retval=$( testlock )
if [ "$retval" == "true" ]
then
     echo "directory not created"
else
     echo "directory already created"
fi

# Return exit status
lockdir="somedir"
testlock(){
    if mkdir "$lockdir"
    then # Directory did not exist, but was created successfully
         echo >&2 "successfully acquired lock: $lockdir"
         retval=0
    else
         echo >&2 "cannot acquire lock, giving up on $lockdir"
         retval=1
    fi
    return "$retval"
}

testlock
retval=$?
if [ "$retval" == 0 ]
then
     echo "directory not created"
else
     echo "directory already created"
fi


# Share variable
lockdir="somedir"
retval=-1
testlock(){
    if mkdir "$lockdir"
    then # Directory did not exist, but it was created successfully
         echo >&2 "successfully acquired lock: $lockdir"
         retval=0
    else
         echo >&2 "cannot acquire lock, giving up on $lockdir"
         retval=1
    fi
}

testlock
if [ "$retval" == 0 ]
then
     echo "directory not created"
else
     echo "directory already created"
fi
