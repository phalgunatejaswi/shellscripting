#!/usr/bin/bash

source common.sh

COMPONENT=catalogue
NODEJS

#PRINT "Install NodeJS\t\t"
#yum install nodejs make gcc-c++ -y &>>"$LOG"
#VALIDATE $?
#
#PRINT "Add Application User\t"
#id roboshop &>>"$LOG"
#if [ $? -ne 0 ]; then
#  useradd roboshop &>>"$LOG"
#fi
#VALIDATE $?
#
#PRINT "Download Application Code"
#curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>"$LOG"
#VALIDATE $?
#
#PRINT "Extract Application Code"
#cd /home/roboshop &>>"$LOG" && unzip /tmp/catalogue.zip &>>"$LOG" && rm -rf catalogue &>>"$LOG" && mv catalogue-main catalogue &>>"$LOG"
#VALIDATE $?
#
#PRINT "Install NodeJS Dependencies"
#cd /home/roboshop/catalogue &>>"$LOG" && npm install --unsafe-perm &>>"$LOG"
#VALIDATE $?
#
#PRINT "Fix App User Permissions"
#chown roboshop:roboshop /home/roboshop -R &>>"$LOG"
#VALIDATE $?
#
#PRINT "Update SystemD file\t"
#sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' /home/roboshop/catalogue/systemd.service &>>"$LOG" && mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service &>>"$LOG"
#VALIDATE $?
#
#PRINT "Start Catalogue Service\t"
#systemctl daemon-reload &>>"$LOG" && systemctl start catalogue &>>"$LOG" && systemctl enable catalogue &>>"$LOG"
#VALIDATE $?
