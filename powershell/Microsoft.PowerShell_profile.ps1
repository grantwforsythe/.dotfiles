Set-Alias vim nvim
Set-Alias vi nvim
Set-Alias g git
Set-Alias lg lazygit
Set-Alias d docker
Set-Alias .. cd..
Set-Alias grep rg

function mkdir { New-Item -ItemType Directory -Force -Path $args }

function which($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue | 
    Select-Object -ExpandProperty Source -ErrorAction SilentlyContinue
}

Invoke-Expression (&starship init powershell)
$ENV:STARSHIP_CONFIG = "$LOCALAPPDATA\starship\starship.toml"
$ENV:STARSHIP_CACHE = "$APPDATA\Temp"


Import-Module posh-git

Invoke-Expression (& { (zoxide init powershell | Out-String) })
Set-Alias -Name cd -Value __zoxide_z -Option AllScope -Scope Global -Force
Set-Alias -Name cdi -Value __zoxide_zi -Option AllScope -Scope Global -Force

Import-Module PSReadLine

Set-PSReadLineOption -EditMode Vi -ViModeIndicator Cursor
# Set-PSReadLineOption -PredictionViewStyle ListView 
# Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -ShowToolTips

# Key bindings
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

Import-Module PSFzf
Set-PsFzfOption -EnableAliasFuzzyHistory
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PsFzfOption -TabExpansion

