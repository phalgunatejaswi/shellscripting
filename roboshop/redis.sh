#!/usr/bin/bash

source common.sh

PRINT "Install Redis Repos\t"
yum install epel-release yum-utils http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y &>>"$LOG"
VALIDATE $?

PRINT "Install Redis\t\t"
yum install redis -y --enablerepo=remi &>>"$LOG"
VALIDATE $?

PRINT "Update Redis Listener Address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf /etc/redis/redis.conf &>>"$LOG"
VALIDATE $?

PRINT "Start Redis\t\t"
systemctl enable redis &>>"$LOG" && systemctl restart redis &>>"$LOG"
VALIDATE $?

