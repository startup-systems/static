#!/bin/bash

set -ex

# YOUR CODE HERE

#Print two arguments
#1st is the input directory
#2nd is the output directory
a=1
input=$1
output=$2

#echo "Input Dir:" $input
#echo "Output Dir:" $output

#Create Directory if does not exist
mkdir -p  $2

echo "Input Directory" $inputFile

#Store output of title(first line) and body(last line)
# in input text to variable

for f in $1/*.txt
do

 echo $(basename $f)


 inputFile=$(basename $f .txt)
 title=$(sed -n '1p' $f)
 body=$(sed -n '3,$p' $f)

 echo $title
 echo "Body:" $body

 #Create html file with title and body 
 outputFile=$output/$inputFile.html

 sed -e "s/{{title}}/$title/" -e "s/{{body}}/$body/" template.html > "$outputFile"
 echo $outputFile $(file $outputFile)
done
