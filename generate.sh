#!/bin/bash

set -ex
template=$(<template.html)
outputDir=$2
for file in $1/*
do
        
                if [ ! -d "$outputDir" ]; then
                        mkdir -p "$outputDir"
                fi
                outputFile="$(basename "$file" ".txt")"
                echo "$template+$outputFile"
                echo "$template" > "$outputDir/$outputFile.html"
                 sed -i -e "s/{{title}}/$( head -n 1 "$file")/g" "$outputDir/$outputFile.html" 
  sed -i -e "s/{{body}}/$(tail -n +3 "$file")/g" "$outputDir/$outputFile.html"

#sed -i -e "s/{{body}}/$(tail -n +2 $file)/g" $outputDir"/"$outputFile".html"
        
done
