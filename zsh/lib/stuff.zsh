#!/usr/bin/env zsh

# Quick-share to https://nyerm.com/stuff
function stuff() {
  local file=$1
  if [[ -z file ]]; then
    echo "No file specified."
    echo "Usage:"
    echo
    echo "$0 filename"
  fi

  scp $file nyerm:sites/nyerm.com/stuff

  if [[ ! $? ]]; then
    echo "Upload failed. Exit code $?"
  else
    echo "Upload successful:"
    echo "https://nyerm.com/stuff/$file"
  fi
}
