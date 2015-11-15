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
    awk -v lesson=$i -v action=i -f generate_sql.awk $RAW_PATH/lessons$i.txt > ../sql/lessons$i.sql
  done
}

function generate_update(){
  for i in `seq 1 25`
  do
    echo "Generating update sql statement for lessons $i"
    awk -v lesson=$i -v action=u -f generate_sql.awk $RAW_PATH/lessons$i.txt > ../sql/lessons$i.sql
  done
}

if [ $# -eq 0 ]
then
  usage
  exit 1  
fi

while getopts ":h i u" opt; do
  case $opt in
    h)
      usage
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


