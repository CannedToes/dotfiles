#!/bin/bash

# Set variables
REPO="./"
PACKAGES="neovim starship fish fisher wezterm kitty rustup rust-analyzer netbeans"
AURPACKAGES="zen-browser-bin"

echo "This install script is for ARCH LINUX and ARCH LINUX ONLY! If you install it on anything else you are nothing short of shit for brains."

read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

echo "Please backup your dotfiles if you want to keep them (obviously)"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

cd ..

sudo pacman -Syu --needed $PACKAGES
yay -Syu --needed $AURPACKAGES
rustup default stable

mkdir $HOME/.config/starship

cp -r $REPO/universal/nvim $HOME/.config/
cp -r $REPO/universal/wezterm $HOME/.config/
cp -r $REPO/universal/starship/linuxStarship.toml $HOME/.config/starship/starship.toml

cp -r $REPO/linux/wezterm.lua $HOME/.config/wezterm/
cp -r $REPO/linux/fish $HOME/.config/

echo "Installation has finished, enjoy! :)" && sleep 2
source $HOME/.config/fish/config.fish
