#! /bin/bash

#echo "100,200" >> locations_1km_2decimals.csv 
long=()
lat=() 
while IFS=, read -r field1 field2;
do
    lat+=("$field1")
    long+=("$field2")
done < locations_1km_2decimals.csv

for ((i=1;i<${#lat[@]};i++))
do
    echo ${lat[$i]} ${long[$i]};
done
	

