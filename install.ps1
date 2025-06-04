function Create-SymbolicLink {
    param(
        [Parameter(Mandatory=$true)]
        [string]$TargetPath,
        [Parameter(Mandatory=$true)]
        [string]$DestinationPath
    )

    if (Test-Path -LiteralPath $DestinationPath) {
        Write-Warning "$DestinationPath already exists. Removing it..."
        Remove-Item -LiteralPath $DestinationPath -Recurse
    }

    New-Item -Path $DestinationPath -ItemType SymbolicLink -Value $TargetPath | Out-Null
    Write-Host "Symbolic linked created at $DestinationPath"
}

function Install-PackageIfMissing {
    param(
        [Parameter(Mandatory=$true)]
        [string]$PackageId,
        [Parameter(Mandatory=$false)]
        [string]$Version
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

# Check for administrative privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
    Write-Error "You must run this script as an Administrator!"
    exit 1
}

$dir = $PWD.Path

Create-SymbolicLink "$dir\powershell\Microsoft.PowerShell_profile.ps1" "$env:USERPROFILE\Documents\WindowsPowershell\Microsoft.PowerShell_profile.ps1"
Create-SymbolicLink "$dir\git\.gitconfig" "$env:USERPROFILE\.gitconfig"
Create-SymbolicLink "$dir\glazewm\" "$env:USERPROFILE\.glzr\glazewm"
Create-SymbolicLink "$dir\alacritty\.config\alacritty" "$env:APPDATA\alacritty"
Create-SymbolicLink "$dir\lazygit\.config\lazygit" "$env:LOCALAPPDATA\lazygit"
Create-SymbolicLink "$dir\nvim\.config\nvim" "$env:LOCALAPPDATA\nvim"
Create-SymbolicLink "$dir\wezterm\.config\wezterm" "$env:USERPROFILE\.config\wezterm"
Create-SymbolicLink "$dir\starship\.config\" "$env:LOCALAPPDATA\starship"

Remove-Variable dir

# Utils
Install-PackageIfMissing "jqlang.jq"
Install-PackageIfMissing "junegunn.fzf"
Install-PackageIfMissing "sharkdp.bat"
Install-PackageIfMissing "BurntSushi.ripgrep.MSVC"
Install-PackageIfMissing "Microsoft.PowerToys"

# Tools
Install-PackageIfMissing "Starship.Starship"
Install-PackageIfMissing "glzr-io.glazewm"
Install-PackageIfMissing "wez.wezterm"
Install-PackageIfMissing "Neovim.Neovim"
Write-Host "Installing zig with winget takes a while, please be patient..."
Install-PackageIfMissing "zig.zig" # Required C compiler for neovim

# Git
Install-PackageIfMissing "Git.Git"
Install-PackageIfMissing "JesseDuffield.lazygit"
Install-PackageIfMissing "dandavison.delta"

Install-Module posh-git
Install-Module PSFzf
Install-Module PSReadLine

