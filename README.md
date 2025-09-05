# CannedToe/Myles' Dotfiles 
The configs/dotfiles across all my systems and containers  
Managed by [Chezmoi](https://github.com/twpayne/chezmoi) and Nix(sometimes home-manager)  

## chezmoi
To deploy my chezmoi dotfiles, simply paste this into your terminal  
```
chezmoi init https://github.com/Cannedtoes/dotfiles.git
```  
and that's it!  

## nixos
To deploy a NixOS config just clone the repo-
```
git clone https://github.com/CannedToes/dotfiles.git Config && cd Config
```
then edit the files under nixos/hosts/<host> (use whichever config host you prefer) to your personal machine information and personal details
then finally rebuild your system using  
```
sudo nixos-rebuild switch --flake .#<host>
```  
ofcourse again switching <host> whichever config host you would like to use.  
### nixos examples per config
```sudo nixos-rebuild switch --flake .#wsl```  
```sudo nixos-rebuild switch --flake .#desktop```  
```sudo nixos-rebuild switch --flake .#laptop```  
keep in mind you have to be inside of the directory containing the hosts folder or change the . in the command to the directory, for example:  
```sudo nixos-rebuild switch --flake /etc/nixos#desktop```  
or  
```sudo nixos-rebuild switch --flake /home/foo/Config/nixos#wsl```  
