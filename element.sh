#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"


SYMBOL=$1

#if no input
if [[ -z S1 ]]
then 
  echo "Please provide an element as an argument."
else
  #if input is not a number
  if [[ ! $SYMBOL =~ ^[0-9]+$ ]]
  then
    
    #if input is greater than two letters
    if [[ ${#SYMBOL} -gt 2 ]]
    then
      
      # get data by full name
      read -r atomic_number symbol name type atomic_mass melting_point_celsius boiling_point_celsius <<< $($PSQL "SELECT e.atomic_number, e.symbol, e.name, t.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius FROM elements e INNER JOIN properties p ON e.atomic_number = p.atomic_number INNER JOIN types t ON p.type_id = t.type_id WHERE e.name = '$SYMBOL'")

      
      if [[ -z $name ]]
      then
        echo "I could not find that element in the database."
      else
        # display data
        echo "full name"
        #echo "The element with atomic number $atomic_number is $name ($symbol). It's a $type, with a mass of $atomic_mass amu. $name has a melting point of $melting_point_celsius celsius and a boiling point of $boiling_point_celsius celsius."
      fi 
    else
      # get data by atomic_name (1 or 2 letters)
      echo "atomic_name"
    fi
  else
    # get data by atomic_number
    echo "atomic_number"

  fi
exit 0