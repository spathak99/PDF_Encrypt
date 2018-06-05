#!/bin/bash


ARRAY=()
while IFS=',' read -r last first || [ -n "$last" ]
do
    str="$last $first"
    ARRAY+=(${str:8:32})
done < keys/encryption-keys.csv



i=0
for entry in pdf/*; do
    echo ${ARRAY[$i]} 
    filename=$(basename $entry).enc
    echo ${ARRAY[$i]} > text.txt
    echo $filename
    openssl enc -aes-256-cbc -a -salt -in $entry -out $filename -pass file:./text.txt
    i=$i+1
done
rm text.txt
  
