#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# No argument case
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
  exit
fi
# Determine search condition
if [[ $1 =~ ^[0-9]+$ ]]
then
  CONDITION="atomic_number=$1"
elif [[ $1 =~ ^[A-Za-z]{1,2}$ ]]
then
  CONDITION="symbol='$1'"
else
  CONDITION="name='$1'"
fi
# Fetch data
ELEMENT_DATA=$($PSQL "SELECT e.atomic_number, e.name, e.symbol, t.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius 
                      FROM elements e 
                      JOIN properties p USING(atomic_number) 
                      JOIN types t USING(type_id) 
                      WHERE $CONDITION")
# Handle invalid input
if [[ -z $ELEMENT_DATA ]]
then
  echo "I could not find that element in the database."
  exit
fi