# environments variables
Set EDITOR nvim
Set NVIM_CONF "C:/Users/myles/AppData/Local/nvim/"

# inits & plugins
Invoke-Expression (& { (starship init powershell | Out-String) })
Invoke-Expression (& { (zoxide init powershell | Out-String) })
Invoke-Expression (& { (chezmoi completion powershell | Out-String) })

Import-Module PSReadLine -ErrorAction SilentlyContinue

# specific config
  # PSReadLine
  Set-PSReadlineKeyHandler -Chord Ctrl+F -Function MenuComplete
  Set-PSReadLineOption -HistorySearchCursorMovesToEnd
  Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
  Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
  Set-PSReadLineOption -PredictionSource History
  Set-PSReadLineOption -ShowToolTips

# functions
function lseza {
  eza -l --icons --no-permissions
}

# aliases
Set-Alias cd z -Option AllScope
Set-Alias ls lseza
Set-Alias which Get-Command
