#!/bin/bash

# commands to run if ostree is updated and we are recreated
/usr/bin/distrobox-assemble create --file /etc/distrobox/distrobox.ini

# delete ourselves.
rm -f $(basename "$0")