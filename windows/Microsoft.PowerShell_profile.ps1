#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module
Import-Module -Name Microsoft.WinGet.CommandNotFound

Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init powershell | Out-String) })
$env:STARSHIP_CONFIG = "$HOME\.winStarship.toml"
$env:WEZTERM_CONFIG = "$HOME\.wezterm.lua"

Import-Module syntax-highlighting

Import-Module PSReadLine

#Import-Module -Name CompletionPredictor

Set-PSReadLineOption -PredictionSource HistoryAndPlugin

Set-PSReadLineKeyHandler -Chord "Ctrl+f" -Function ForwardWord

function ezaCD {
	eza --icons=always --no-permissions -l
}

function ezaCDall {
	eza --icons=always --no-permissions -l -a
}

Set-Alias -Name ls -Value ezaCD -Option AllScope
Set-Alias -Name la -Value ezaCDall -Option AllScope
Set-Alias -Name cd -Value z -Option AllScope
Set-Alias sudo gsudo
