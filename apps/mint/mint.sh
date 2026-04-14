#!/bin/bash

add_docker_repository() {
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
}

add_nushell_repository() {
    wget -qO- https://apt.fury.io/nushell/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/fury-nushell.gpg
    echo "deb [signed-by=/etc/apt/keyrings/fury-nushell.gpg] https://apt.fury.io/nushell/ /" | sudo tee /etc/apt/sources.list.d/fury-nushell.list
}

add_carapace_repository() {
    # /etc/apt/sources.list.d/fury.list
    deb [trusted=yes] https://apt.fury.io/rsteube/ /
}

add_wine_repository() {
    # Add WineHQ APT repository key
    sudo mkdir -pm755 /etc/apt/keyrings
    wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo gpg --dearmor -o /etc/apt/keyrings/winehq-archive.key -

    # Enable wine repository for i386 architecture
    sudo dpkg --add-architecture i386

    # Add wine source file
    sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/plucky/winehq-plucky.sources
}

add_razor_polychromatic_repositories() {
    # Add OpenRazer APT repository
    sudo add-apt-repository ppa:openrazer/stable

    # Add Polychromatic APT repository
    sudo add-apt-repository ppa:polychromatic/stable
}

add_wezterm_repository() {
    # Add WezTerm APT repository
    curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
    echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
    sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg
}

add_apt_repositories() {
    add_docker_repository
    add_nushell_repository
    add_carapace_repository
    add_wine_repository
    add_razor_polychromatic_repositories
    add_wezterm_repository
}

binary_chezmoi_install(){
    sh -c "$(curl -fsLS get.chezmoi.io)"
}

installation_script_fnm() {
    curl -fsSL https://fnm.vercel.app/install | bash
}

apt_dependencies_for_other_packages() {
    sudo apt update
    sudo apt install -y \
        curl \
        software-properties-gtk \
        gnupg
}

download_mongodb_compass() {
    # Download MongoDB Compass deb package
    wget https://downloads.mongodb.com/compass/mongodb-compass_1.46.10_amd64.deb
}

install_apt_packages() {
    sudo apt update
    sudo apt install -y \
        git \
        docker-ce \
        docker-ce-cli \
        containerd.io \
        docker-buildx-plugin \
        docker-compose-plugin \
        nushell \
        starship \
        carapace-bin \
        dotnet-sdk-10.0 \
        golang-go \
        gopls \
        openrazer-meta \
        polychromatic \
        wezterm \
        rofi \
        ./mongodb-compass_1.46.10_amd64.deb

    sudo apt install --install-recommends winehq-stable
}

install_golangci_lint() {
    curl -sSfL https://golangci-lint.run/install.sh | sh -s v2.11.4
}

pnpm_install_script() {
    curl -fsSL https://get.pnpm.io/install.sh | sh -
}

pnpm_global_packages() {
    pnpm add turbo --global
}

install_deb_get() {
    sudo apt install curl lsb-release wget
    curl -sL https://raw.githubusercontent.com/wimpysworld/deb-get/main/deb-get | sudo -E bash -s install deb-get
}

deb_get_packages() {
    sudo deb-get install -y \
        code \
        google-chrome-stable \

}

flatpack_install_packages() {
    flatpak install -y \
        com.jetbrains.DataGrip \
        md.obsidian.Obsidian \
        com.spotify.Client \
        com.discordapp.Discord \
        com.usebottles.bottles
}

# Main execution
apt_dependencies_for_other_packages
binary_chezmoi_install
installation_script_fnm
add_apt_repositories
download_mongodb_compass
install_apt_packages
install_golangci_lint
pnpm_install_script
pnpm_global_packages
install_deb_get
deb_get_packages
flatpack_install_packages

echo "All packages installed!"