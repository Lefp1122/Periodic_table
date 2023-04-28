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
      ELEMENT_DATA=$($PSQL "Select atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius  from properties as a inner join elements as b using( atomic_number) inner join types as c using( type_id) where name ilike '$1' or symbol ilike '$1';")
    
      #iF NOT available
      if [[ -z $ELEMENT_DATA ]]
        then
      
          echo "I could not find that element in the database."

          else 

          echo "$ELEMENT_DATA" | while IFS==\| read ATOMIC_NUMBER NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT
         do

          echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
         
         done
        
        fi

        
    

    else
  
      #Verify if it is an Atomic number.
      ELEMENT_DATA=$($PSQL "Select atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius  from properties as a inner join elements as b using( atomic_number) inner join types as c using( type_id) where atomic_number = $1;")
      
      #If not an Atomic NUmber
     if [[ -z $ELEMENT_DATA ]]
        then
      
          echo "I could not find that element in the database."

          else 

          echo "$ELEMENT_DATA" | while IFS==\| read ATOMIC_NUMBER NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT
         do

          echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
         
         done
        
        
      fi
      
      


    fi

  
fi
