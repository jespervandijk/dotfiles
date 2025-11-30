#!/bin/bash

sudo apt install software-properties-gtk

# Add WezTerm APT repository
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg

# Add OpenRazer APT repository
sudo add-apt-repository ppa:openrazer/stable

# Add Polychromatic APT repository
sudo add-apt-repository ppa:polychromatic/stable

sudo apt update

sudo apt install -y \
    git \
    wezterm \
    rofi \
    openrazer-meta \
    polychromatic \
    docker.io \
    docker-compose

echo "Apt packages installed!"