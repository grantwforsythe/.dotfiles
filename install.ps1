$currentPath = $PWD.Path  

cd $currentPath\powershell
if (Test-Path -LiteralPath $env:USERPROFILE\Documents\WindowsPowershell\Microsoft.PowerShell_profile.ps1) {
  Remove-Item -LiteralPath $env:USERPROFILE\Documents\WindowsPowershell\Microsoft.PowerShell_profile.ps1
}

New-Item -Path $env:USERPROFILE\Documents\WindowsPowershell\Microsoft.PowerShell_profile.ps1 -ItemType SymbolicLink -Value Microsoft.PowerShell_profile.ps1

cd $currentPath\git
if (Test-Path -LiteralPath $env:USERPROFILE\.gitconfig) {
  Remove-Item -LiteralPath $env:USERPROFILE\.gitconfig 
}

New-Item -Path $env:USERPROFILE\.gitconfig -ItemType SymbolicLink -Value .gitconfig

cd $currentPath\alacritty\.config\
if (Test-Path -LiteralPath $env:APPDATA\alacritty) {
  Remove-Item -LiteralPath $env:APPDATA\alacritty -Recurse
}

New-Item -Path $env:APPDATA\alacritty -ItemType SymbolicLink -Value alacritty\

cd $currentPath\lazygit\.config\
if (Test-Path -LiteralPath $env:LOCALAPPDATA\lazygit) {
  Remove-Item -LiteralPath $env:LOCALAPPDATA\lazygit -Recurse
}

New-Item -Path $env:LOCALAPPDATA\lazygit -ItemType SymbolicLink -Value lazygit\

cd $currentPath\nvim\.config\
if (Test-Path -LiteralPath $env:LOCALAPPDATA\nvim) {
  Remove-Item -LiteralPath $env:LOCALAPPDATA\nvim -Recurse
}

New-Item -Path $env:LOCALAPPDATA\nvim -ItemType SymbolicLink -Value nvim

cd $currentPath\starship\.config\
if (Test-Path -LiteralPath $env:LOCALAPPDATA\starship) {
  Remove-Item -LiteralPath $env:LOCALAPPDATA\starship -Recurse
}

New-Item -Path $env:LOCALAPPDATA -Name "starship" -ItemType Directory
New-Item -Path $env:LOCALAPPDATA\starship\starship.toml -ItemType SymbolicLink -Value starship.toml
