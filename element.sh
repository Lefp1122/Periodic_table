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



        if [[ -z $NAME_VERIFY ]]
          then 
          echo "I could not find that element in the database."

          else 

          ELEMENT_DATA=$($PSQL "Select atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius  from properties as a inner join elements as b using( atomic_number) inner join types as c using( type_id) where b.name = '$1';")

          echo "$ELEMENT_DATA" | while IFS==\| read ATOMIC_NUMBER NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT
         do

          echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
         
         done
        
        fi

        else 

          ELEMENT_DATA=$($PSQL "Select atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius  from properties as a inner join elements as b using( atomic_number) inner join types as c using( type_id) where symbol = '$1';")

          echo "$ELEMENT_DATA" | while IFS==\| read ATOMIC_NUMBER NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT
         do

          echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
         
         done
      

        
      fi

    else
  
      #Verify if it is an Atomic number.
      ATOMIC_NUMBER_VERIFY=$($PSQL "Select name from elements where atomic_number = $1 ")
      
      
      #If not an Atomic NUmber
      if [[ -z $ATOMIC_NUMBER_VERIFY ]]
        then

        echo "I could not find that element in the database."

        else
      

          ELEMENT_DATA=$($PSQL "Select atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius  from properties as a inner join elements as b using( atomic_number) inner join types as c using( type_id) where atomic_number = $1;")

          echo "$ELEMENT_DATA" | while IFS==\| read ATOMIC_NUMBER NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT
         do

          echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
         
         done
      fi
      
      


    fi

  
fi
