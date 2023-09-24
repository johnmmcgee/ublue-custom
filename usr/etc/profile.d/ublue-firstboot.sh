#!/bin/bash

get_fedora_major_version() {
    local os_release
    os_majorver=$(rpm -E %fedora)
    echo "$os_majorver"
}

if [ "$(id -u)" -eq "1000" ] && [ -d "$HOME" ]; then

    last_fedora_major=$(cat "$HOME/.config/ublue/last-fedora-major" 2>/dev/null)
    current_fedora_major=$(get_fedora_major_version)

    if [ "$last_fedora_major" != "$current_fedora_major" ] || [ ! -e "$HOME/.config/ublue/firstboot-done" ]; then
        mkdir -p "$HOME"/.config/autostart
        cp -f /etc/skel.d/.config/autostart/ublue-firstboot.desktop "$HOME"/.config/autostart
    fi
    echo "$current_fedora_major" > "$HOME/.config/ublue/last-fedora-major"

fi