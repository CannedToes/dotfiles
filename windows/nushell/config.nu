# appearance
  $env.config.show_banner = false
  $env.config.buffer_editor = "nvim"

# aliases

# load extra programs
  # starship
    mkdir ($nu.data-dir | path join "vendor/autoload")
    starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
  # zoxide
    source ~/.zoxide.nu
