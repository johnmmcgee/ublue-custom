#!/bin/bash

read -p "Do you want to install all system flatpaks? (y/n): " choice
if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then

    echo "Disable all repos but flatub for this install .. "
    flatpak remote-delete fedora --force
    flatpak remote-delete fedora-testing --force

    read -p "Do you want to clean and remove all current system flatpaks? (recommended for first run) (y/n): " choice
    if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then

      flatpak remove --system --noninteractive --all

    fi
    
    #sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak remote-add --if-not-exists --system flathub https://flathub.org/repo/flathub.flatpakrepo

    echo "Installing flatpaks that we wish to be system-wide..."
    echo "Communication apps ..."
    flatpak install -y --system \
      com.discordapp.Discord \
      com.slack.Slack \
      org.signal.Signal \
      org.telegram.desktop

    echo "Gaming applications ..."
    flatpak install -y --system \
      com.mojang.Minecraft \
      com.valvesoftware.Steam

    echo "Gnome applications ..."
    flatpak install -y --system \
      org.fedoraproject.MediaWriter \
      org.gnome.baobab \
      org.gnome.Calculator \
      org.gnome.Calendar \
      org.gnome.Characters \
      org.gnome.clocks \
      org.gnome.eog \
      org.gnome.Evince \
      org.gnome.Firmware \
      org.gnome.font-viewer \
      org.gnome.Logs \
      org.gnome.NautilusPreviewer \
      org.gnome.seahorse.Application \
      org.gnome.TextEditor \
      org.gnome.Weather \
      com.mattjakeman.ExtensionManager

    echo "Internet applications ..."
    flatpak install -y --system \
      com.github.micahflee.torbrowser-launcher \
      org.mozilla.firefox

    echo "Multimeda applications ..."
    flatpak install -y --system \
      com.spotify.Client \
      org.videolan.VLC

    echo "Productivity applications ..."
    flatpak install -y --system \
      org.libreoffice.LibreOffice 
  
    echo "Utilities ..."
    flatpak install -y --system \
      net.cozic.joplin_desktop \
      org.keepassxc.KeePassXC

fi