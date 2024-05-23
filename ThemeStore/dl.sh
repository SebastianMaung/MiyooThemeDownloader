#!/bin/sh

base_url="https://github.com/OnionUI/Themes/tree/main/generated/custom"
raw_base_url="https://github.com/OnionUI/Themes/raw/main/generated/custom"
temp_file="temp.html"
wget -q -O "$temp_file" "$base_url"
./grep-arm -oP '(?<=href=")/OnionUI/Themes/blob/main/generated/custom/index-[0-9a-fA-F]{2}-[0-9a-fA-F]{2}\.md' "$temp_file" | while read -r line; do
    filename="${line##*/}"
    file_url="$raw_base_url/$filename"
    wget "$file_url"
done
rm "$temp_file"
