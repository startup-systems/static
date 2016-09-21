#!/bin/bash

# set -ex

# YOUR CODE HERE
if (( $# != 2 )); then
    echo "Illegal Number of Parameters"
    echo "Synopsis"
    echo "./generate.sh [-input] [-output]"
    exit
fi

count=0
mkdir -p "$2"
for f in "$1"/*
do
    echo parsering file "$(basename "$f")"
    let count=count+1
    outfile="$2"/$(basename "$f" .txt).html

    if [ "$(sed -n '$=' "$f")" -gt 3 ]; then
        sed "1,/^$/d" "$f" | sed "/^$/d" > ./temp.txt
        sed "s/{{title}}/$(head -1 "$f")/;s/{{body}}/<p>$(head -n 1 ./temp.txt)<\/p>{{body}}/" ./template.html > "$outfile"
        i=2
        until [ $i -gt "$(sed -n '$=' ./temp.txt)" ]
        do
                sed -i "s/{{title}}/$(head -1 "$f")/;s/{{body}}/<p>$(sed -n "$i"p "./temp.txt")<\/p>{{body}}/" "$outfile"
                ((i++))
        done
        sed -i "s/{{body}}//" "$outfile"
    elif [ "$(grep -c 'https:\/\/[^\s]*[com\b]' "$f")" == 1 ]; then
        url="$(grep -o "https:\/\/[^\s]*[com\b]" "$f")"
        sed "s|{{title}}|$(head -1 "$f")|;s|{{body}}|$(tail -n 1 "$f")|" ./template.html > "$outfile"
        sed -i "s|$url|\<a\ href=\"$url\"\>$url\</a\>|" "$outfile"
    else
        sed "s/{{title}}/$(head -1 "$f")/;s/{{body}}/$(tail -n 1 "$f")/" ./template.html > "$outfile"
    fi
done
echo created "$count" files at "$2"
exit 0
