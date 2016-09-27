#!/bin/bash

set -ex

# Declaring arguments. The script takes two arguments:
# The input directory
# The output directory
inputDir="$1"
outputDir="$2"


template="$(<template.html)"
#Creating output directory if it does not exist.
if [ ! -d "$outputDir" ]; then
  mkdir -p "$outputDir"
fi



#For each file in input directory..
for file in "$inputDir"/*
do

  #Extracting file name from input file
  filename=$(basename "$file" ".txt")

  #Saving template to output directory
  echo "$template" > "$outputDir/""$filename.html"

	#Replacing title and body
  sed -i -e "s/{{title}}/$( head -n 1 "$file")/g" "$outputDir/$filename.html"
  sed -i -e "s/{{body}}/$( tail -n +3 "$file")/g" "$outputDir/$filename.html" #line 2 is empty
done