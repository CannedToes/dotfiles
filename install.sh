#!/bin/bash
# Set variables
REPO="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
PACKAGES="git neovim fzf starship fish fisher kitty zoxide eza nerd-fonts hyprland swww sddm swaync nwg-look qt5ct qt6ct pipewire wireplumber xdg-desktop-portal-hyprland hyprpolkitagent qt5-wayland qt6-wayland python-pywal16 waybar wofi"
AURPACKAGES="mkinitcpio-firmware wezterm-git wlogout swaylock-effects waybar gtk-engine-murrine gtk-murrine-themes-collection graphite-gtk-theme"
FISHERPACKAGES="Jomik/fish-gruvbox jethrokuan/fzf jorgebucaran/bax.fish jorgebucaran/nvm.fish franciscolourenco/done jorgebucaran/spark.fish laughdelic/pisces adambrenecki/virtualfish Gazorby/fish-abbreviation-tips"
HYPRREPOS="https://github.com/VirtCode/hypr-dynamic-cursors https://github.com/hyprwm/hyprland-plugins"
HYPRPACKAGES="dynamic-cursors borders-plus-plus csgo-vulkan-fix hyprtrails"

# Confirmation message
echo -e "Please backup your dotfiles if you want to keep them (obviously)\n"
echo "This install script is for ARCH LINUX and ARCH LINUX ONLY! If you install it on anything else you are nothing short of shit for brains."
echo "Also you must have sudo privileges to be able to run this script, as it will ask you for such"
echo "Script Location:" "$REPO"

read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

cd "$REPO"
git pull --all
# check if yay is installed and install it if not
YAYINSTALLED="$(pacman -Q yay)"
if ["$YAYINSTALLED" = "error: package 'yay' was not found"]; then
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si
  cd ..
fi

sudo pacman -Syu --needed "$PACKAGES"
yay -Syu --needed "$AURPACKAGES"
fisher install "$FISHERPACKAGES"

clear

# copying across and setting up config files
mkdir -p "$HOME"/.config
cp -rf "$REPO"/universal/nvim "$HOME"/.config/
mkdir -p "$HOME"/Pictures
cp -rf "$REPO"/universal/Wallpapers "$HOME"/Pictures/

cp -rf "$REPO"/linux/* "$HOME"/.config/

# update plugins
chsh -s /usr/bin/fish
fisher update
hyprpm add "$HYPRREPOS"
hyprpm enable "$HYPRPACKAGES"
nvim "$REPO"/universal/msgnvim.txt

clear

# cleaning up the directories and packages
echo "Cleaning up..."
sudo pacman -Scc
rm -rf "$HOME"/.cache/*
rm -rf "$REPO"/yay

# Installation has completed!
echo "hint - run :Mason in nvim to configure coding languages"
echo -e "hint - run :Lazy in nvim to configure plugins\n"
echo "Restart for full changes to take effect"
echo "Installation has completed enjoy! :)" && sleep 2
fish
