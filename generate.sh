#!/bin/bash

set -ex

#YOUR CODE HERE
#python3 generate.py $1 $2

inputFolder=$1
outputFolder=$2

if [ ! -d "$outputFolder" ]; then
    mkdir -p "$outputFolder"
fi

for file in $inputFolder*; do
    fullFilePath=$file
    baseFileName=`basename "$fullFilePath" .txt`
    #baseFileName=`echo $baseFileName | cut -f 1 -d .`

    title=''
    #body='<p>'
    flag=0
    while read -r line; do 
        if [ $(echo "$line" | wc -c) -eq 1 ] && [ "$flag" -eq 0 ]; then 
            flag=1
        elif [ $flag -eq 0 ]; then
            title="${line}"
        else
            if [ $(echo "$line" | wc -c) -eq 1 ];then
                body="${body}<p>${line}</p>"
            else
                body="${body}${line}"
            fi
        fi
    done <"$fullFilePath" 

    body="${body}"
    cp template.html "${outputFolder}/${baseFileName}.html"
    
    sed -i -e "s/{{title}}/$title/g" -e "s/{{body}}/$body/g" "${outputFolder}/${baseFileName}.html"
    #sed -i -e "s/{https_ }/dd
    #rm "${outputFolder}/${baseFileName}.html0"
done
