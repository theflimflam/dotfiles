#!/bin/sh

dot_files=$( ls | grep -v copy )

for file in $dot_files; do
  cp -frv "$file" "$HOME/.$file"
done
