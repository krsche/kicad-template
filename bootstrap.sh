#!/bin/bash

set -eou pipefail

ABS=`cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P` # absoulte path to script folder
FOLDER=${ABS##*/}
CURRENT_NAME=`find $ABS -maxdepth 1 -name *.kicad_pro -exec basename {} \; | cut -f1 -d '.'`

NEW_NAME=${1:-$FOLDER}

# Determine what to do
FILES_FOR_TEXT_REPLACE_WITH_CODE=`grep -IRH --exclude-dir=.git --exclude-dir=kicad-library --exclude=README.md "$CURRENT_NAME" $ABS`
echo -e "Replacing '$CURRENT_NAME' --> '$NEW_NAME' in files: \n$FILES_FOR_TEXT_REPLACE_WITH_CODE"

FILES_TO_RENAME=`find $ABS -maxdepth 1 -name "$CURRENT_NAME.*"`
echo
echo -e "Files to rename: \n$FILES_TO_RENAME"

# Ask permission
echo
read -p "Updating name to '$NEW_NAME'. Continue? [Y/n]: " -r
if [[ $REPLY =~ ^[Yy]$ ]] || [[ $REPLY = '' ]]; then
    :
else
    echo "Exiting without modifying anything :)"
    exit 0
fi

# Do It!
# Replace text in files
while IFS= read -r line; do
    file=`echo $line | cut -f1 -d ':'`
    sed -i '' -e "s/$CURRENT_NAME/$NEW_NAME/g" $file
done <<< "$FILES_FOR_TEXT_REPLACE_WITH_CODE"

# Rename files 
for file in $FILES_TO_RENAME; do
    FILE_EXTENTION=${file##*.}
    mv $file $ABS/$NEW_NAME.$FILE_EXTENTION
done
