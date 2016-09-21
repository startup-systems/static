#!/bin/bash
#worked with: Aamer Hassanally, Mario Rial
set -ex
# Kuljot's CODE HERE

sudo mkdir -p "$2"
inputdir=$(cd "$1"; pwd)
outputdir=$(cd "$2"; pwd)

for file in "$inputdir"/*;
do
	filename=$(basename $file .txt)
	echo "$filename"
	title=$(sed -n '1p' $file)
	body=$(sed -n '3,$p' $file)
	echo "$body"
	sed -e "s/{{title}}/$title/" < template.html > tmpfile
	sed -e "s/{{body}}/$body/" < tmpfile > "$outputdir/$filename.html"
	rm tmpfile
done




#input=$1
#htmlfile=$2
# to_dump=$3

#to fetch basename
# http://www.computerhope.com/unix/ubasenam.htm
###filename=$(basename $input .txt)

#code for just first line = title
##3title=$(sed -n '1p' $input)
###cat $htmlfile | sed "s/{{title}}/$title/" > $filename.html

# body=$(tail -n+3 $input)
###body=$(sed -n '3,$p' $input)
###cat newfile.html | sed "s/{{body}}/$body/m" > $filename.html
###cat $filename.html
#&& mv tmp.html newfile.html


# for line in $input;
# do
# 	body=$(sed '1q' $input)
# 	cat $htmlfile | sed "s/{{body}}/$body/" > newfile2.html
# done



# while read line;
# sed '1q' file

# if [$line -eq 0] #http://tldp.org/LDP/abs/html/comparison-ops.html
# 	echo "$line" > "$2"
	# title=$line
# else
# do
# 	echo "$line" >> "$2"
# done < "$1"

# cat "$htmlfile" | sed 's/{{title}}/"$title"/'

# output=$2
# template=$3






#code that works
#cat template.html | sed 's/{{title}}/kjtitle/'

# http://www.programmingforums.org/thread35601.html
# htmlfile="kjexample.html"
# echo "<!DOCTYPE html>" > "$htmlfile"
# echo "<html>" >> "$htmlfile"
# echo "<head>" >> "$htmlfile"
# echo "<meta charset=\"utf-8\">" >> "$htmlfile"
# echo "<title>{{title}}</title>" >> "$htmlfile"
# echo "</head>" >> "$htmlfile"
# echo "<body>" >> "$htmlfile"
# echo "{{body}}" >> "$htmlfile"
# echo "</body>" >> "$htmlfile"
# echo "</html>" >> "$htmlfile"