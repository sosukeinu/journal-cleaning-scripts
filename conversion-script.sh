## convert all images to webp

# usage=0
for i in $(find "$PWD" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.tif" \)); do 
    # usage=$((usage+$(stat -c%s ${i}))) 
    # echo $(stat -c%s ${i})
    cwebp -q 75 "$i" -o "${i%%.*}".webp 
done
# echo "final: $usage"

## Delete all images except webp

find "$PWD" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.tif" \) -exec rm {} \;

usage=0
for i in $(find "$PWD" -type f -iname "*.webp"); do 
    usage=$((usage+$(stat -c%s ${i}))) 
    echo $(stat -c%s ${i}) 
done
echo "final: $usage"

for f in $(find "$PWD" -type f -iname "*.md")
do
  echo "$f"
  FILE="${f##*/}"
  FILENAME="${FILE%.*}"
  EXT="${f##*.}"
  if [ $DEBUG ]; then echo "file: $FILE"; fi
  if [ $DEBUG ]; then echo "filename: $FILENAME"; fi
  if [ $DEBUG ]; then echo "extension: $EXT"; fi
  sed -i 's/\.jpg/\.webp/g' "$f"
  sed -i 's/\.jpeg/\.webp/g' "$f"
  sed -i 's/\.png/\.webp/g' "$f"
  sed -i 's/\.tif/\.webp/g' "$f"
done

  sed -i 's/\.jpg/\.webp/g' *
  sed -i 's/\.jpeg/\.webp/g' *
  sed -i 's/\.png/\.webp/g' *
  sed -i 's/\.tif/\.webp/g' *

1755477411 1.755477411 GB All images with PDF

1742019763 1.742019763 GB All images without PDF

Total from disk usage 3.4 GB 1.7 GB journal 1.6 GB .git

270474998 0.270474998 GB for webp

get `date` from fm and `title` from fm (if no title, get first x characters of content (after second "---")) and run everything through safetitle (ie. 2024-01-20-austin-kleon-on-finding-spare-time.md)

FILE="2010-08-11_Church_Growth.md"
FILE="2010-08-11-church-growth.md"
fileNamePattern="^[0-9]+-[0-9]+-[0-9]+-[a-z0-9\-]+\.md$"
if [[ $FILE =~ $fileNamePattern ]]; then
    echo "I'm in the right format"
else
    echo "I suck"
fi
