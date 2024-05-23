#!/bin/sh
rm README.md
touch README.md
base_url="https://github.com/OnionUI/Themes/tree/main/generated/custom"
raw_base_url="https://github.com/OnionUI/Themes/raw/main/generated/custom"
temp_file="temp.html"
wget -q -O "$temp_file" "$base_url"
wget -q https://github.com/Zackptg5/Cross-Compiled-Binaries-Android/raw/master/grep/grep-arm -O grep-arm
./grep-arm -oP '(?<=href=")/OnionUI/Themes/blob/main/generated/custom/index-[0-9a-fA-F]{2}-[0-9a-fA-F]{2}\.md' "$temp_file" | while read -r line; do
    filename="${line##*/}"
    file_url="$raw_base_url/$filename"
    wget  -O "$filename" "$file_url"
done
rm "$temp_file"
for file in *.md; do
    if [ -f "$file" ]; then
        echo "Processing $file"
        cat "$file" > "README.md"  # Append content to README.MD
    fi
done
