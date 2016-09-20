#!/bin/bash

set -ex

# YOUR CODE HERE
outputDirectory=$2
template=$(<template.html)

for file in $1/*
do
        while read -r; do
                if [ ! -d "$outputDirectory" ]; then
                        mkdir -p "$outputDirectory"
                fi
                outputFile=$(basename "$file" ".txt")
                echo "$template" > "$outputDirectory/""$outputFile.html"
                sed -i -e "s/{{title}}/$( head -n 1 $file)/g" $outputDirectory"/"$outputFile".html"
                sed -i -e "s/{{body}}/$( tail -n +3 $file)/g" $outputDirectory"/"$outputFile".html"
        done<$file
done
