#! /bin/bash

long=()
lat=() 
while IFS=, read -r field1 field2;
do
    lat+=("$field1")
    long+=("$field2")
done < inputs.csv

for ((i=1;i<${#lat[@]};i++))
do
    echo ${lat[$i]} ${long[$i]};
done
	

#to append csv file
#echo "100,200" >> inputs.csv 
