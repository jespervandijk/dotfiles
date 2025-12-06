#!/bin/bash

source ~/.nix-profile/etc/profile.d/nix.sh

nix-env -iA nixpkgs.git \
    nixpkgs.nushell \
    nixpkgs.chezmoi \
    nixpkgs.starship \
    nixpkgs.carapace \
    nixpkgs.dotnetCorePackages.dotnet_9.sdk \
    nixpkgs.fnm \
    nixpkgs.go \
    nixpkgs.gopls \
    nixpkgs.golangci-lint

echo "Packages installed!"
