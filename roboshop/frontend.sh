#!/usr/bin/bash

LOG=/tmp/roboshop.log
rm -rf $LOG
echo -n -e "Installing nginx\t\t..."
yum install nginx -y &>>$LOG
if [ $? -eq 0 ]; then
  echo -e "\e[32m done\e[0m"
else
  echo -e "\e[31m failed\e[0m"
fi

echo -n -e "Enabling nginx service\t\t..."
systemctl enable nginx &>>$LOG
if [ $? -eq 0 ]; then
  echo -e "\e[32m done\e[0m"
else
  echo -e "\e[31m failed\e[0m"
fi

echo -n -e "starting nginx service\t\t..."
systemctl start nginx &>>$LOG
if [ $? -eq 0 ]; then
  echo -e "\e[32m done\e[0m"
else
  echo -e "\e[31m failed\e[0m"
fi

# curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"