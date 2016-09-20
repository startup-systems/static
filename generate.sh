#!/bin/bash

set -ex

if [ $# -lt 2 ]; then
exit 1
fi


#exemplar directory does exist
if [ ! -d "$1" ]; then
exit 1
fi
# output does not exist, make it
  if [ ! -d "$2" ]; then
    mkdir -p "$2"
  fi

  #identify all files
  for file in $1/*.txt;
  do
    title="$(head "$file" -n 1)"

    COUNTER=0
    body=""
    numLines=$(wc -l < "$file")

    if [ $numLines -gt 3 ]; then
        while IFS= read -r line; do

            if [ $COUNTER -gt 1 ]; then
                if [ "$line" != "" ]; then
                body+="<p>$line</p>"
                fi
            fi

                let COUNTER=COUNTER+1
        done < "$file"
    else
        body="$(tail -n 1 "$file")"
    fi

    base="$(basename "$file" .txt)"
    sed "s|{{title}}|$title|g;s|{{body}}|$body|g" template.html > "$2/$base.html"
   done

exit 0

#references
# http://stackoverflow.com/questions/59838/check-if-a-directory-exists-in-a-shell-script
# http://stackoverflow.com/questions/26568952/how-to-replace-multiple-patterns-at-once-with-sed
# http://stackoverflow.com/questions/965053/extract-filename-and-extension-in-bash
# http://stackoverflow.com/questions/11349827/how-do-i-iterate-through-lines-in-an-external-file-with-shell
