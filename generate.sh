#!/bin/bash
set -ex
src=$1
des=$2
mkdir -p "$des"

for file in $src/*.txt
do
	title="$(head -n 1 "$file")"
	body="$(tail -n +3 "$file")"
  filename="$(basename "$file" .txt)"
	sed 's#{{title}}#'"$title"'#g;s#{{body}}#'"$body"'#g' template.html > "$des"/"$filename".html
done
