#!/bin/bash

#set -ex

# Create Target directories recursively

mkdir -p "$2"

# Loop through all files in Input directory

for file in "$1"/*
do
    fname=$(basename "$file")
    printf "\nProcessing %s...\n" "$fname"
    str=$(echo "$fname" | rev | cut -d"." -f2-  | rev)
    cp template.html "$2/$str.html"
    
    # Parse all files line by line and save to an array
    
    i=0
    
    while IFS=$"\n" read -r line || [[ -n "$line" ]]; 
    do
        if [ "$line" != "" ]; then
            
            if [ "$i" == 0 ]; then
                sed -i "s/{{title}}/$line/g" "$2/$str.html"
            else
                sed -i "s/{{body}}/$line/g" "$2/$str.html"
            fi
        
        fi    
    i=$((i+1))
    done < "$file"
done
