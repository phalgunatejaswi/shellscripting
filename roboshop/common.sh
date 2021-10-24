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
ADD_APP_USER() {
  PRINT "Add Application User\t"
  id roboshop &>>"$LOG"
  if [ $? -ne 0 ]; then
    useradd roboshop &>>"$LOG"
  fi
  VALIDATE $?
}

DOWNLOAD_APP_CODE() {
  PRINT "Download Application Code"
  curl -s -L -o /tmp/"${COMPONENT}".zip "https://github.com/roboshop-devops-project/${COMPONENT}/archive/main.zip" &>>"$LOG"
  VALIDATE $?

  PRINT "Extract Application Code"
  cd /home/roboshop &>>"$LOG" && unzip -o /tmp/"${COMPONENT}".zip &>>"$LOG" && rm -rf "${COMPONENT}" &>>"$LOG" && mv "${COMPONENT}"-main "${COMPONENT}" &>>"$LOG"
  VALIDATE $?

}

FIX_PERMISSIONS() {
  PRINT "Fix App User Permissions"
  chown roboshop:roboshop /home/roboshop -R &>>"$LOG"
  VALIDATE $?
}

SYSTEMD_SERVICE() {
  PRINT "Update SystemD file\t"
  sed -i -e "s/MONGO_DNSNAME/mongodb.roboshop.internal/" -e "s/MONGO_ENDPOINT/mongodb.roboshop.internal/" -e "s/REDIS_ENDPOINT/redis.roboshop.internal/" -e "s/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/" -e "s/CARTENDPOINT/cart.roboshop.internal/" -e "s/DBHOST/mysql.roboshop.internal/" -e "s/CARTHOST/cart.roboshop.internal/" -e "s/USERHOST/user.roboshop.internal/" -e "s/AMQPHOST/rabbitmq.roboshop.internal/" /home/roboshop/"${COMPONENT}"/systemd.service &>>"$LOG" && mv /home/roboshop/"${COMPONENT}"/systemd.service /etc/systemd/system/"${COMPONENT}".service &>>"$LOG"
  VALIDATE $?

  PRINT "Start ${COMPONENT} Service\t"
  systemctl daemon-reload &>>"$LOG" && systemctl restart "${COMPONENT}" &>>"$LOG" && systemctl enable "${COMPONENT}" &>>"$LOG"
  VALIDATE $?
}

NODEJS() {
  PRINT "Install NodeJS\t\t"
  yum install nodejs make gcc-c++ -y &>>"$LOG"
  VALIDATE $?

  ADD_APP_USER
  DOWNLOAD_APP_CODE

  PRINT "Install NodeJS Dependencies"
  cd /home/roboshop/"${COMPONENT}" &>>"$LOG" && npm install --unsafe-perm &>>"$LOG"
  VALIDATE $?

  FIX_PERMISSIONS
  SYSTEMD_SERVICE
}


MAVEN() {
  PRINT "Install MAVEN\t\t"
  yum install maven -y &>>"$LOG"
  VALIDATE $?

  ADD_APP_USER
  DOWNLOAD_APP_CODE

  PRINT "Clean Maven Package\t"
  cd /home/roboshop/"${COMPONENT}" &>>"$LOG" && mvn clean package &>>"$LOG" && mv target/shipping-1.0.jar shipping.jar &>>"$LOG"
  VALIDATE $?

  FIX_PERMISSIONS
  SYSTEMD_SERVICE
}
PYTHON3() {
  PRINT "Install Python3\t\t"
  yum install python36 gcc python3-devel -y &>>"$LOG"
  VALIDATE $?

  ADD_APP_USER
  DOWNLOAD_APP_CODE

  PRINT "Install Python3 Dependencies"
  cd /home/roboshop/"${COMPONENT}" && pip3 install -r requirements.txt &>>"$LOG"
  VALIDATE $?

  PRINT "Update ${COMPONENT} user and group id in config file"
  UserID=$(id -u roboshop)
  GroupID=$(id -g roboshop)
  sed -i -e "/uid/ c uid = ${UserID}" -e "/gid/ c gid = ${GroupID}" payment.ini &>>"$LOG"
  VALIDATE $?

  FIX_PERMISSIONS
  SYSTEMD_SERVICE
}