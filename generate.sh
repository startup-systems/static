#!/bin/bash

set -ex

# YOUR CODE HERE
outputDirectory=$2
template=$(<template.html)

for file in $1/*
do
         #Checking if the output directory already exixts, else creates one
		if [ ! -d "$outputDirectory" ]; then
                        mkdir -p "$outputDirectory"
                fi
	 #Extracting the file name from the input file
                outputFile=$(basename "$file" ".txt")
	 #Saving the template file as the output file in the output directory
                echo "$template" > "$outputDirectory/""$outputFile.html"
	 #Replacing the title and body using sed, head and tail
                sed -i -e "s/{{title}}/$( head -n 1 "$file")/g" "$outputDirectory/""$outputFile.html"
                sed -i -e "s/{{body}}/$( tail -n +3 "$file")/g" "$outputDirectory/""$outputFile.html"
done
