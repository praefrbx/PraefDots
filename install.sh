#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

echo "THIS SCRIPT REQUIRES YOU TO HAVE ARCH-BASED DISTRO AND AS AUR HELPER"
sleep 1


## Asking Stuff
echo "Your AUR helper(e.g. paru or yay ): "
read -r aur
echo "Your init system(e.g. systemd or openrc or dinit etc.):" 
read -r init

sleep 0.5
echo "Installing deps"
$aur -S niri-$init-git noctalia-shell-git kitty

sleep 1
echo "Adding configs to ~/.config directory"

mv ~/.config/niri/ ~/.config/niri.bak/
mv ~/.config/noctalia ~/.config/noctalia.bak

cp $SCRIPT_DIR/niri ~/.config/niri -r
cp $SCRIPT_DIR/noctalia ~/.config/noctalia -r

echo "Adding wallpapers"
cp $SCRIPT_DIR/Pictures/* ~/Pictures


echo "LAUNCH NIRI FOR THE FIRST TIME WITH 'niri' NOT WITH 'niri-session', AFTER THAT USE 'niri-session'"
