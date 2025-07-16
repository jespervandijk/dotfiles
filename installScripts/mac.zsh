#!/usr/bin/zsh
#
# .SYNOPSIS
#    Installs applications and command-line tools using Brew.
#
# .DESCRIPTION
#    This script installs a list of applications (casks) and command-line tools (formulae) using the Brew package manager.
#    It first checks if Brew is installed and attempts to install it if it's not.
#    Then it installs the specified casks and formulae.
#
# .NOTES
#    - Requires macOS.
#    - Requires administrative privileges (for Brew installation, if needed).

# Check if Brew is installed
if ! command -v brew &> /dev/null
then
    echo "Brew is not installed. Attempting to install it..."

    # Attempt to install Brew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    if ! command -v brew &> /dev/null
    then
        echo "Failed to install Brew automatically. Please install it manually."
        exit 1
    fi

    echo "Brew installation attempted. Make sure Brew is in your PATH."
fi

# ! not on brew: oh my zsh

# Define the list of formulae to install (command-line tools)
formulae=(
    "git"
    "tmux"
    "dotnet"
    "dotnet@8"
    "nvm"
    "nushell"
    "starship"
    "carapace"
    "mise"
)

# Define the list of casks to install (GUI applications)
casks=(
    "visual-studio-code"
    "alacritty"
    "rider"
    "jetbrains-toolbox"
    "docker"
    "obsidian"
    "wezterm"
)

# Install formulae
echo "Installing formulae..."
for formula in "${formulae[@]}"
do
    echo "Installing formula: $formula"
    if brew list $formula &> /dev/null
    then
        echo "$formula is already installed. Skipping."
    else
        brew install "$formula"
        if [ $? -eq 0 ]; then
            echo "Successfully installed formula: $formula"
        else
            echo "Failed to install formula: $formula"
        fi
    fi
done

# Install casks
echo "Installing casks..."
for cask in "${casks[@]}"
do
    echo "Installing cask: $cask"
    if brew list --cask $cask &> /dev/null
    then
        echo "$cask is already installed. Skipping."
    else
        brew install --cask "$cask"
        if [ $? -eq 0 ]; then
            echo "Successfully installed cask: $cask"
        else
            echo "Failed to install cask: $cask"
        fi
    fi
done

echo "Application installation complete."