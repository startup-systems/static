
in_dir=$1
out_dir=$2

if [ ! d "out_dir" ]
then
 mkdir -p "$out_dir"
fi

for filename in "$in_dir" /*
do
   title=$(head -1 $filename)
   filebody=$(tail -n 1 $filename)
   get_txtname=$(basename "$filename" .txt)
   sed 's#{{title}}#'"$title"'#g;s#{{body}}#'"$filebody"'#g' template.html > "$out_dir/$get_txtname".html
   
done

      
