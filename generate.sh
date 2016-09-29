#!/bin/bash

set -ex
for filename in $1/*.txt; do
    title="$(head -n 1 "$filename")"
    body="$(tail -n 1 "$filename")"
    htmlfile="$(basename "$filename" .txt).html"
    mkdir -p "$2"
    echo "$filename" | sed -e 's#{{body}}#'"$body"'#g' -e 's#{{title}}#'"$title"'#g' "template.html" > "$2"/"$htmlfile"
done
