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
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'Roboshop@123';" | mysql --connect-expired-password -uroot -p${DEFAULT_PASSWORD} &>>"$LOG"
#Next, We need to change the default root password in order to start using the database service.
## mysql_secure_installation
#
#You can check the new password working or not using the following command.
#
## mysql -u root -p
#
#Run the following SQL commands to remove the password policy.
#> uninstall plugin validate_password;
#Setup Needed for Application.
#As per the architecture diagram, MySQL is needed by
#
#Shipping Service
#So we need to load that schema into the database, So those applications will detect them and run accordingly.
#
#To download schema, Use the following command
#
## curl -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip"
#Load the schema for Services.
#
## cd /tmp
## unzip mysql.zip
## cd mysql-main
## mysql -uroot -pRoboShop@1 <shipping.sql