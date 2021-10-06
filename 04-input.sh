#!/usr/bin/bash

#Input while execution of script

# read -p 'Enter your name:' NAME
# echo Your name is $NAME

#However Input while execution can only used when the scripts are run manually
#It is very rarely or never used in automation tasks
#So, the read command is not useful automation

#Inputs before execution of script
#Inputs can be given using special variables 0, n, *, @, #
 echo $0 # to get the file name of the script
 echo $1 # to get the first argument passed when we run the script
 # $n is the nth argument passed while we run the script.
 # Example: bash 04-input.sh 123 xyz abc  ---> $1 is 123, $3 is abc
 echo $* # to get all the arguments passed when we run the script
 echo $@ # to get all the arguments passed when we run the script
 echo $# # to get the number arguments passed when we run the script

