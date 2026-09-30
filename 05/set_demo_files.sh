#!/bin/bash

# With no arguments, use the .txt files in the current directory.
if (( $# == 0 )); then
    # https://til.simonwillison.net/bash/nullglob-in-bash
    # it ignores a wildcard expression when it has no matches
    shopt -s nullglob
    set -- *.txt
    shopt -u nullglob
fi

for file in "$@"; do
    echo "$file"
done
