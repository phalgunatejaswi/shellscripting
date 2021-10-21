#!/usr/bin/bash

source common.sh

print "Installing nginx"
yum install nginx -y &>>$LOG
validate $?

print "Enabling nginx service"
systemctl enable nginx &>>$LOG
validate $?

print "starting nginx service"
systemctl start nginx &>>$LOG
validate $?

# curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"