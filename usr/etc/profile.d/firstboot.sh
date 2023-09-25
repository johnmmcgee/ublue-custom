#!/bin/bash

get_fedora_major_version() {
    rpm -E %fedora
}

firstboot_dir="$HOME/.config/firstboot/"
firstboot_done_file="$firstboot_dir/firstboot-done"
firstboot_desktop="/etc/skel.d/.config/autostart/firstboot.desktop"
last_fedora_major_file="$firstboot_dir/last-fedora-major"
autostart_dir="$HOME/.config/autostart"

if [ "$(id -u)" -eq 1000 ] && [ -d "$HOME" ]; then
    last_fedora_major=$(cat "$last_fedora_major_file" 2>/dev/null || echo 0)
    current_fedora_major=$(get_fedora_major_version)

    if [ "$last_fedora_major" != "$current_fedora_major" ] || [ ! -e "$firstboot_done_file" ]; then
        [ ! -d "$autostart_dir" ] && mkdir -p "$autostart_dir"
        cp -f "$firstbootdesktop" "$autostart_dir"
        echo "$current_fedora_major" > "$last_fedora_major_file"
    else
        # we dont need ourselves until next update or major revision.
        rm "$0"
    fi
fi