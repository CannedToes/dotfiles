# dotfiles~
I did not make this completely from scratch, so all the Repositories/Configs I took inspiration from and based mine off of will be credited alongisde the packages installed.

# Installation
To install the dotfiles simply clone the repository and go into it-  
  `git clone https://github.com/CannedToes/dotfiles && cd dotfiles`  
-then run the install script for,  
Linux:  
	`./install.sh`  
or Windows (wip script that does nothing for the time being):  
	`.\install.ps1`  

# Usage
The repo files automatically update themselves when running the script so no need to worry about repulling.  
In terms of other programs in nvim you can use ":Lazy" to manage it's plugins and ":Mason" to install language support  
Wezterm uses a bunch of custom configs and plugins that I don't feel like getting into right now, submodules attached explain it well enough if you'd like  
`cd` is replaced with [zoxide](https://github.com/ajeetdsouza/zoxide) which remembers folder names and allows you to intuitively CD to them from anywhere  
`ls` is replaced with [eza](https://github.com/eza-community/eza) which provides nerd font symbols and prettier/neater lists, which I have also preconfigured  

# Credits
## Packages Used
neovim - **https://github.com/neovim/neovim**  
starship - **https://github.com/starship/starship**  
fish - **https://github.com/fish-shell/fish-shell**  
fisher - **https://github.com/jorgebucaran/fisher**  
wezterm - **https://github.com/wezterm/wezterm**  
kitty - **https://github.com/kovidgoyal/kitty**  
zoxide - **https://github.com/ajeetdsouza/zoxide**  
eza - **https://github.com/eza-community/eza**  
keychain - **https://github.com/hrantzsch/keychain**  
nerdfonts - **https://github.com/ryanoasis/nerd-fonts**  
## Inspirations
end-4's dots hyprland - **https://github.com/end-4/dots-hyprland**  
elifouts dotfiles - **https://github.com/elifouts/Dotfiles**	
