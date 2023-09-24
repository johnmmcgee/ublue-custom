# ublue-custom

[![build-ublue](https://github.com/johnmmcgee/ublue-custom/actions/workflows/build.yml/badge.svg)](https://github.com/johnmmcgee/ublue-custom/actions/workflows/build.yml)

Custom Fedora immutable desktop images which are mostly stock, plus the few things that are needed to make life good on my family's laptops.

## What is this?

These images are customized how I want, based on the great work by [team ublue os](https://github.com/ublue-os).

Images built:
- Silverblue (Fedora GNOME immutable desktop)

Based on:
- [ublue-os/main](https://github.com/ublue-os/main) for good foundations
  - adds distrobox, freeworld mesa and media codecs, gnome-tweaks (on gnome), just, nvtop, openssl, pipewire-codec-aptx, ratbagd, vim
  - sets automatic staging of updates to system
  - sets flatpaks to update twice a day
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
  - htop
- Adds the following packages to the base image:
  - bootc
  - buildah
  - fonts (for coding/terminals)
    - fira code
    - hack
  - [kitty](https://sw.kovidgoyal.net/kitty/) terminal
  - lsd
  - p7zip
  - powertop
  - stow
  - tmux
  - [libvirtd/virsh](https://libvirt.org/) and [virt-manager](https://virt-manager.org/) (for installing/running VMs)
  - vscode
  - [wireguard-tools](https://www.wireguard.com/) (for more VPN)
  - wl-clipboard
  - zsh
  - default font set to Noto Sans
  - gnome shell extensions (appindicator, move-clock, no-overview)
- Sets faster timeout on systemd waiting for shutdown
- Sets gnome's "APP is not responding" check to 30 seconds
- Sets some a few custom gnome settings (see etc/dconf)

## Applications

- Unlike the [ublue base image](https://github.com/ublue-os/base), flatpak applications are installed system wide, but are they are still not on the base image, as they install to /var.

## Further Customization

A `just` task runner default config is included for further customization after first boot.
It will copy the template from `/etc/justfile` to your home directory.
After that run the following commands:

- `just` - Show all tasks, more will be added in the future
- `just bios` - Reboot into the system bios (Useful for dualbooting)
- `just changelogs` - Show the changelogs of the pending update
- `just enroll-secure-boot-key` - use mokutil to import ublue-akmods key for SecureBoot loading of drivers (must follow steps after reboot to import the key)
- `just set-kargs-nvidia` - set kernel boot args to enable nvidia drivers (needs a reboot)
- `just setup-firefox-flatpak-vaapi-nvidia` - what it says on the tin?
- `just update` - Update rpm-ostree, flatpaks, and distroboxes in one command
- Set up distroboxes for the following images:
  - `just distrobox-boxkit`
  - `just distrobox-debian`
  - `just distrobox-fedora`
  - `just distrobox-opensuse`
  - `just distrobox-ubuntu`
- Install various flatpak collections:
  - `just setup-flatpaks` - Install a selection of flatpaks (in my case, usually on parents' laptops but not kids')
  - `just setup-media-flatpaks` - Install Audacity, Inkscape, Kdenlive, Krita, and OBS
  - `just setup-other-flatpaks` - Install misc stuff mostly used only by me amongst my family
  - `just setup-gaming-educational` - Install kid friendly drawing, math, programming, and typing games
  - `just setup-gaming-light` - Install simple games like crosswords, solitaire(cards), mines, bejeweled/tetris clones
  - `just setup-gaming-linux` - Install Linux/Tux games plus a Tron/lightcycle game
  - `just setup-gaming-minecraft` - Install PrismLauncher (Minecraft for Java) and Bedrock Edition launcher
  - `just setup-gaming-serious` - Install Steam, Heroic Game Launcher, Bottles, and community builds of Proton.
  - `just setup-flatpak-overrides-gaming` - Enable MangoHud by default (hit right Shift-F12 to toggle), and enable Bottles to create apps
  - `just setup-flatpak-overrides-pwa` - Enable Chromium browsers to create apps

Check the [just website](https://just.systems) for tips on modifying and adding your own recipes.


## Usage

We build `latest` which now points to Fedora 38 as it has stabilized. But Fedora 37 builds are still available. You can chose a specific version by using the `37` or `38` tag:

    # pick any one of these
    sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/johnmmcgee/silverblue-custom:latest
    sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/johnmmcgee/silverblue-nvidia-custom:latest

We build date tags as well, so if you want to rebase to a particular day's release:
  
    # pick any one of these
    sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/johnmmcgee/silverblue-custom:20230302
    sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/johnmmcgee/silverblue-nvidia-custom:20230302

The `latest` tag will automatically point to the latest stable build, but I suggest using version 37, 38, etc as they become available to avoid surprise upgrades.

## Verification

These images are signed with sigstore's [cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the `cosign.pub` key from this repo and running the appropriate command:

    cosign verify --key cosign.pub ghcr.io/johnmmcgee/silverblue-custom
    cosign verify --key cosign.pub ghcr.io/johnmmcgee/silverblue-nvidia-custom
