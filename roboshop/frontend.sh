#!/usr/bin/bash

LOG=/tmp/roboshop.log
rm -rf $LOG
echo -e "Installing nginx\t\t...\t\e[33mdone\e[0m"
yum install nginx -y &>>$LOG

echo "Enable nginx service"
systemctl enable nginx &>>$LOG

echo "starting nginx"
systemctl start nginx &>>$LOG

# curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"