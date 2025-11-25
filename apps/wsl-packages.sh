#!/bin/bash

packages=(
    nixpkgs#git
    nixpkgs#nushell
    nixpkgs#chezmoi
    nixpkgs#mise
    nixpkgs#starship
    nixpkgs#carapace
    nixpkgs#dotnetCorePackages.dotnet_9.sdk
    nixpkgs#docker
)

nix profile install "${packages[@]}"

echo "Packages installed!"

chsh -s $(which nu)

echo "Default shell changed to nushell!"