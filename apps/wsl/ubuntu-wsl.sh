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

add_apt_repositories() {
    add_docker_repository
    add_nushell_repository
    add_carapace_repository
}

binary_chezmoi_install(){
    sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply jespervandijk
}

installation_script_fnm() {
    curl -fsSL https://fnm.vercel.app/install | bash
}

install_curl() {
    sudo apt update
    sudo apt install -y curl
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

# Main execution
install_curl
binary_chezmoi_install
installation_script_fnm
add_apt_repositories
install_apt_packages
install_golangci_lint
pnpm_install_script
pnpm_global_packages

echo "All packages installed!"