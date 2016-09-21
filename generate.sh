#!/bin/bash

set -ex

# SOURCES
# Worked with: Kuljot Anand; Mario Rial
# http://www.programmingforums.org/thread35601.html
# http://stackoverflow.com/questions/10929453/read-a-file-line-by-line-assigning-the-value-to-a-variable
# http://stackoverflow.com/questions/6022384/bash-tool-to-get-nth-line-from-a-file


########## STATIC SITE BUILDER ########## 

input=$(cd "$1"; pwd)
output=$(cd "$2"; pwd)

mkdir -p "$2"

for textfile in "$input"/*;
do
	filename=$(basename $textfile .txt)

	title=$(sed '1q' $textfile)
	cat template.html | sed "s/{{title}}/$title/" > tmp.html

	body=$(tail -n +3 $textfile)
	cat tmp.html | sed "s/{{body}}/$body/" > "$2/$filename.html"

	rm tmp.html
done

########## END ##########


### DISCARDED CODE

# textfile=$1
# htmlfile=$2

# filename=$(basename $textfile .txt)

# title=$(sed '1q' $textfile)
# cat $htmlfile | sed "s/{{title}}/$title/" > tmp.html

# body=$(tail -n +3 $textfile)
# cat tmp.html | sed "s/{{body}}/$body/" > $filename.html

# rm tmp.html



# cat template1.html | sed 's/{{title}}/cool/'


# while IFS='' read -r line || [[ -n "$line" ]]; do
# 	echo "$line"
# done < "$1"


# cat simple1.txt | tail -n +2


# while read line; do
# 	echo "$line" >> "$2"
# done < "$1"


# cat template1.html | sed 's/{{title}}/cool/'


# filename="$1"
# while read -r line
# do
#     name="$line"
#     echo "$name"
# done < "$filename"


### TESTING SHELL SCRIPT

# htmlfile="testfile1.html"
# echo "<\!DOCTYPE html>" > "$htmlfile"
# echo "<html>" >> "$htmlfile"
# echo "<head>" >> "$htmlfile"
# echo "<meta charset=\"utf-8\">" >> "$htmlfile"
# echo "<title>{{title}}</title>" >> "$htmlfile"
# echo "</head>" >> "$htmlfile"
# echo "<body>" >> "$htmlfile"
# echo "{{body}}" >> "$htmlfile"
# echo "</body>" >> "$htmlfile"
# echo "</html>" >> "$htmlfile"