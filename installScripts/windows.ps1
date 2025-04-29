<#
.SYNOPSIS
    Installs applications using Winget.

.DESCRIPTION
    This script installs a list of applications using the Winget package manager.
    It first checks if Winget is installed and attempts to install it if it's not.
    It then iterates through a predefined list of application IDs and installs them silently.

.NOTES
    - Requires PowerShell 5.1 or later.
    - Requires administrative privileges to install applications.
    - Assumes Winget is available or can be installed.
#>

#Requires -Version 5.1

# Check if Winget is installed
if (!(Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "Winget is not installed. Attempting to install it..."

    # Attempt to install Winget (this may require specific permissions/setup)
    try {
        Add-AppxPackage -Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe\AppxManifest.xml"
        Write-Host "Winget installation attempted. Please restart PowerShell to use Winget."
    }
    catch {
        Write-Error "Failed to install Winget automatically. Please install it manually from the Microsoft Store."
        exit 1
    }
}

# TODO enable wsl2

# Define the list of application IDs to install
$appIds = @(
    "Git.Git",
    "Docker.DockerDesktop",
    "JetBrains.Toolbox",
    "JetBrains.Rider",
    "Obsidian.Obsidian",
    "Microsoft.PowerShell",
    "Microsoft.PowerToys",
    "Microsoft.WindowsTerminal",
    "JanDeDobbeleer.OhMyPosh",
    "Canonical.Ubuntu.2204",
    "Alacritty.Alacritty",
    "Microsoft.VisualStudioCode"
    "CoreyButler.NVMforWindows"
    "Microsoft.DotNet.SDK.9"
    "Microsoft.DotNet.SDK.8"
    "wez.wezterm"
    "SlackTechnologies.Slack"
    "Discord.Discord"
    "Spotify.Spotify"
    "dbeaver.dbeaver"
    "Amazon.Kindle"
    "Postman.Postman"
    "JGraph.Draw"
    "Mirantis.Lens"
)

# Install each application using Winget
foreach ($appId in $appIds) {
    Write-Host "Installing application: $appId"

    try {
        winget install --id $appId --silent --force --accept-source-agreements --accept-package-agreements
        Write-Host "Successfully installed application: $appId"
    }
    catch {
        Write-Error "Failed to install application: $appId - $($_.Exception.Message)"
    }
}

Write-Host "Application installation complete."