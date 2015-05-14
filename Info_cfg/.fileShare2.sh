#!/bin/bash

echo Sharing file : $1
RASP=" "

while : ; do 
  #RASP=`nc -l 22222 < $1 2>&1` ; 
  nc -l 22222 < $1 2>&1  
  echo PRIMIT:
  echo $RASP
  echo GATA --------------------  
done
