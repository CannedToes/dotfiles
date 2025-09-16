Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init powershell | Out-String) })

Set-Alias cd z -Option AllScope

Set YOLK_DIR C:\Users\Myles\Dotfiles
Set EDITOR nvim
