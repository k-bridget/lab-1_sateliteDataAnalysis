#!/bin/bash

#Ensure the analyzed_data directory exists
mkdir -p analyzed_data
#Define the input CSV file
INPUT_FILE="satelite_temperature_data.csv"
#Check if file exists
if [[ ! -f "$INPUT_FILE" ]]; then
	echo "Error: File $NPUT_FILE not found!"
	exit 1
fi
#Extract top 10 highest temperatures and save them
echo "Extracting top 10 highest temperatures..."
awk -F ',''NR==1 || $2+0==$2 {print $0 | "sort -t, -k2,2nr"}' "$INPUT_FILE" | head -n 11 > analyzed_data/highest_temp.csv
echo "Saved highest temperatures to analyzed_data/highest_temp.csv"
# Ask the user for a country name
read -p "Entner the country name to extract data: " COUNTRY_NAME
#Extract all data for the selected country. sort by humidity in descending order, and save
echo "Extracting data for $COUNTRY_NAME..."
awk -F ',' -v country="$COUNTRY_NAME" '$1 == country {print $0 | -t, -k3.3nr"}' "INPUT_FILE" > analyzed_data/humidity_data_${COUNTRY_NAME}.csv
echo "Saved humisity to analyzed_data/humidity_data_${COUNTRY_NAME}.csv

echo "Data extraction completed successfully!"
