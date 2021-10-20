#!/usr/bin/bash

LOG=/tmp/roboshop.log
rm -rf $LOG
echo -e "Installing nginx"
yum install nginx -y &>>$LOG
echo -e "Installed nginx\t\t...\t\e[33mdone\e[0m"

echo "Enabling nginx service"
systemctl enable nginx &>>$LOG
echo -e "Enabled nginx service\t\t...\t\e[33mdone\e[0m"

echo "starting nginx"
systemctl start nginx &>>$LOG
echo -e "started nginx\t\t...\t\e[33mdone\e[0m"

# curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"