#!/bin/bash

set -ouex pipefail

# enable services
systemctl enable dconf-update.service
systemctl enable rpm-ostree-countme.timer

# fonts
fc-cache -f /usr/share/fonts/inputmono
fc-cache -f /usr/share/fonts/outputsans

# shutdown timeouts
sed -i 's/#DefaultTimeoutStopSec.*/DefaultTimeoutStopSec=15s/' /etc/systemd/user.conf
sed -i 's/#DefaultTimeoutStopSec.*/DefaultTimeoutStopSec=15s/' /etc/systemd/system.conf

# enable firstboot
chmod a+x /usr/share/ublue-os/firstboot/*.sh

# misc clean up
rm -f /usr/share/applications/htop.desktop
rm -f /usr/share/applications/nvtop.desktop