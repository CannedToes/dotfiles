# dotfiles

Personal dotfiles managed with chezmoi.

```sh
chezmoi init --apply https://codeberg.org/mylesglanville/dotfiles.git
```

The zsh config expects `starship` and `fzf` to be installed.

After applying, run `bat cache --build` once for the bat theme.
