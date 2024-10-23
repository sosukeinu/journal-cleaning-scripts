#!/usr/bin/env bash 

IMAGES=$(find $PWD -iname '*.webp')

for IMAGE in "$IMAGES"; do
  MATCH=$(grep -rli $(basename "$IMAGE") "$PWD")
  if "$MATCH"; then
    FOLDER=$(basename $(dirname "$IMAGE"))
    echo "match found in $FOLDER"
    echo "would move $IMAGE to $FOLDER"
  fi
done
