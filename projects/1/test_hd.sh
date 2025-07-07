#!/usr/bin/env bash

function color() {
  if [ "$#" -ne 2 ] ; then
    echo "[ERROR] color <color-name> <text> expected two arguments, but got $#" >&2
    return 1
  fi

  local -r colorName="$1"
  local -r message="$2"
  
  local colorCode="0;37"
  case "${colorName,,}" in
    black          ) colorCode='0;30' ;;
    red            ) colorCode='0;31' ;;
    green          ) colorCode='0;32' ;;
    yellow         ) colorCode='0;33' ;;
    blue           ) colorCode='0;34' ;;
    magenta        ) colorCode='0;35' ;;
    cyan           ) colorCode='0;36' ;;
    white          ) colorCode='0;37' ;;
    bright_black   ) colorCode='0;90' ;;
    bright_red     ) colorCode='0;91' ;;
    bright_green   ) colorCode='0;92' ;;
    bright_yellow  ) colorCode='0;93' ;;
    bright_blue    ) colorCode='0;94' ;;
    bright_magenta ) colorCode='0;95' ;;
    bright_cyan    ) colorCode='0;96' ;;
    bright_white   ) colorCode='0;97' ;;
    gray           ) colorCode='0;90' ;;
    *              ) colorCode='0;37' ;;
  esac
 
  echo -e "\e[${colorCode}m${message}\e[0m"
}

test_hdl(){
  
  set -e

  echo "Running Tests..."

  for file in *.tst; do
    if [ ! -f "$file" ]; then 
      color "yellow" "File does not exist ¯\_(ツ)_/¯"
      continue
    fi
    
    echo "Running $file"
    
    ../../tools/HardwareSimulator.sh "$file"
    
    if [ "$?" -ne 0 ]; then
      color "red" "--- FAILED A TEST (0 _ 0) ---"
      break
    else
      color "green" "YIPPEE!!! <( ^ _ ^ )>"
    fi

  done
}

test_hdl

if [ "$?" -ne 0 ]; then
  color "red" "--- FAILED A TEST (0 _ 0) ---"
  exit "$?"
else
  color "bright_green" "--- PASSED ALL TESTS ☜( ⌒ ▽ ⌒ )☞ ---"
  exit 0
fi
