#!/bin/bash
set -e
#Make directories recursively
mkdir -p "$2"

for f in $1/*
do
    count=0
    echo "Converting $f to $(basename -s .txt "$f").html"
    #Read line by line
    while IFS='' read -r temp || [[ -n "$temp" ]]; do
        #echo "Text read from file: $temp"
        if [ $count == 0 ]
        then
            title=$temp
        elif [ $count -ge 2 ]
        then
            body="$temp" #concatenate each subsequent line
        fi
        
        count=$((count+1))
    done < "$f"
    #Export using template
    echo "<!DOCTYPE html> \
            <html> \
            <head> \
                <meta charset=\"utf-8\"> \
                <title>$title</title> \
            </head> \
            <body>$body</body> \
            </html>" > "$2/$(basename -s .txt "$f").html"
done

#Sources:
#http://stackoverflow.com/questions/10929453/read-a-file-line-by-line-assigning-the-value-to-a-variable