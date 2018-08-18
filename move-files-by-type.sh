#!/usr/local/bin/bash

if [ ${BASH_VERSION:0:1} -lt 4 ] ; then
  echo "Please install bash 4 on your system";
  exit;
fi

if [ "$#" -lt 3 ] ; then
  echo "Wrong number of parameters";
  exit;
fi

SOURCE="$1"
DESTINATION="$2"

shopt -s globstar
for extension in ${@:3}; do
  for file in "$SOURCE"/**/*.$extension; do # Whitespace-safe and recursive
    if [ -f "$file" ]; then
      destFile=$(echo "$file" | sed "s/$SOURCE/$DESTINATION/g");
      destFileName=$(basename "$destFile")
      destDir=$(echo $destFile | sed "s/$destFileName//g");
      mkdir -p "$destDir";
      mv -f "$file" "$destFile";
      echo "$file" ' => ' "$destFile";
    fi
  done
done

printf ".\n.\n.\n.\n.\n"
echo "Cleaning up empty directories..."
printf ".\n.\n.\n.\n.\n"

bash remove-empty-dirs.sh "$SOURCE";
