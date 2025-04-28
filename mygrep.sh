#!/bin/bash

# Check if enough arguments are passed
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 [OPTIONS] SEARCH_STRING FILE"
    exit 1
fi

# Parse options
show_line_numbers=false
invert_match=false

while getopts "nv" option; do
    case "$option" in
        n) show_line_numbers=true ;;
        v) invert_match=true ;;
        *) echo "Invalid option"; exit 1 ;;
    esac
done

shift $((OPTIND - 1))  # Shift off the processed options

search_string="$1"
file="$2"

# Check if file exists
if [ ! -f "$file" ]; then
    echo "File not found: $file"
    exit 1
fi

#search
if $invert_match; then
    grep -v "$search_string" "$file"
else
    if $show_line_numbers; then
        grep -n "$search_string" "$file"
    else
        grep "$search_string" "$file"
    fi
fi
