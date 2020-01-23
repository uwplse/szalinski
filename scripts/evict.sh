#!/usr/bin/env bash

file=$1
test -f $1
dest=$(dirname bad/$file)

mkdir -p "$dest"
echo mv "$file" "$dest/"
mv "$file" "$dest/"
