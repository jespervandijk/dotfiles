#!/bin/bash

source ./mint-apt.sh
source ./mint-flathub.sh
source ./mint-nix.sh

echo "All packages installed!"

sudo usermod -s $(which nu) $USER
echo "Default shell changed to nushell!"
