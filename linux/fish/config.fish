if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias cd "z"
alias ls "eza --icons=always --no-permissions -l" 
alias pamcan "pacman"

zoxide init fish | source
starship init fish | source

cat ~/.cache/wal/sequences

# environment variables
set PATH $PATH /home/myles/.local/bin
set PATH $PATH /home/myles/.cargo/bin
set FISH ~/.config/fish/config.fish
set WEZ ~/.config/wezterm/wezterm.lua #/mnt/c/Users/myles/.wezterm.lua 
set PAC /etc/pacman.conf
set NVIM ~/.config/nvim/init.lua
