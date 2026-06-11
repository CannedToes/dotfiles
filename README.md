# dotfiles

Personal dotfiles managed with chezmoi.

```sh
chezmoi init --apply https://codeberg.org/mylesglanville/dotfiles.git
```

Main tools: zsh, starship, fzf, neovim, git, foot, sway, waybar, yazi.

The zsh config expects `starship` and `fzf` to be installed.

After applying, run `bat cache --build` once for the bat theme.
