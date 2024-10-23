#!/usr/bin/env bash

DEBUG=YES
#################################################

# Define functions
#################################################
function pause(){
   read -p "$*"
}

function help(){
  echo
  echo "Usage"
  echo
  echo "    md-clean [-h|--help] \\"
  echo "               (-d <directory>|--dir <directory>) \\"
  echo "               [OPTION]..."
  echo
  echo "Options"
  echo
  echo "    -h, --help"
  echo "        Show this information"
  echo "    -d, --dir"
  echo "        optional. \\"
  echo "        define the path of the directory to list. This defaults to the current working directory. \\"
  echo "        (ie. -d=/home/user/directory)"
  echo
}
#################################################

# Parsing arguments passed to the script
# any arguments not defined below will be passed as arguments/options
#################################################
PASSARGS=()
for i in "$@"
do
case $i in
    -h|--help)
    help
    exit 0
    ;;
    -d=*|--dir=*)
    DIRPASSED=YES
    DIR="${i#*=}"
    shift # past argument=value
    ;;
    *)
    PASSARGS+=(${i}) # unknown option
    ;;
esac
done
#################################################
now=$(date '+%Y_%m_%d_%H_%M_%S')

if [ ! $DIRPASSED ]
then
  echo "working in directory ${PWD}"
  dir="${PWD}"
else
  if [ -d "${DIR}" ]
  then
    echo "working in directory ${DIR}"
    dir="${DIR}"
  else
    echo "supplied directory: ${DIR}, does not exist"
    exit 1
  fi
fi

IMAGES=()
while IFS=  read -r -d $'\0'; do
    IMAGES+=("$REPLY")
done < <(find "$dir" -iname "*.webp" -print0)

# echo "${IMAGES[*]}"
for IMAGE in "${IMAGES[@]}"; do
  echo "current image: $IMAGE"
  MATCH=$(grep -rli "$(basename "$IMAGE")" "$dir")
  echo "current match: $MATCH"
  if [ -n "${MATCH+x}" ]; then
    FOLDER=$(basename "$(dirname "$MATCH")")
    echo "match found in $FOLDER"
    echo "moving $IMAGE to $dir/$FOLDER/"
    mv "$IMAGE" "$dir/$FOLDER/"
  fi
done
