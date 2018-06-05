#!/bin/bash


#Extract keys from csv and format properly
ARRAY=()
while IFS=',' read -r last first || [ -n "$last" ]
do
    str="$last $first"
    ARRAY+=(${str:8:32})
done < keys/encryption-keys.csv


#For each PDF file in the directory, append keys to a textfile for openssl 
#to use and then run encryption command for each pdf and key
i=0
for entry in pdf/*; do
    echo ${ARRAY[$i]} 
    filename=$(basename $entry).enc
    echo ${ARRAY[$i]} > text.txt
    echo $filename
    openssl enc -aes-256-cbc -a -salt -in $entry -out $filename -pass file:./text.txt
    i=$i+1
done

#Clean up
rm text.txt
  
