#!/bin/bash

source ~/.nix-profile/etc/profile.d/nix.sh

nix profile install nixpkgs#git \
    nixpkgs#nushell \
    nixpkgs#chezmoi \
    nixpkgs#starship \
    nixpkgs#carapace \
    nixpkgs#dotnetCorePackages.dotnet_9.sdk \
    nixpkgs#google-chrome \
    nixpkgs#discord \
    nixpkgs#firefox \
    nixpkgs#spotify \
    nixpkgs#wezterm \
    nixpkgs#vscode \
    nixpkgs#jetbrains-toolbox \
    nixpkgs#obsidian \
    nixpkgs#docker \
    nixpkgs#jetbrains.datagrip \
    nixpkgs#fnm

echo "Packages installed!"

chsh -s $(which nu)

echo "Default shell changed to nushell!"