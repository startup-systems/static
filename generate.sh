#!/bin/bash

FILES="$1/*.txt"
DEST=$2
mkdir -p "$DEST"
for f in $FILES
do
#  echo "Processing $f file..."
  # take action on each file. $f store current file name
#  cat $f

  # Parsing doc
  headerline=$(head -1 "$f")
  restofdoc=$(tail -n +3 "$f")
  # end of parsing doc
  filename=$(basename "$f")
  filename="${filename%.*}"
  # Copy html file
  cp template.html "$DEST"/"$filename".html

  # Replace
  /bin/sed -i "s/{{title}}/${headerline}/" "$DEST"/"$filename".html
  /bin/sed -i -e "s|{{body}}|$restofdoc|g" "$DEST"/"$filename".html
  /bin/sed -i -e "s|https[:]//[^ ]*.com|<a href=\"\0\">\0</a>|g" "$DEST"/"$filename".html
#  /bin/sed -i -e "s|(http|ftp|https)://([\w_-]+(?:(?:\.[\w_-]+)+))([\w.,@?^=%&:/~+#-]*[\w@?^=%&/~+#-])?|url|g" "$DEST"/"$filename".html

done
#cat template.html

# ls Desktop\Dropbox\CT\Sys\startup-systems\vm\static
# ./generate.sh examples/simple/ output/
# Always have to run:  sed -i 's/\r$//' testscript
# for dos2unix
