#!/bin/bash
custom_file="/usr/share/gnome-background-properties/custom.xml"
output_file="/tmp/custom.xml"

echo "Create XML file so that we can see the imported wallpapers in GNOME"

echo '<?xml version="1.0" encoding="UTF-8"?>' > "$output_file"
echo '<!DOCTYPE wallpapers SYSTEM "gnome-wp-list.dtd">' >> "$output_file"
echo '<wallpapers>' >> "$output_file"

for file in /usr/share/backgrounds/custom/*; do
    if [ -f "$file" ]; then

        filename=$(basename "$file")

        echo '  <wallpaper>' >> "$output_file"
        echo "    <name>${filename%.*}</name>" >> "$output_file"
        echo "    <filename>$file</filename>" >> "$output_file"
        echo '    <options>zoom</options>' >> "$output_file"
        echo '    <pcolor>#000000</pcolor>' >> "$output_file"
        echo '    <scolor>#000000</scolor>' >> "$output_file"
        echo '    <shade_type>solid</shade_type>' >> "$output_file"
        echo '  </wallpaper>' >> "output_file"
    fi
done

echo '</wallpapers>' >> "$output_file"

sudo mv "$output_file" "$custom_file"

echo "Custom wallpapers XML generated at $output_file"
