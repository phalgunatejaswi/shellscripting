#!/usr/bin/bash

source common.sh

PRINT "Installing nginx"
yum install nginx -y &>>"$LOG"
VALIDATE $?

PRINT "Download Frontend"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>"$LOG"
VALIDATE $?

PRINT "Remove Old Htdocs"
cd /usr/share/nginx/html && rm -rf * &>>"$LOG"
VALIDATE $?

PRINT "unzip Frontend Archive"
unzip /tmp/frontend.zip &>>"$LOG" && mv frontend-main/* . &>>"$LOG" && mv static/* . &>>"$LOG" && rm -rf frontend-master static &>>"$LOG"
VALIDATE $?

PRINT "Copy RoboShop Config"
mv localhost.conf /etc/nginx/default.d/roboshop.conf &>>"$LOG"
VALIDATE $?

PRINT "Update RoboShop Config"
sed -i -e '/catalogue/ s/localhost/catalogue.roboshop.internal/' -e '/user/ s/localhost/user.roboshop.internal/' /etc/nginx/default.d/roboshop.conf &>>"$LOG"
VALIDATE $?

PRINT "Enabling nginx service"
systemctl enable nginx &>>"$LOG"
VALIDATE $?

PRINT "starting nginx service"
systemctl restart nginx &>>"$LOG"
VALIDATE $?
