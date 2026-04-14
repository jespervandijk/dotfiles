#!/bin/bash

install_base_dependencies() {
    sudo apt update
    sudo apt install -y curl unzip wget ca-certificates gnupg
}

add_docker_repository() {
    # Add Docker's official GPG key:
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
    echo "deb [trusted=yes] https://apt.fury.io/rsteube/ /" | sudo tee /etc/apt/sources.list.d/fury.list
}

add_apt_repositories() {
    add_docker_repository
    add_nushell_repository
    add_carapace_repository
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
        carapace-bin \
        dotnet-sdk-10.0 \
        golang-go \
        gopls
}

golangci_lint_install_script() {
    curl -sSfL https://golangci-lint.run/install.sh | sh -s v2.11.4
}

pnpm_install_script() {
    curl -fsSL https://get.pnpm.io/install.sh | sh -
}

starship_install_script() {
    curl -sS https://starship.rs/install.sh | sh
}

fnm_install_script() {
    curl -fsSL https://fnm.vercel.app/install | bash
}

chezmoi_install_script() {
    sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply jespervandijk
}

install_scripts() {
    golangci_lint_install_script
    pnpm_install_script
    starship_install_script
    fnm_install_script
    chezmoi_install_script
}

pnpm_global_packages() {
    # Ensure the path is set even if this function is called alone
    export PNPM_HOME="$HOME/.local/share/pnpm"
    export PATH="$PNPM_HOME:$PATH"

    pnpm add turbo --global
}

# Main execution
cd ~
install_base_dependencies
add_apt_repositories
install_apt_packages
install_scripts
pnpm_global_packages

echo "All packages installed!"
