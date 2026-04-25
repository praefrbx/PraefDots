#!/bin/bash

echo "THIS SCRIPT REQUIRES YOU TO HAVE ARCH-BASED DISTRO AND AS AUR HELPER"
sleep 1


## Asking Stuff
echo "Your AUR helped(e.g. paru or yay ): "
read -r aur
echo "Your init system(e.g. systemd or openrc or dinit etc.):" 
read -r init

sleep 0.5

$aur -S niri-$init-git noctalia-shell-git
