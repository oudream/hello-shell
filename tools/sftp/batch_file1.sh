#!/bin/bash

source setEnv.sh

#PGM_LOGIN_STR=pgmlogrm@pgm.moe.edu.sg
PGM_LOGIN_STR=root@172.24.167.28

#Script environment settings
LOG_FILE=$BATCH_LOG_PATH/sftp_pgm2rm.log
TEMP_PATH=`date '+%Y%m%d%H%M%S'`

ARCHIEVED_FLAG=0

if [ $# -gt 0 ] ; then
	ARCHIEVED_FLAG=$1
fi

rm $BATCH_FILE
rm -rf $IBENS_LOG_PATH
mkdir -p $IBENS_LOG_PATH
mkdir -p $BATCH_LOG_PATH

echo "$0 starting moving files from PGM at `date '+%d/%m/%Y %H:%M:%S'`" >> $LOG_FILE
echo "$0 starting moving files from PGM at `date '+%d/%m/%Y %H:%M:%S'`"

#*****************
#Generate the SFTP batch scripts
#*****************

echo "cd $REMOTE_PATH" >> $BATCH_FILE
echo "lcd /standalone/log_parser/" >> $BATCH_FILE
echo "put techm_dummy.txt" >> $BATCH_FILE
echo "lcd $IBENS_LOG_PATH" >> $BATCH_FILE
echo "put techm_dummy.txt" >> $BATCH_FILE
echo "get rm_logs*.zip " >> $BATCH_FILE
echo "get rm_pftplogs*.zip " >> $BATCH_FILE
echo "get *moeuxhp*-aprm*.zip " >> $BATCH_FILE
echo "get techm* " >> $BATCH_FILE

if [ $ARCHIEVED_FLAG -eq "1" ]; then 
	echo "rename $REMOTE_PATH $REMOTE_PATH""_$TEMP_PATH " >> $BATCH_FILE
	echo "mkdir $REMOTE_PATH" >> $BATCH_FILE
fi

echo "quit" >> $BATCH_FILE

echo "Executing sftp batch file..... " >> $LOG_FILE
cat $BATCH_FILE >> $LOG_FILE

#*****************
#SFTP
#*****************
sftp -b $BATCH_FILE $PGM_LOGIN_STR >> $LOG_FILE 2>&1

echo "$0 ended moved files from PGM at `date '+%d/%m/%Y %H:%M:%S'` ">> $LOG_FILE
echo "$0 ended moved files from PGM at `date '+%d/%m/%Y %H:%M:%S'` "

exit 0