#! /bin/bash

set -ex

if [ $# -eq 0 ] ; then
	echo "USAGE: $(basename $0) input_dir output_dir"
	exit 1
fi

if [ ! -d "$2" ]; then
	mkdir "$2"
fi

filelist=$1/*

for file in $filelist ; do
	
	html=$(echo $file | sed 's/\.txt$/\.html/i')

	title=$(head -1 $file)
	body=$(tail -1 $file)
	
	sed -e 's/{{title}}/'$title'/g' -e 's/{{body}}/'$body'/g' template.html >$html
	
	mv $html $2
done
