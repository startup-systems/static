#!/bin/bash

set -ex

STARTDIR=$(pwd)
cd $1
INPUTDIR=$(pwd)
cd -
mkdir -p $2
cd $2
OUTPUTDIR=$(pwd)
cd -

cd $INPUTDIR
rsync -Rv $(find . -name '*.txt') $OUTPUTDIR
cd $STARTDIR

for FILENAME in $(find $OUTPUTDIR -name '*.txt'); do
	cat template.html > $FILENAME.html
	TITLE=$(head -n 1 $FILENAME)
	BODY=$(tail -n +3 $FILENAME)
	echo "$BODY" > tmp_body
	sed -i.bak "s/^[^< ].*/<p>&<\/p>/g" tmp_body
	sed -i.bak "s/\\\/\\\\\\\\/g" tmp_body
	sed -i.bak "s/\\//\\\\\//g" tmp_body
	#sed -i.bak "s/\\r/\\\\\r/g" tmp_body
	BODY=$(cat tmp_body)
	echo $BODY > tmp_body
	BODY=$(cat tmp_body)
	rm tmp_body
	rm tmp_body.bak
	
	sed -i.bak "s/{{title}}/$TITLE/g" $FILENAME.html
	sed -i.bak "s/{{body}}/$BODY/g" $FILENAME.html

	sed -i.bak "s/https*:\/\/[^.]*\.[^ \r\n\.]*/<a href=\"&\">&<\/a>/g" $FILENAME.html

	sed -i.bak "s/<\\/p> /&\n/g" $FILENAME.html

	sed -i.bak "s/<\\/p>/\n&/g" $FILENAME.html

	sed -i.bak "s/<p>/&\n/g" $FILENAME.html

	rm $FILENAME
	rm $FILENAME.html.bak	
done

find $OUTPUTDIR -name '*.txt.html' -exec bash -c 'mv "$1" "${1%.txt.html}".html' - '{}' \;
