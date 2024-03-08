# ublue-custom

[![build-ublue](https://github.com/johnmmcgee/ublue-custom/actions/workflows/build.yml/badge.svg)](https://github.com/johnmmcgee/ublue-custom/actions/workflows/build.yml)

These are mostly stock images that I created for my own personal use.  
Intial work was forked from: [https://github.com/bsherman/ublue-custom/] (https://github.com/bsherman/ublue-custom/)

## What is this?

Custom uBlue image based on [Team UBlue os](https://github.com/ublue-os).
This is a custom version of [Fedora Silverblue] (https://fedoraproject.org/silverblue/), essentially. 

Images built:
- Silverblue (Fedora GNOME immutable desktop)

Based on:
- [ublue-os/main](https://github.com/ublue-os/main) for good foundations
  - adds distrobox, freeworld mesa and media codecs, gnome-tweaks (on gnome), just, openssl, pipewire-codec-aptx, ratbagd, vim
  - sets automatic staging of updates to system
  - sets flatpaks to update at 04:00 (lets switch this to hourly)
  - v4l2loopback driver from [ublue-os/akmods](https://github.com/ublue-os/akmods)
  - xpadneo/xone xbox controller drivers from [ublue-os/akmods](https://github.com/ublue-os/akmods)
- [ublue-os/nvidia](https://github.com/ublue-os/nvidia) for nvidia variants adds:
  - nvidia kernel drivers
  - nvidia container runtime
  - nvidia vaapi driver
  - nvidia selinux config

#### NOTE: this project is not formally affiliated with [ublue-os](https://github.com/ublue-os/) and is not supported by their team.

## Features

In addition to the packages/config provided by base images, this image:
- Removes from the base image:
  - firefox
- Adds the following packages to the base image:
  - bootc
  - buildah
  - code
  - fonts
    - fira code
    - hack
    - inputmono
    - outputsans
    - sanfran
    - sfmono
  - [kitty](https://sw.kovidgoyal.net/kitty/) terminal
  - lsd
  - p7zip
  - powertop
  - ptyxis
  - stow
  - tmux
  - [libvirtd/virsh](https://libvirt.org/) and [virt-manager](https://virt-manager.org/) (for installing/running VMs)
  - wallpapers
  - [wireguard-tools](https://www.wireguard.com/) (for more VPN)
  - wl-clipboard
  - zsh
- Sets faster timeout on systemd waiting for shutdown
- Sets gnome's "APP is not responding" check to 30 seconds
- Sets some custom gnome settings (see etc/dconf)

## Applications

- The following applications are installed system-wide:
### Communications
- Discord
- Slack
- Signal
- Telegram

### Gaming
- Minecraft
- Steam

### Gnome
- Disk Usage
- Calculator
- Calendar
- Characters
- Documenation Viewer
- Extension Manager
- Firmware Updater
- Font Viewer
- Image Viewer
- Log Viewer
- Nautilus Previwer
- Password / Secrets Manager
- Text Editor
- Weather

### Internet
- Firefox
- Tor Browser

### Multimedia
- Spotify
- VLC

### Productivity
- LibreOffice

### Utilities
- Joplin
- KeePassXC
## Further Customization

Upon the first time booting and on each update, the system will check if `$HOME/.config/ublue-os/firstboot/.firstboot-ran` exist and if it does not it will go through a series of scripts that do things like install flatpaks and... well that is all it does at the moment.  You can remove this file if you wish for it to run again on next update.

## Usage

We build `latest` which points to Fedora 39:

  Standard
  
    rpm-ostree rebase ostree-unverified-registry:ghcr.io/johnmmcgee/silverblue-custom:latest
    rpm-ostree rebase ostree-image-signed:docker://ghcr.io/johnmmcgee/silverblue-custom:latest

  NVidia drivers
  
    rpm-ostree rebase ostree-unverified-registry:ghcr.io/johnmmcgee/silverblue-nvidia-custom:latest
    rpm-ostree rebase ostree-image-signed:docker://ghcr.io/johnmmcgee/silverblue-nvidia-custom:latest

Or you can revert back to 38:

  Standard
  
    rpm-ostree rebase ostree-unverified-registry:ghcr.io/johnmmcgee/silverblue-custom:38
    rpm-ostree rebase ostree-image-signed:docker://ghcr.io/johnmmcgee/silverblue-custom:38

  NVidia drivers
  
    rpm-ostree rebase ostree-unverified-registry:ghcr.io/johnmmcgee/silverblue-nvidia-custom:38
    rpm-ostree rebase ostree-image-signed:docker://ghcr.io/johnmmcgee/silverblue-nvidia-custom:38

Use the `latest` tag to follow the current latest.  Or you can use the release tag, such as `39`, which is current. 

## Verification

These images are signed with sigstore's [cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the `cosign.pub` key from this repo and running the appropriate command:

    cosign verify --key cosign.pub ghcr.io/johnmmcgee/ublue-custom
    cosign verify --key cosign.pub ghcr.io/johnmmcgee/ublue-nvidia-custom
