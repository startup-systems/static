#! /bin/bash

set -ex

output="$2"
if [ ! -d "$output" ]; then
  mkdir -p "$2"
fi

input="$1/*"
for file in $input ; do
  name="$(basename "$file" .txt)"
  title="$(head "$file" -n 1)"
  body="$(tail "$file" -n 1)"
  sed -e 's/{{title}}/'"$title"'/g' -e 's#{{body}}#'"$body"'#g' template.html > $2/$name.html
done
