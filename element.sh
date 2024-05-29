#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

echo "Please provide an element as an argument."

SYMBOL = $1

#if input is not a number
if [[ ! $SYMBOL =~ ^[0-9]+$ ]]
then
  
  #if input is greater than two letters
  if [[ ${#SYMBOL} -gt 2 ]]
  then
    # get data by full name
  else
    # get data by atomic_name (1 or 2 letters)
  fi
else
  # get data by atomic_number
fi