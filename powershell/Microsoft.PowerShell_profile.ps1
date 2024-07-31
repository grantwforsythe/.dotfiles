Set-Alias vim nvim
Set-Alias vi nvim
Set-Alias g git
Set-Alias lg lazygit
Set-Alias .. cd..

# Set Starship as prompt
Invoke-Expression (&starship init powershell)
$ENV:STARSHIP_CONFIG = "$LOCALAPPDATA\starship\starship.toml"
$ENV:STARSHIP_CACHE = "$APPDATA\Temp"

# Git autocomplete
Import-Module posh-git
# Enable VI mode
Import-Module PSReadLine

Set-PSReadLineOption -EditMode Vi -ViModeIndicator Cursor

# Shows navigable menu of all options when hitting Tab
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# Autocompleteion for Arrow keys
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

Set-PSReadLineOption -ShowToolTips
Set-PSReadLineOption -PredictionSource History
