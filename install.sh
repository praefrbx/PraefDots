#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

echo "THIS SCRIPT REQUIRES YOU TO HAVE ARCH-BASED DISTRO AND AS AUR HELPER"
sleep 1

## Asking Stuff
echo "Your AUR helper(e.g. paru or yay ): "
read -r aur
echo "Do you use dinit?[y/n]"
read -r init
echo "sudo or doas?"
read -r su

sleep 0.5
echo "Installing deps"

case "${init,,}" in
y | yes)
  echo "Configuring for dinit(Maintained by developer(sometimes))..."
  $aur -S niri-dinit-git noctalia-qs-git noctalia-shell-git \
    kitty brightnessctl polkit-gnome wl-clipboard xdg-desktop-portal-gnome \
    ttf-roboto inter-font ttf-jetbrains-mono-nerd xwayland-satellite \
    pipewire pipewire-pulse wireplumber zsh \
    seatd turnstile dbus \
    turnstile-dinit dbus-dinit seatd-dinit pipewire-dinit pipewire-pulse-dinit wireplumber-dinit --needed

  $su dinitctl enable turnstiled
  $su dinitctl enable seatd
  $su dinitctl enable dbus
  ;;
*)
  echo "Configuring for systemd/other(non-maintained, only packages updates)..."
  $aur -S niri-git noctalia-qs-git noctalia-shell-git \
    kitty brightnessctl polkit-gnome wl-clipboard xdg-desktop-portal-gnome \
    ttf-roboto inter-font ttf-jetbrains-mono-nerd xwayland-satellite \
    pipewire pipewire-pulse wireplumber zsh --needed
  ;;
esac

echo "Apply config for kitty?[y/n]"
read -r kittyconf
echo "Apply zsh as a shell?[y/n]"
read -r zsh

sleep 1
echo "Adding configs to ~/.config directory"

$su mkdir -p /etc/niri
$su touch /etc/niri/config.kdl

[ -d ~/.config/niri ] && mv ~/.config/niri/ ~/.config/niri.bak/
[ -d ~/.config/noctalia ] && mv ~/.config/noctalia/ ~/.config/noctalia.bak/

mkdir -p ~/.config
cp -r "$SCRIPT_DIR/niri" ~/.config/
cp -r "$SCRIPT_DIR/noctalia" ~/.config/

case "${kittyconf,,}" in
y | yes)
  echo "Applying Kitty configuration..."
  [ -d ~/.config/kitty ] && mv ~/.config/kitty/ ~/.config/kitty.bak/
  if [ -d "$SCRIPT_DIR/kitty" ]; then
    cp -r "$SCRIPT_DIR/kitty" ~/.config/
  else
    echo "Warning: Source kitty directory not found in script folder!"
  fi
  ;;
*)
  echo "Skipping Kitty configuration."
  ;;
esac

case "${zsh,,}" in
y | yes)
  echo "Setting ZSH as default shell..."
  $su chsh -s "$(which zsh)" "$USER"

  [ -d ~/.oh-my-zsh ] && mv ~/.oh-my-zsh ~/.oh-my-zsh.bak
  [ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.bak

  if [ -d "$SCRIPT_DIR/oh-my-zsh" ]; then
    echo "Copying your personal Oh My Zsh deployment..."
    cp -r "$SCRIPT_DIR/oh-my-zsh" ~/
  else
    echo "Warning: .oh-my-zsh directory not found in script folder!"
  fi

  if [ -f "$SCRIPT_DIR/.zshrc" ]; then
    echo "Applying your custom .zshrc..."
    cp "$SCRIPT_DIR/.zshrc" ~/
  else
    echo "Warning: .zshrc not found in script folder!"
  fi
  ;;
*)
  echo "Skipping ZSH setup."
  ;;
esac

echo "Add wallpaper?[y/n]"
read -r wall

case "${wall,,}" in
y | yes)
  echo "Copying wallpapers..."
  mkdir -p ~/Pictures

  if [ -d "$SCRIPT_DIR/Pictures" ]; then
    cp -rn "$SCRIPT_DIR/Pictures/"* ~/Pictures/
  else
    echo "Warning: Source Pictures directory not found!"
  fi
  ;;
*)
  echo "Skipping wallpaper copy."
  ;;
esac

echo "Your dotfiles are ready, reboot your system and after that do not forget to enable pipewire, pipewire-pulse and wireplumber as user services(dinit only)"
