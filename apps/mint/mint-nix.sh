#!/bin/bash

source ~/.nix-profile/etc/profile.d/nix.sh
export NIXPKGS_ALLOW_UNFREE=1

nix-env -iA nixpkgs.git \
    nixpkgs.nushell \
    nixpkgs.chezmoi \
    nixpkgs.starship \
    nixpkgs.carapace \
    nixpkgs.dotnetCorePackages.dotnet_9.sdk \
    nixpkgs.vscode \
    nixpkgs.fnm \
    nixpkgs.go \
    nixpkgs.gopls

echo "Nix packages installed!"
