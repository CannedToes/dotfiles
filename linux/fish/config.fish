if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias cd="z"
alias ls "eza --icons=always --no-permissions -l" 
alias la "eza --icons=always --no-permissions -l -a" 
alias ll "eza --icons=always --no-permissions" 

zoxide init fish | source
starship init fish | source

# environment variables
set PATH $PATH /home/myles/.local/bin
set PATH $PATH /home/myles/.cargo/bin
set FISH ~/.config/fish/config.fish
set WEZ ~/.config/wezterm/wezterm.lua #/mnt/c/Users/myles/.wezterm.lua 
set PAC /etc/pacman.conf
set NVIM ~/.config/nvim/init.lua
set GCM_CREDENTIAL_STORE gpg

# pnpm
set -gx PNPM_HOME "/home/myles/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
