#!/bin/bash

set -eEuo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

# should be fine if it is already enabled
sudo sed -i 's/^#\[multilib\]$/\[multilib\]/' /etc/pacman.conf
sudo sed -i '/^\[multilib\]$/{n; s/^#Include = \/etc\/pacman.d\/mirrorlist$/Include = \/etc\/pacman.d\/mirrorlist/}' /etc/pacman.conf

sudo pacman -S --needed wine-staging wine-gecko wine-mono lib32-nvidia-utils lib32-libpulse lib32-libxml2 lib32-mpg123 lib32-lcms2 lib32-giflib lib32-libpng lib32-gnutls lib32-libldap lib32-libgpg-error lib32-gst-plugins-base lib32-gst-plugins-good winetricks

PKGEXT=.pkg.tar yay -S --needed dxvk-bin

# use wine prefix in ~/.cache/wine instead of default ~/.wine, this is also exported in ~/scripts/envs
export WINEPREFIX=~/.cache/wine
# initialize wine prefix
wineboot -u
wait $(pgrep wineboot) || true
# dxvk
setup_dxvk install
# misc
winetricks fontsmooth=rgb mimeassoc=off isolate_home win10
