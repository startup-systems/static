#!/bin/bash

set -ex

for i in "$1"/*;
do

mkdir -p "$2"
sed "s/{{title}}/$(head -1 $i)/g" template.html | sed "s/{{body}}/$(tail +3 $i | sed -e ':a' -e '$!{' -e 'N' -e 'ba' -e '}' -e 's/\n/^/g' | sed 's/\//~/g')/g" | tr '~' '/' | tr '^' '\n' > $(echo "$2"/$(basename $i | cut -d '.' -f1).html) ;
done
