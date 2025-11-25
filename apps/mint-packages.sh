#!/bin/bash

packages=(
    nixpkgs#git
    nixpkgs#nushell
    nixpkgs#chezmoi
    nixpkgs#mise
    nixpkgs#starship
    nixpkgs#carapace
    nixpkgs#dotnetCorePackages.dotnet_9.sdk
    nixpkgs#google-chrome
    nixpkgs#discord
    nixpkgs#firefox
    nixpkgs#spotify
    nixpkgs#wezterm
    nixpkgs#vscode
    nixpkgs#jetbrains-toolbox
    nixpkgs#obsidian
    nixpkgs#docker
    nixpkgs#jetbrains.datagrip  
)

nix profile install "${packages[@]}"

echo "Packages installed!"