#!/bin/bash
set -ex
inputpath=$1
outdir=$2
if [ ! -d "$outdir" ]; then
	mkdir -p $outdir
fi

files=(`ls $1`)
numFiles=${#files[@]}

for ((i=0; i< $numFiles; i++)); do
	outfile=$(basename ${files[i]})
	outfile=${outfile%.*}
	cat template.html > $outdir/$outfile.html
	subtopic=`head -n 1 $inputpath/${files[i]}`
	subbody=`tail -n 1 $inputpath/${files[i]}`
	sed -i "s/{{title}}/$subtopic/g" $outdir/$outfile.html
	sed -i "s/{{body}}/$subbody/g" $outdir/$outfile.html
done

