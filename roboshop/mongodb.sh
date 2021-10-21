#!/usr/bin/bash

source common.sh

PRINT "Setting up MongoDB Repository"
echo "mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc" >/etc/yum.repos.d/mongodb.repo
VALIDATE $?

PRINT "Install MongoDB\t"
yum install -y mongodb-org &>>"$LOG"
VALIDATE $?

PRINT "Updating MongoDB Listener Address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
VALIDATE $?

PRINT "Enable and Start MongoDB Service"
systemctl enable mongod && systemctl start mongod &>>"$LOG"
VALIDATE $?

PRINT "Download MongoDB Schema"
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip" &>>"$LOG"
VALIDATE $?

PRINT "Load MongoDB Schema"
cd /tmp && unzip -o mongodb.zip && cd mongodb-main && mongo < catalogue.js && mongo < users.js
VALIDATE $?
