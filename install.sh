#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

echo "THIS SCRIPT REQUIRES YOU TO HAVE ARCH-BASED DISTRO AND AS AUR HELPER"
sleep 1

## Asking Stuff
echo "Your AUR helper(e.g. paru or yay ): "
read -r aur
echo "Do you use dinit?"
read -r init

sleep 0.5
echo "Installing deps"


case "$init" in 
  "y") $aur -S niri-dinit-git noctalia-qs-git noctalia-shell-git kitty zsh curl vim nvim nirimod-git nirinit cliphist pipewire pipewire-pulse wireplumber pipewire-dinit pipewire-pulse-dinit wireplumber-dinit
  "Y") $aur -S niri-dinit-git noctalia-qs-git noctalia-shell-git kitty zsh curl vim nvim nirimod-git nirinit cliphist pipewire pipewire-pulse wireplumber pipewire-dinit pipewire-pulse-dinit wireplumber-dinit
  "yes") $aur -S niri-dinit-git noctalia-qs-git noctalia-shell-git kitty zsh curl vim nvim nirimod-git nirinit cliphist pipewire pipewire-pulse wireplumber pipewire-dinit pipewire-pulse-dinit wireplumber-dinit
esac


$aur -S niri-git noctalia-qs-git noctalia-shell-git kitty
fi

sleep 1
echo "Adding configs to ~/.config directory"

#mv ~/.config/niri/ ~/.config/niri.bak/
#mv ~/.config/noctalia ~/.config/noctalia.bak

#cp $SCRIPT_DIR/niri ~/.config/niri -r
#cp $SCRIPT_DIR/noctalia ~/.config/noctalia -r

echo "Adding wallpapers"
#cp -r $SCRIPT_DIR/Pictures/ ~/Pictures

#cp $SCRIPT_DIR/Pictures/* ~/Pictures

echo "LAUNCH NIRI FOR THE FIRST TIME WITH 'niri' NOT WITH 'niri-session', AFTER THAT USE 'niri-session'"
