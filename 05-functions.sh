#!/usr/bin/bash

#Functions Demo
test() {
  echo This is a sample function
  echo the value of a defined in main program is "$a"
  local c=100 # when the variable is set to local, it can used inside the function only, not in the main program
  echo the local variable value of c is $c
  b=200
}

a=10
test # call the function
echo value of variable b defined in function is $b
echo value of variable c defined as local variable in function is: $c
#we will not get output because the variable c is defined as a local variable inside the function
