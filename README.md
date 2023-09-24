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
  - code
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

Upon the first time booting and on each update, the system will check if /usr/share/ublue-os/firstboot/.donotrun exist and if it does not it will go through a series of scripts that do things like install flatpaks and... well that is all it does at the moment.  You can remove this file if you wish for it to run again. 


## Usage

We build `latest` which points to Fedora 38:

    # pick any one of these
    sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/johnmmcgee/silverblue-custom:latest
    sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/johnmmcgee/silverblue-nvidia-custom:latest

We build date tags as well, so if you want to rebase to a particular day's release:
  
    # pick any one of these
    sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/johnmmcgee/silverblue-custom:20230302
    sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/johnmmcgee/silverblue-nvidia-custom:20230302

Use the `latest` tag to follow the current latest.  Or you can use the release tag, such as `38`, which is current. 

## Verification

These images are signed with sigstore's [cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the `cosign.pub` key from this repo and running the appropriate command:

    cosign verify --key cosign.pub ghcr.io/johnmmcgee/silverblue-custom
    cosign verify --key cosign.pub ghcr.io/johnmmcgee/silverblue-nvidia-custom
