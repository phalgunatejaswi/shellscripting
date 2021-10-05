#!/usr/bin/bash

#Static Variable
A=15
echo $A

# Providing variable content dynamically
echo Dynamic Variale
NO_OF_USERS_CONNECTED=$(who |wc -l)
echo Number of users connected is $NO_OF_USERS_CONNECTED

DATE_TIME=$(date +"%D %T")
echo current date and time is $DATE_TIME