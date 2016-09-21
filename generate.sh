#!bin/bash

set -ex

# YOUR CODE HERE
#!/bin/bash

set -ex

# YOUR CODE HERE
out_dir=$2
in_dir=$1

if [ ! -d "$out_dir" ] ; then
   mkdir -p "$out_dir"
fi

for filename in "$in_dir" /*
do
   title=$(head -1 "$in_dir/$filename")
   filebody=$(tail -n +3 "$in_dir/$filename")
   get_txtname=$(basename "$filename" .txt)
   htmlname=$get_txtname.html
   sed -e 's#{{title}}#' "$title" '/g' -e 's#{{body}}#' "$filebody" '#g' template.html > "$out_dir"/"$htmlname".html
   
done

exit
      
