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

# Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the Docker repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

# Add WineHQ APT repository key
sudo mkdir -pm755 /etc/apt/keyrings
wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo gpg --dearmor -o /etc/apt/keyrings/winehq-archive.key -

# Enable wine repository for i386 architecture
sudo dpkg --add-architecture i386

# Add wine source file
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/plucky/winehq-plucky.sources

# Download MongoDB Compass deb package
wget https://downloads.mongodb.com/compass/mongodb-compass_1.46.10_amd64.deb

sudo apt update

sudo apt install -y \
    git \
    wezterm \
    rofi \
    openrazer-meta \
    polychromatic \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin \
    ./mongodb-compass_1.46.10_amd64.deb

sudo apt install --install-recommends winehq-stable

echo "Apt packages installed!"