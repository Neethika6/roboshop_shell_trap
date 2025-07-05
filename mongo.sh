#!/bin/bash

set -e
source ./common.sh
appaname=mongodb

trap 'failure ${LINENO} "${BASH_COMMAND}"' ERR
check_root

#MONGODB SETUP
echo "Copy MONGO.repo file to the repository directory"
cp $SCRIPT_DIR/mongo.repo /etc/yum.repos.d/mongo.repo


echo "Installing the MONGODB"
dnf install mongodb-org -y &>>$LOG_FILE


echo "Enable and start the mongodb instance"
systemctl enable mongod 


systemctl start mongod


#Update the mongod.conf file to open the port 

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf


systemctl restart mongod


check_time



