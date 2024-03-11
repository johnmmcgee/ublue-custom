#!/bin/bash

read -p "Do you want to install all user flatpaks? (y/n): " choice
if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then

    flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
    
    echo "Installing desired user flatpaks..."
    
    echo "Communication applicatons ..."
    flatpak install -y --user \
      com.discordapp.Discord \
      com.slack.Slack \
      org.signal.Signal \
      org.telegram.desktop

    echo "Devolopment applications ..."
    flatpak install -y --user \
      com.visualstudio.code \
      com.visualstudio.code.tool.podman
    flatpak override --user --filesystem=xdg-run/podman com.visualstudio.code

    echo "Gaming applications ..."
    flatpak install -y --user \
      com.mojang.Minecraft \
      com.valvesoftware.Steam

    echo "Internet applications ..."
    flatpak install -y --user \
      com.github.micahflee.torbrowser-launcher 

    echo "Multimeda applications ..."
    flatpak install -y --user \
      com.spotify.Client

    echo "Productivity applications..."
    flatpak install -y --user \
      net.cozic.joplin_desktop \
      org.keepassxc.KeePassXC \
      com.usebottles.bottles

fi