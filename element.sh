#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"


SYMBOL=$1


DISPLAY() {
  echo $DATA | while IFS=" |" read ATOMIC_NUMBER SYMBOL NAME TYPE MASS MELTING_POINT BOILING_POINT 
do
  echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
done
}

#if no input
if [[ -z $1 ]]
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
      DATA=$($PSQL "SELECT e.atomic_number, e.symbol, e.name, t.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius FROM elements e INNER JOIN properties p ON e.atomic_number = p.atomic_number INNER JOIN types t ON p.type_id = t.type_id WHERE e.name = '$SYMBOL'")
      
      
      if [[ -z $DATA ]]
      then
        echo "I could not find that element in the database."
      else
        # display data
        DISPLAY
      fi 
    else
      # get data by atomic_name (1 or 2 letters)
      echo "atomic_name"
    fi
  else
    # get data by atomic_number
    echo "atomic_number"

  fi
fi

exit 
