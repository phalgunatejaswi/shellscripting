#!/usr/bin/bash

source common.sh

PRINT "Install Erlang\t"
yum list installed | grep Erlang &>>"$LOG"
if [ $? -ne 0 ]; then
  yum install https://github.com/rabbitmq/erlang-rpm/releases/download/v23.2.6/erlang-23.2.6-1.el7.x86_64.rpm -y &>>"$LOG"
fi
VALIDATE $?

PRINT "Setup RabbitMQ Repos"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>>"$LOG"
VALIDATE $?

PRINT "Install RabbitMQ"
yum install rabbitmq-server -y &>>"$LOG"
VALIDATE $?

PRINT "Start RabbitMQ\t"
systemctl enable rabbitmq-server &>>"$LOG" && systemctl start rabbitmq-server &>>"$LOG"
VALIDATE $?

PRINT "Create application user"
rabbitmqctl list_users | grep roboshop &>>"$LOG"
if [ $? -ne 0 ]; then
  rabbitmqctl add_user roboshop roboshop123  &>>"$LOG" && rabbitmqctl set_user_tags roboshop administrator  &>>"$LOG" && rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"  &>>"$LOG"
fi
VALIDATE $?