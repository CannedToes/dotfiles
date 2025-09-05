if status is-interactive
  starship init fish | source
  zoxide init fish | source

  alias cd z
  alias ls "eza -l --icons --no-permissions"
end
