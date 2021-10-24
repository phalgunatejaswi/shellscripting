#!/usr/bin/bash

source common.sh

PRINT "Setup MySQL Repo"
echo '[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/
enabled=1
gpgcheck=0' > /etc/yum.repos.d/mysql.repo
VALIDATE $?

PRINT "Install MySQL"
yum install mysql-community-server -y &>>"$LOG"
VALIDATE $?

PRINT "Start MySQL service"
systemctl enable mysqld &>>"$LOG" && systemctl start mysqld  &>>"$LOG"
VALIDATE $?

PRINT "Reset MySQL root password"
DEFAULT_PASSWORD=$(grep 'temporary password' /var/log/mysqld.log | awk '{print $NF}')
mysql -uroot -pRoboshop@123 -e exit &>>"$LOG"
if [ $? -ne 0 ]; then
  mysql -uroot -p${DEFAULT_PASSWORD} --connect-expired-password -e "SET PASSWORD = PASSWORD('Roboshop@123');"
  #echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'Roboshop@123';" | mysql --connect-expired-password -uroot -p${DEFAULT_PASSWORD} &>>"$LOG"
fi
VALIDATE $?

PRINT "Uninstall MySQL Password Policy"
mysql -uroot -pRoboshop@123 -e "SHOW PLUGINS" 2>>"$LOG" | grep -i validate_password &>>"$LOG"
if [ $? -eq 0 ]; then
  echo "uninstall plugin validate_password;" | mysql -uroot -pRoboshop@123 &>>"$LOG"
fi
VALIDATE $?

PRINT "Download Shipping Service Schema"
curl -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip" &>>"$LOG"
VALIDATE $?

PRINT "Load Shipping Service Schema"
cd /tmp/ && unzip mysql.zip &>>"$LOG" && cd mysql-main && mysql -uroot -pRoboshop@123 <shipping.sql &>>"$LOG"
VALIDATE $?
