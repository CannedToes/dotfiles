if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias cd="z"
alias ls "eza --icons=always"

zoxide init fish | source
starship init fish | source

# pnpm
set -gx PNPM_HOME "/home/myles/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end

# environment variables
set PATH $PATH /home/myles/.local/bin
set PATH $PATH /home/myles/.cargo/bin
set GCM_CREDENTIAL_STORE secretservice
