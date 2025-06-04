Set-Alias vim nvim
Set-Alias vi nvim
Set-Alias g git
Set-Alias lg lazygit
Set-Alias .. cd..

Invoke-Expression (&starship init powershell)
$ENV:STARSHIP_CONFIG = "$LOCALAPPDATA\starship\starship.toml"
$ENV:STARSHIP_CACHE = "$APPDATA\Temp"

function which($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue | 
    Select-Object -ExpandProperty Source -ErrorAction SilentlyContinue
}

Import-Module posh-git

Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })

Import-Module PSFzf
Set-PsFzfOption -EnableAliasFuzzyHistory
Set-PsFzfOption -PSReadlineChordReverseHistory 'Ctrl+r'

Import-Module PSReadLine

Set-PSReadLineOption -EditMode Vi -ViModeIndicator Cursor
Set-PSReadLineOption -PredictionViewStyle ListView 
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -ShowToolTips

# Key bindings
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Ctrl+r -ScriptBlock { Invoke-FuzzyHistory }
