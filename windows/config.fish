if status is-interactive
    # Commands to run in interactive sessions go here
    cd ~
    clear
end

alias cd="z"
alias ls "eza --icons=always --no-permissions -l" 
alias la "eza --icons=always --no-permissions -l -a" 
alias ll "eza --icons=always --no-permissions" 

zoxide init fish | source
starship init fish | source
wsl2-ssh-agent fish | source

# pnpm
set -gx PNPM_HOME "/home/myles/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end

# environment variables
set PATH $PATH /home/myles/.local/bin
set PATH $PATH /home/myles/.cargo/bin
set FISH ~/.config/fish/config.fish
set WEZ /mnt/c/Users/myles/.wezterm.lua #~/.wezterm.lua
set PAC /etc/pacman.conf
set NVIM ~/.config/nvim/
set NVIMRC ~/.config/nvim/init.lua
set GCM_CREDENTIAL_STORE gpg
