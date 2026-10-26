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

add_github_cli_repository(){
        sudo mkdir -pm755 /etc/apt/keyrings
        wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null
        sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
        sudo tee /etc/apt/sources.list.d/github-cli.sources <<EOF
Types: deb
URIs: https://cli.github.com/packages
Suites: stable
Components: main
Signed-By: /etc/apt/keyrings/githubcli-archive-keyring.gpg
EOF
    }

add_apt_repositories() {
    add_docker_repository
    add_nushell_repository
    add_carapace_repository
    add_github_cli_repository
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
        fzf \
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

azure_cli_install_script() {
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
}

opencode_install_script(){
    curl -fsSL https://opencode.ai/install | bash
}

just_install_script(){
    curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to ~/bin
}

dotnetup_install_script(){
    curl -fsSL https://aka.ms/dotnetup/get-dotnetup.sh
}

install_scripts() {
    pnpm_install_script
    starship_install_script
    fnm_install_script
    chezmoi_install_script
    azure_cli_install_script
    opencode_install_script
    just_install_script
    dotnetup_install_script
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
source ./bashrc

echo "All packages installed!"
