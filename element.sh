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