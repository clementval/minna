#!/bin/bash

RAW_PATH="../raw_lessons_files/shokyuu_1"

for i in `seq 1 25`
do
  echo "Generating sql statement for lessons $i"
  awk -v lesson=$i -v action=i -f generate_sql.awk $RAW_PATH/lessons$i.txt > ../sql/lessons$i.sql
done
