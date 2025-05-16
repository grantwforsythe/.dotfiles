Set-Alias vim nvim
Set-Alias vi nvim
Set-Alias g git
Set-Alias lg lazygit
Set-Alias .. cd..

# Set Starship as prompt
Invoke-Expression (&starship init powershell)
$ENV:STARSHIP_CONFIG = "$LOCALAPPDATA\starship\starship.toml"
$ENV:STARSHIP_CACHE = "$APPDATA\Temp"

function which($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue | 
    Select-Object -ExpandProperty Source -ErrorAction SilentlyContinue
}

# Git autocomplete
if (-not (Get-Module -Name posh-git -ListAvailable)) {
    Import-Module posh-git
}

# Fuzzy finder
if (-not (Get-Module -Name PSFzf -ListAvailable)) {
    Import-Module PSFzf
}

Set-PsFzfOption -EnableAliasFuzzyHistory

# Enable VI mode and configure PSReadLine
if (-not (Get-Module -Name PSReadLine -ListAvailable)) {
    Import-Module PSReadLine
}

Set-PSReadLineOption -EditMode Vi -ViModeIndicator Cursor
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -ShowToolTips

# Key bindings
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Ctrl+r -ScriptBlock { Invoke-FuzzyHistory }