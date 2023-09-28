!#/bin/bash

echo "create intial distrobox environment"
distrobox create --nvidia --image ghcr.io/ublue-os/fedora-distrobox:latest -n fedora -Y -ap "buildah butane highlight just kitty lsd stow tmux vim xclip wl-clipboard zsh"