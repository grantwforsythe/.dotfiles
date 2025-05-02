function Create-SymbolicLink {
    param(
        [Parameter(Mandatory=$true)]
        [string]$TargetPath,
        [Parameter(Mandatory=$true)]
        [string]$DestinationPath
    )

    if (Test-Path -LiteralPath $TargetPath) {
        Write-Host "$TargetPath already exists. Removing it..."
        Remove-Item -LiteralPath $TargetPath -Recurse
    }

    New-Item -Path $DestinationPath -ItemType SymbolicLink -Value $TargetPath
    Write-Host "Symbolic linked created at $DestinationPath"
}

function Install-PackageIfMissing {
    param(
        [Parameter(Mandatory=$true)]
        [string]$PackageId,
        [Parameter(Mandatory=$false)]
        [string]$Version,
    )

    winget list -q $PackageId | Out-Null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "$PackageId already installed"
        return
    }

    if ($Version) {
        winget install -e --id $PackageId --version $Version
    } else {
        winget install -e --id $PackageId
    }

    Write-Host "Installed $PackageId"
}

Create-SymbolicLink "$PWD.Path\powershell\Microsoft.PowerShell_profile.ps1" "$env:USERPROFILE\Documents\WindowsPowershell\Microsoft.PowerShell_profile.ps1"
Create-SymbolicLink "$PWD.Path\git\.gitconfig" "$env:USERPROFILE\.gitconfig"
Create-SymbolicLink "$PWD.Path\glazewm\" "$env:USERPROFILE\.glzr\glazewm"
Create-SymbolicLink "$PWD.Path\alacritty\.config" "$env:APPDATA\alacritty"
Create-SymbolicLink "$PWD.Path\lazygit\.config" "$env:LOCALAPPDATA\lazygit"
Create-SymbolicLink "$PWD.Path\nvim\.config" "$env:LOCALAPPDATA\nvim"
Create-SymbolicLink "$PWD.Path\wezterm\.config" "$env:USERPROFILE\.config\wezterm"
Create-SymbolicLink "$PWD.Path\starship\.config" "$env:LOCALAPPDATA\starship"

# Utils
Install-PackageIfMissing "jqlang.jq"
Install-PackageIfMissing "junegunn.fzf"
Install-PackageIfMissing "sharkdp.bat"
Install-PackageIfMissing "BurntSushi.ripgrep"

# Tools
Install-PackageIfMissing "Starship.Starship"
Install-PackageIfMissing "glzr-io.glazewm"
Install-PackageIfMissing "wez.wezterm"
Install-PackageIfMissing "Neovim.Neovim"
Install-PackageIfMissing "zig.zig" # Required C compiler for neovim

# Git
Install-PackageIfMissing "Git.Git"
Install-PackageIfMissing "JesseDuffield.lazygit"
Install-PackageIfMissing "dandavison.delta"

