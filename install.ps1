function Create-SymbolicLink {
    param(
        [string]$TargetPath,
        [string]$DestinationPath
    )

    # If the target path exists, remove it
    if (Test-Path -LiteralPath $TargetPath) {
        Remove-Item -LiteralPath $TargetPath -Recurse
    }

    # Create the symbolic link
    New-Item -Path $DestinationPath -ItemType SymbolicLink -Value $TargetPath
}

Create-SymbolicLink "$PWD.Path\powershell\Microsoft.PowerShell_profile.ps1" "$env:USERPROFILE\Documents\WindowsPowershell\Microsoft.PowerShell_profile.ps1"
Create-SymbolicLink "$PWD.Path\git\.gitconfig" "$env:USERPROFILE\.gitconfig"
Create-SymbolicLink "$PWD.Path\alacritty\.config" "$env:APPDATA\alacritty"
Create-SymbolicLink "$PWD.Path\lazygit\.config" "$env:LOCALAPPDATA\lazygit"
Create-SymbolicLink "$PWD.Path\nvim\.config" "$env:LOCALAPPDATA\nvim"
Create-SymbolicLink "$PWD.Path\wezterm\.config" "$env:USERPROFILE\.config\wezterm"
Create-SymbolicLink "$PWD.Path\starship\.config" "$env:LOCALAPPDATA\starship"
