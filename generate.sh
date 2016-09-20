#!/bin/bash

set -ex

function html() {
    TITLE="$(head -n 1 $1)"
    BODY="$(tail -n +2 $1)"
    FILENAME=$(sed 's/txt/html/g' <<< $1)
    # Paragraph formatting (?)
    BODY=$(sed ':a;N;$!ba;s/\n/<p><\/p>/g' <<< $BODY)
    # URL formatting
    BODY=$(sed 's/\(https\?[^\s\\]*.com\(\/[^\s\\]*\)\?\)/<a href="\1">\1<\/a>/g' <<< $BODY)
    sed -e "s@{{title}}@$TITLE@g; s@{{body}}@$BODY@g" $(pwd)/template.html > $FILENAME
}
export -f html

# Remove previous output folder
rm -rf ./$2
# Copy txt files for exact (sub)folder structure
cp -R ./$1 ./$2
# Do the HTML conversion
find ./$2 -type f -exec bash -c 'html "$0"' {} \;
# Remove old .txt files in output folder
find ./$2 -name "*.txt" | xargs rm
