#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

#Verify if there is an argument.
if [ $# -eq 0 ]
  then
    echo "Please provide an element as an argument."

    else
   
   #if argument is a number
   if [[ ! $1 =~ ^[0-9]+$ ]]
      then

      #Verify if it is a Symbol
      SYMBOL_VERIFY=$($PSQL "Select name from elements where symbol = '$1' ")

      echo $SYMBOL_VERIFY
      #iF NOT A SYMBOL
      if [[ -z $SYMBOL_VERIFY ]]
        then
      
        #VERIFY if it is an element name
        NAME_VERIFY=$($PSQL "Select symbol from elements where name = '$1' ") 

        echo $NAME_VERIFY

        if [[ -z $NAME_VERIFY ]]
          then 
          echo "I could not find that element in the database."

          else 

          ELEMENT_DATA=$($PSQL " select 
        fi
      fi

    else
  
      #Verify if it is an Atomic number.
      ATOMIC_NUMBER_VERIFY=$($PSQL "Select name from elements where atomic_number = $1 ")
      
      
      #If not an Atomic NUmber
      if [[ -z $ATOMIC_NUMBER_VERIFY ]]
        then

        echo "I could not find that element in the database."
      fi
      
      


    fi

  
fi
