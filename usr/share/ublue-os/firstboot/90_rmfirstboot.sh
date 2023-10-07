#!/bin/sh

echo "We no longer need ublue-firstboot.desktop, so we will remove.  This will be recreated on next update..."

rm -rf "$HOME/.config/autostart/ublue-firstboot.desktop"