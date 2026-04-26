#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

echo "THIS SCRIPT REQUIRES YOU TO HAVE ARCH-BASED DISTRO AND AS AUR HELPER"
sleep 1


## Asking Stuff
echo "Your AUR helped(e.g. paru or yay ): "
read -r aur
echo "Your init system(e.g. systemd or openrc or dinit etc.):" 
read -r init

sleep 0.5
echo "Installing deps"
$aur -S niri-$init-git noctalia-shell-git

sleep 1
echo "Adding configs to ~/.config directory"

cp $SCRIPT_DIR/niri ~/.config/niri -r
cp $SCRIPT_DIR/noctalia ~/.config/noctalia -r

echo "Adding wallpapers"
cp $SCRIPT_DIR/Pictures ~/Pictures
