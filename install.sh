#!/bin/bash

# Set variables
REPO="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
PACKAGES="neovim starship fish fisher wezterm kitty zoxide eza keychain ttf-roboto-mono-nerd hyprland"
AURPACKAGES="mkinitcpio-firmware update-grub"

# Confirmation message
echo -e "Please backup your dotfiles if you want to keep them (obviously)\n"
echo "This install script is for ARCH LINUX and ARCH LINUX ONLY! If you install it on anything else you are nothing short of shit for brains."
echo "Script Location:" $REPO

read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

# check if yay is installed and install it if not
YAYINSTALLED="$( pacman -Q yay )"
if [[ $YAYINSTALLED == ["error: package 'yay' was not found"] ]]; then
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
fi

sudo pacman -Syu --needed $PACKAGES
yay -Syu --needed $AURPACKAGES

clear

# copying across and setting up config files
cp -r $REPO/universal/nvim $HOME/.config/

cp -r $REPO/linux/starship.toml $HOME/.config/
cp -r $REPO/linux/wezterm $HOME/.config/
cp -r $REPO/linux/fish $HOME/.config/

# update plugins
chsh -s /usr/bin/fish
fisher update
nvim $REPO/universal/msgnvim.txt

clear

# cleaning up the directories and packages
echo "Cleaning up..."
sudo pacman -Scc
yay -Scc
rm -rf $HOME/.cache/*
sudo rm -rf $REPO/yay

# Installation has completed!
echo "hint - run :Mason in nvim to configure coding languages"
echo -e "hint - run :Lazy in nvim to configure plugins\n"
echo "Installation has finished, enjoy! :)" && sleep 2
fish
