#!/bin/bash

#####################################################
# About: This script will create n number of files as per the date mention in the script...
# Inputs Required:
#       1. START_DATE="2024-02-04" & END_DATE="2024-03-04"
#
# Owner: Mohd Imran Mohd Yousuf
#
#####################################################

# Define start and end dates
START_DATE="2024-02-04"
END_DATE="2024-03-04"

# Convert start and end dates to timestamps
START_TIMESTAMP=$(date -d "$START_DATE" +%s)
END_TIMESTAMP=$(date -d "$END_DATE" +%s)

# Loop through dates
while [ "$START_TIMESTAMP" -le "$END_TIMESTAMP" ]; do
# Convert timestamp to date
        CURRENT_DATE=$(date -d "@$START_TIMESTAMP" +%Y-%m-%d)
# Create a text file with the date as its name
        touch "${CURRENT_DATE}.txt"
# Add data to the file
        echo "Data for ${CURRENT_DATE}" >> "${CURRENT_DATE}.txt"
# Set the timestamp of the file to match its name
        touch -d "${CURRENT_DATE} 00:00:00" "${CURRENT_DATE}.txt"
# Increment timestamp by day 1
        START_TIMESTAMP=$((START_TIMESTAMP + 86400))
done
