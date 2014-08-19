#!/bin/bash

for file in $(ls | grep '^_'); do
  dot_file=$(echo $file | sed 's/^_/./g');
  echo $dot_file vs $file
done;
