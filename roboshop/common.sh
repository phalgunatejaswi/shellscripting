#!/usr/bin/bash

USER_ID=$(id -u)
if [ "$USER_ID" -ne 0 ]; then
  echo -e "\e[31mYou are not a root or sudo user to run this script\e[0m"
  exit 2
fi

LOG=/tmp/roboshop.log
rm -rf $LOG

VALIDATE() {
  if [ "$1" -eq 0 ]; then
    echo -e "\e[32m done\e[0m"
  else
    echo -e "\e[31m failed\e[0m"
    echo -e "\e[34mFor more information, check log file --> $LOG\e[0m"
    exit 1
  fi
}

PRINT() {
  echo -e "=============================\t$1\t=============================" &>>"$LOG"
  echo -n -e "$1\t\t..."
}

NODEJS() {
  PRINT "Install NodeJS\t\t"
  yum install nodejs make gcc-c++ -y &>>"$LOG"
  VALIDATE $?

  PRINT "Add Application User\t"
  id roboshop &>>"$LOG"
  if [ $? -ne 0 ]; then
    useradd roboshop &>>"$LOG"
  fi
  VALIDATE $?

  PRINT "Download Application Code"
  curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/roboshop-devops-project/{COMPONENT}/archive/main.zip" &>>"$LOG"
  VALIDATE $?

  PRINT "Extract Application Code"
  cd /home/roboshop &>>"$LOG" && unzip /tmp/${COMPONENT}.zip &>>"$LOG" && rm -rf ${COMPONENT} &>>"$LOG" && mv ${COMPONENT}-main ${COMPONENT} &>>"$LOG"
  VALIDATE $?

  PRINT "Install NodeJS Dependencies"
  cd /home/roboshop/${COMPONENT} &>>"$LOG" && npm install --unsafe-perm &>>"$LOG"
  VALIDATE $?

  PRINT "Fix App User Permissions"
  chown roboshop:roboshop /home/roboshop -R &>>"$LOG"
  VALIDATE $?

  PRINT "Update SystemD file\t"
  sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' 's/REDIS_ENDPOINT/redis.roboshop.internal/'/home/roboshop/${COMPONENT}/systemd.service &>>"$LOG" && mv /home/roboshop/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service &>>"$LOG"
  VALIDATE $?

  PRINT "Start ${COMPONENT} Service\t"
  systemctl daemon-reload &>>"$LOG" && systemctl start ${COMPONENT} &>>"$LOG" && systemctl enable ${COMPONENT} &>>"$LOG"
  VALIDATE $?
}
