#!/bin/bash
# ./generate.sh examples/simple/ output/
set -ex

# YOUR CODE HERE
input_dir=$1
output_dir=$2
mkdir -p $output_dir # if not exist


for f in `ls $1`
do
	title=`head -n1 $input_dir/$f`
	body=`tail -n1 $input_dir/$f`

	html=`sed "s/{{title}}/$title/" template.html`
	html=`echo $html | sed "s/{{body}}/$body/"`


	f="${f%.*}" # wihout extension
	newF=$output_dir$f.html
	touch $newF
	echo $html >> $newF

done
