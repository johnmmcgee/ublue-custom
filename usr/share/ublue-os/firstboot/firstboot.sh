#!/bin/bash

script_dir="$(dirname "$0")"
script_name="$(basename "$0")"
firstboot_dir="$HOME/.config/ublue-os/firstboot/"
firstboot_done_file="$firstboot_dir/firstboot-done"

[ -f "$firstboot_done_file" ] && exit 0

for script in "$script_dir"/*; do
    # Check if the file is executable, not a directory, not the firstboot.sh script,
    # and does not start with an underscore
    if [ -x "$script" ] && [ ! -d "$script" ] && [ "$script" != "$script_dir/$script_name" ] && [[ "$(basename "$script")" != _* ]]; then
        "$script"
    fi
done

[ ! -d "$firstboot_dir" ] && mkdir -p "$firstboot_dir"
touch "$firstboot_dir/firstboot-done"

read -p "Press Enter to continue..."