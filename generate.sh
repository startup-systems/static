#!/bin/bash

set -ex

# YOUR CODE HERE
#python3 generate.py $1 $2

inputFolder=$1
outputFolder=$2

if [ ! -d $outputFolder ]; then
    mkdir $outputFolder
fi

for file in $inputFolder*; do
    fullFilePath=$file
    baseFileName='basename $fullFilePath'
    baseFileName='echo $baseFileName | cut -f 1 -d .'

    title=''
    body=''
    flag=0
    while read line; do 
        if [ $(echo $line | wc -c) -eq 1 ]; then 
            flag=1
        elif [ $flag -eq 0 ]; then
            title="${title} ${line}"
        else
            body="${body}""${line}"$'<br>'
        fi
    done <$fullFilePath 

    cp template.html ${outputFolder}${baseFileName}.html
    
    sed -i 0 -e "s/{{title}}/${title/g" -e "s/{{body}}/$body/g" ${outputFolder}${baseFileName}.html

    rm "${outputFolder}${baseFileName}.html0"
done
