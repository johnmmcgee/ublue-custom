#!/bin/bash

read -p "Do you want to install all system flatpaks? (y/n): " choice
if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then

    echo "Disable all repos but flathub for this install .. "
    flatpak remote-delete fedora --force
    flatpak remote-delete fedora-testing --force

    read -p "Do you want to clean and remove all current system flatpaks? (recommended for first run) (y/n): " choice
    if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then

      flatpak remove --system --noninteractive --all

    fi
    
    flatpak remote-add --if-not-exists --system flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak remote-modify --system --enable flathub

    echo "Installing flatpaks that we wish to be system-wide..."

    echo "Gnome applications ..."
    flatpak install -y --system \
      org.fedoraproject.MediaWriter \
      org.gnome.baobab \
      org.gnome.Calculator \
      org.gnome.Calendar \
      org.gnome.Characters \
      org.gnome.Evince \
      org.gnome.Firmware \
      org.gnome.font-viewer \
      org.gnome.Logs \
      org.gnome.Loupe \
      org.gnome.NautilusPreviewer \
      org.gnome.seahorse.Application \
      org.gnome.TextEditor \
      org.gnome.Weather \
      com.mattjakeman.ExtensionManager

    echo "Internet applications ..."
    flatpak install -y --system \
      org.mozilla.firefox

    echo "Multimeda applications ..."
    flatpak install -y --system \
      com.github.rafostar.Clapper

    echo "Productivity applications ..."
    flatpak install -y --system \
      org.libreoffice.LibreOffice 

fi