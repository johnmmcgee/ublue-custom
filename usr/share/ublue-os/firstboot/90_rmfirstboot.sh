#!/bin/sh

echo "We no longer need firstboot.sh so we will remove.  This will be recreated on next update..."

rm -rf /etc/profile.d/firstboot.sh
rm -rf "$HOME/.config/autostart/ublue-firstboot.desktop"