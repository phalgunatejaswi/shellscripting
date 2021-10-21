#!/usr/bin/bash

LOG=/tmp/roboshop.log
rm -rf $LOG

VALIDATE() {
  if [ "$1" -eq 0 ]; then
    echo -e "\e[32m done\e[0m"
  else
    echo -e "\e[31m failed\e[0m"
    exit 1
  fi
}

PRINT() {
  echo -n -e "$1\t\t..."
}

USER_ID=$(id -u)
if [ "$USER_ID" -ne 0 ]; then
  echo -e "\e[31mYou are not a root or sudo user to run this script\e[0m"
  exit 2
fi

