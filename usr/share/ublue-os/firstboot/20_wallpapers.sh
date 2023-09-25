#!/bin/bash

echo "Create XML file so that we can see the imported wallpapers in GNOME
"
OUTPUT_FILE="/usr/share/gnome-background-properties/custom.xml"

echo '<?xml version="1.0" encoding="UTF-8"?>' > "$OUTPUT_FILE"
echo '<!DOCTYPE wallpapers SYSTEM "gnome-wp-list.dtd">' >> "$OUTPUT_FILE"
echo '<wallpapers>' >> "$OUTPUT_FILE"

for file in /usr/share/backgrounds/custom/*; do
    if [ -f "$file" ]; then

        filename=$(basename "$file")

        echo '  <wallpaper>' >> "$OUTPUT_FILE"
        echo "    <name>${filename%.*}</name>" >> "$OUTPUT_FILE"
        echo "    <filename>$file</filename>" >> "$OUTPUT_FILE"
        echo '    <options>zoom</options>' >> "$OUTPUT_FILE"
        echo '    <pcolor>#000000</pcolor>' >> "$OUTPUT_FILE"
        echo '    <scolor>#000000</scolor>' >> "$OUTPUT_FILE"
        echo '    <shade_type>solid</shade_type>' >> "$OUTPUT_FILE"
        echo '  </wallpaper>' >> "$OUTPUT_FILE"
    fi
done

echo '</wallpapers>' >> "$OUTPUT_FILE"

echo "Custom wallpapers XML generated at $OUTPUT_FILE"
