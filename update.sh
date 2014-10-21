#!/bin/sh

dot_files=$( ls | grep -v copy )

for file in $dot_files; do
  echo cp -fr "$file" "$HOME/.$file"
done
