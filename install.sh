#!/bin/bash
# Set variables
REPO="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
PACKAGES="git neovim fzf starship fish fisher kitty zoxide eza keychain nerd-fonts"
AURPACKAGES="mkinitcpio-firmware wezterm-git"
FISHERPACKAGES="Jomik/fish-gruvbox jethrokuan/fzf jorgebucaran/bax.fish jorgebucaran/nvm.fish franciscolourenco/done jorgebucaran/spark.fish laughdelic/pisces joseluisq/gitnow adambrenecki/virtualfish Gazorby/fish-abbreviation-tips"
HYPRPACKAGES="hyprland nwg-look qt5ct qt6ct pipewire wireplumber xdg-desktop-portal-hyprland hyprpolkitagent qt5-wayland qt6-wayland walker python-pywal16"

# Confirmation message
echo -e "Please backup your dotfiles if you want to keep them (obviously)\n"
echo "This install script is for ARCH LINUX and ARCH LINUX ONLY! If you install it on anything else you are nothing short of shit for brains."
echo "Script Location:" $REPO

read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

cd "$REPO"
git pull --all
# check if yay is installed and install it if not
YAYINSTALLED="$(pacman -Q yay)"
if ["$YAYINSTALLED" = "error: package 'yay' was not found"]; then
  echo $YAYINSTALLED
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si
  cd ..
fi

sudo pacman -Syu --needed $PACKAGES
yay -Syu --needed $AURPACKAGES
fisher install $FISHERPACKAGES

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
rm -rf $HOME/.cache/*
sudo rm -rf $REPO/yay

# Installation has completed!
echo "hint - run :Mason in nvim to configure coding languages"
echo -e "hint - run :Lazy in nvim to configure plugins\n"
echo "Installation has finished enjoy! :)" && sleep 2
fish
