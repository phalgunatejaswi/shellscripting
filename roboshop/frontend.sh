#!/usr/bin/bash

source common.sh

PRINT "Installing nginx"
yum install nginx -y &>>"$LOG"
VALIDATE $?

PRINT "Enabling nginx service"
systemctl enable nginx &>>"$LOG"
VALIDATE $?

PRINT "starting nginx service"
systemctl start nginx &>>"$LOG"
VALIDATE $?

# curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"