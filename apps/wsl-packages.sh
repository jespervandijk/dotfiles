#!/bin/bash

source ~/.nix-profile/etc/profile.d/nix.sh

nix profile install nixpkgs#git \
    nixpkgs#nushell \
    nixpkgs#chezmoi \
    nixpkgs#mise \
    nixpkgs#starship \
    nixpkgs#carapace \
    nixpkgs#dotnetCorePackages.dotnet_9.sdk \
    nixpkgs#docker

echo "Packages installed!"

chsh -s $(which nu)

echo "Default shell changed to nushell!"