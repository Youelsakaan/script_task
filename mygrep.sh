#!/bin/bash

# Check if enough arguments are passed
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 [OPTIONS] SEARCH_STRING FILE"
    exit 1
fi

# Parse options
show_line_numbers=false
invert_match=false
ignore_case=false

while getopts "nvI" option; do
    case "$option" in
        n) show_line_numbers=true ;;
        v) invert_match=true ;;
        I) ignore_case=true ;;  # Add -I for case-insensitive search
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

# Perform the search directly
grep_options=""
if $ignore_case; then
    grep_options="$grep_options -i"  # Add -i for case-insensitive search
fi

if $invert_match; then
    grep $grep_options -v "$search_string" "$file"
else
    if $show_line_numbers; then
        grep $grep_options -n "$search_string" "$file"
    else
        grep $grep_options "$search_string" "$file"
    fi
fi
