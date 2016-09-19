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
for f in "$1"/*.txt
do
    echo parsering file "$(basename "$f")"
    let count=count+1
    outfile="$2"/$(basename "$f" .txt).html
    sed "s/{{title}}/$(head -1 "$f")/;s/{{body}}/$(tail -n +3 "$f")/" ./template.html > $outfile
done
echo created "$count" files at $2
