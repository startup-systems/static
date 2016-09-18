#! /bin/bash

set -ex

if [ $# -eq 0 ] ; then
	echo "USAGE: $(basename $0) input_dir output_dir"
	exit 1
fi

if [ ! -d "$2" ]; then
	mkdir "$2"
fi

filelist=`ls $1`

for file in $filelist ; do
	html=$(echo $file | sed 's/\.txt$/\.html/i')

	echo "<!DOCTYPE html>" > $html
	echo "<html>" >> $html
	echo "	<head>" >> $html
	echo "    <meta charset="utf-8">" >> $html

	count=1
	while read line ; do
		if [ $count -eq 1 ]; then
			l1="<title>{{title}}</title>"
 			l=$(echo -n $line | sed 's/,/\n/g')
			l2=$(echo $l1 | sed 's/{{title}}/'$line'/g')
		
			echo "    $l2" >> $html 
			

		elif [ $count -eq 2 ]; then		
			echo "	</head>" >> $html
			echo "  </body>" >> $html
	
		elif [ $count -gt 2 ]; then
			echo "	  $line" >> $html
		fi
		
		count=`expr $count + 1`		

	done < $1/$file

	echo "	</body>" >> $html
	echo "</html>" >> $html
	
	mv $html $2
done
