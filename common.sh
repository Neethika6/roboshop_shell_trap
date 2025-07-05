#!/bin/bash

START_TIME=$(date +%s)
echo "Script Started at:$(date)"
#Check if you are running with root or not
USER_ID=$(id -u) #if the value is 0 then you are running with root 
SCRIPT_DIR=$PWD
LOG_DIR="/var/log/roboshop_logs"
SCRIPT_NAME="$(echo $0 | cut -d "." -f1)"
LOG_FILE="$LOG_DIR/$SCRIPT_NAME.log"

#Creates a dir if not present -p will not throw error if the dir is already present
mkdir -p /var/log/roboshop_logs

check_root()
{
    #if the value is 0 then you are running with root
    if [ $USER_ID == 0 ]
    then
        echo "YOU ARE IN ROOT" | tee -a $LOG_FILE
    else
        echo "ERROR:PLEASE SWITCH TO ROOT" | tee -a $LOG_FILE
        exit 1  #Script will not execute any lines if you are not in the ROOT
    fi
}
check_time()
{
    END_TIME=$(date +%s)
    echo "Script Completed at:$(date)"
    TOTAL_TIME=$(($END_TIME - $START_TIME))
    echo "Total time taken: $TOTAL_TIME seconds"
}

failure()
{
    echo "Failed at $1:$2"
}