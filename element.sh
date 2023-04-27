#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

#Verify if there is an argument.
if [ $# -eq 0 ]
  then
    echo "Please provide an element as an argument."

    else
   
  
   #Verify if it is an Atomic number.
    ATOMIC_NUMBER_VERIFY=$($PSQL "Select name from elements where atomic_number = $1 ")

   #If not an Atomic NUmber
    if [[ -z $ATOMIC_NUMBER_VERIFY ]]
      then

  
      #Verify if it is a Symbol
      SYMBOL_VERIFY=$($PSQL "Select name from elements where symbol = '$1' ")

      echo $SYMBOL_VERIFY
      #iF NOT A SYMBOL
      if [[ -z $SYMBOL_VERIFY ]]
      then
      
      echo " Not"

      fi
      


    fi

  
fi
