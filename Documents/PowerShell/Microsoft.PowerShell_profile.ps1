# -- <environment> --
$Env:EDITOR = "nvim"
$Env:VISUAL = "nvim"

# -- <prompt> --
Invoke-Expression (& { (starship init powershell | Out-String) })
Invoke-Expression (& { (zoxide init powershell | Out-String) })
Invoke-Expression (& { (chezmoi completion powershell | Out-String) })

# -- <scoop> --
if (Get-Command sfsu -ErrorAction SilentlyContinue) {
	Invoke-Expression (& { (sfsu hook --shell powershell | Out-String) })
}

# -- <psreadline> --
Set-PSReadLineOption -EditMode Windows
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key Shift+Tab -Function TabCompletePrevious
Set-PSReadLineKeyHandler -Key Ctrl+F -Function AcceptSuggestion
Set-PSReadLineKeyHandler -Key Ctrl+RightArrow -Function ForwardWord
Set-PSReadLineKeyHandler -Key Ctrl+LeftArrow -Function BackwardWord
Set-PSReadLineKeyHandler -Key Alt+F -Function ForwardWord
Set-PSReadLineKeyHandler -Key Alt+B -Function BackwardWord
Set-PSReadLineKeyHandler -Key Ctrl+A -Function BeginningOfLine
Set-PSReadLineKeyHandler -Key Ctrl+E -Function EndOfLine
Set-PSReadLineKeyHandler -Key Ctrl+U -Function BackwardKillInput
Set-PSReadLineKeyHandler -Key Ctrl+K -Function KillLine
Set-PSReadLineKeyHandler -Key Ctrl+W -Function BackwardKillWord
Set-PSReadLineKeyHandler -Key Ctrl+R -Function ReverseSearchHistory
try {
	Set-PSReadLineOption -PredictionSource History -ErrorAction Stop
} catch {
	Set-PSReadLineOption -PredictionSource None
}

# -- <navigation> --
Remove-Item Alias:ls -ErrorAction SilentlyContinue

function ls {
	if (Get-Command eza -ErrorAction SilentlyContinue) {
		eza --icons=auto --group-directories-first --classify=auto @args
		return
	}

	Get-ChildItem @args
}

function ll {
	ls --long --git --header @args
}

function la {
	ls --all @args
}

function lt {
	ls --tree --level 2 @args
}

# -- <aliases> --
Set-Alias neofetch fastfetch
Set-Alias which Get-Command
