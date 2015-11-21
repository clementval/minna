#!/bin/bash

RAW_PATH="../raw_lessons_files/shokyuu_1"

function usage(){
  printf "usage: database.sh [-u|-i] [-h]\n"
  printf "\t-u  : Generate update scripts\n"
  printf "\t-i  : Generate insert scripts\n"
  printf "\t-h  : Display this message\n"
}


function generate_insert(){
  for i in `seq 1 25`
  do
    echo "Generating insert sql statement for lessons $i"
    awk -v lesson=$i -v action=i -f ./scripts/generate_sql.awk $RAW_PATH/lessons$i.txt > ./sql/lessons$i.sql
  done
}

function generate_update(){
  for i in `seq 1 25`
  do
    echo "Generating update sql statement for lessons $i"
    awk -v lesson=$i -v action=u -f ./scripts/generate_sql.awk $RAW_PATH/lessons$i.txt > ./sql/lessons$i.sql
  done
}

function create_db(){
  echo "Creating database ..."
  sqlite3 minna.sqlite < sql/create_schema.sql
 
  if [ ! -f sql/lessons1.sql ]
  then 
    echo "Creating sql files ..."
   generate_insert
  fi
  
  for i in `seq 1 25`
  do
    echo "Inserting values for lessons $i ..."
    sqlite3 minna.sqlite < ./sql/lessons$i.sql
  done
}

if [ $# -eq 0 ]
then
  usage
  exit 1  
fi

while getopts ":h i u c" opt; do
  case $opt in
    h)
      usage
      ;;
    c)
      create_db
      ;;
    i)
      generate_insert
      ;;
    u)
      generate_update
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done
 
exit 0


