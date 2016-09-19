#! /bin/bash

set -ex

output="$2"
if [ ! -d "$output" ]; then
 mkdir -p "$output"
fi

input="$1/*"
for file in $input ; do
 name=$(basename "$file" .txt)
 title=$(head -1 "$file")
 body=$(tail -1 "$file")
 sed -e 's/{{title}}/'"$title"'/g' -e 's/{{body}}/'"$body"'/g' template.html > "$2/$name.html"
done
