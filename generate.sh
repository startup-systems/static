#!/bin/bash

set -ex

#exemplar directory does exist
if [ -d "$1" ]; then
  # output does not exist, make it
  if [ ! -d "$2" ]; then
    mkdir "$2"
  fi

  #identify all files
  for file in $1/*.txt;
  do
    title="$(head $file -n 1)"
    body="$(tail $file -n 1)"
    base="$(basename $file .txt)"
    sed "s/{{title}}/$title/g;s/{{body}}/$body/g" template.html >> "$2/$base.html"
  done
fi
#sed 's/{{title}}/Welcome to the Island/g' template.html
#references
# http://stackoverflow.com/questions/59838/check-if-a-directory-exists-in-a-shell-script
# http://stackoverflow.com/questions/26568952/how-to-replace-multiple-patterns-at-once-with-sed
# http://stackoverflow.com/questions/965053/extract-filename-and-extension-in-bash
Double quote to prevent globbing and word splitting.
