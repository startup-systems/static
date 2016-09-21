#!/bin/bash

set -ex

#YOUR CODE HERE
#python3 generate.py $1 $2

inputFolder=$1
outputFolder=$2

if [ ! -d "$outputFolder" ]; then
    mkdir -p "$outputFolder"
fi

find "$inputFolder" -name '*.txt' > file.txt
while IFS='' read -r file || [[ -n "$file" ]]; do
    fullFilePath=$file
    baseFileName=$(basename "$fullFilePath" .txt)
    #baseFileName=`echo $baseFileName | cut -f 1 -d .`

    title=''
    body=''
    flag=0
    fileWithNewline="$(cat $fullFilePath)"\\n
    echo "$fileWithNewline" > tempFile.txt
    #echo "\n" >> "$fullFilePath"
    while read -r line; do
        check=$(echo "$line" | wc -c)
        if [ "$check" -eq 1 ] && [ "$flag" -eq 0 ]; then 
            flag=1
        elif [ $flag -eq 0 ]; then
            title="${line}"
        else
            if [ "$check" -eq 1 ];then
                body="<p>${line}<\/p>"
            else
                body="${body}${line}"
            fi
        fi
    done < tempFile.txt 

    #body="${body}"
    cp template.html "${outputFolder}/${baseFileName}.html"
    
    sed -i -e "s/{{title}}/$title/g" -e "s/{{body}}/$body/g" "${outputFolder}/${baseFileName}.html"
done < file.txt

#References:
#http://stackoverflow.com/questions/4321456/find-exec-a-shell-function
#http://tldp.org/LDP/abs/html/x23170.html
