#!/usr/bin/bash

source common.sh

PRINT "Install NodeJS\t"
yum install nodejs make gcc-c++ -y &>>"$LOG"
VALIDATE $?

PRINT "Add Application User"
id roboshop &>>"$LOG"
if [ $? -ne 0 ]; then
  useradd roboshop &>>"$LOG"
fi

PRINT "Download Application Code"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>"$LOG"
VALIDATE $?

PRINT "Extract Application Code"
cd /home/roboshop &>>"$LOG" && unzip /tmp/catalogue.zip &>>"$LOG" && rm -rf catalogue &>>"$LOG" && mv catalogue-main catalogue &>>"$LOG"
VALIDATE $?

PRINT "Install NodeJS Dependencies"
cd /home/roboshop/catalogue &>>"$LOG" && npm install --unsafe-perm &>>"$LOG"
VALIDATE $?

PRINT "Fix Permissions to Application User"
chown roboshop:roboshop /home/roboshop -R
VALIDATE $?

# mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
# systemctl daemon-reload
# systemctl start catalogue
# systemctl enable catalogue