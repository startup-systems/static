#!/bin/bash

set -ex

# YOUR CODE HERE

#!/bin/bash

set -ex

# YOUR CODE HERE
in_dir  =  $1
out_dir  =  $2

if [! -d "$out_dir"] ; then
   mkdir -p "$out_dir"
fi

for filename in "$in_dir" /*
do
   title  =  $(head -1 "$in_dir/$filename")
   filebody  =  $(tail -n +1 "$in_dir/$filename")
   get_txtname  =  $(basename $in_dir/filename.txt .txt)
   htmlname  =  $get_txtname.html
   sed -e 's#{{title}}#' "$title" '/g' -e 's#{{body}}#' "$filebody" '#g' template.html > "$out_dir"/"$filename".html
   
done

exit
   
