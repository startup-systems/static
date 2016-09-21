#!/bin/bash

#set -ex

input=$1
output=$2


echo "Input Dir: $input"
echo "Output Dir: $output"

#Create output directory structure if it doesn't exist.
mkdir -p $output

#Embedbed template
template='<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>{{title}}</title>
  </head>
  <body>
    {{body}}
  </body>
</html>
'

for filename in $input/*.txt; do
    message=""
    title=""
    i=0
    destFilename=$(basename $filename | sed "s/.txt/.html/")

    #echo "File: $filename"
    #echo "Dest Filename: $destFilename"
    echo "Archivo:"
    cat $filename
    echo -e "\n"
    
    while read -r line
    do
      echo "$i Linea: $line"
      if [ $i -eq 0 ] 
        then
        title=$line
      fi
      if [ $i -gt 1 ] 
        then
        if [ -z "$message" ]
            then
                message="$line"
            else
                message="$message\n$line"
        fi

      fi
      i=$(($i+1))
    done < $filename


    #echo "TITLE: $title"
    #echo "Message: $message"

    #Tricks to allow multiline messages with sed...
    echo -e "$(echo -e "$template" | sed "s@{{title}}@$title@" | sed "s@{{body}}@$message@")" > $output/$destFilename

    #echo "_____________________"
done
