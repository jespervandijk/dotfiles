#!/bin/bash

install_base_dependencies() {
    sudo apt update
    sudo apt install -y \
        curl \
        software-properties-gtk \
        gnupg \
        unzip \
        wget \
        ca-certificates
}

add_apt_repositories() {
    add_docker_repository() {
        # Add Docker's official GPG key:
        sudo apt update
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

    add_wine_repository() {
        # Add WineHQ APT repository key
        sudo mkdir -pm755 /etc/apt/keyrings
        wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo gpg --dearmor --yes -o /etc/apt/keyrings/winehq-archive.key -

        # Enable wine repository for i386 architecture
        sudo dpkg --add-architecture i386

        # Add wine source file
        sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/plucky/winehq-plucky.sources
    }

    add_razor_polychromatic_repositories() {
        # Add OpenRazer APT repository
        sudo add-apt-repository -y ppa:openrazer/stable

        # Add Polychromatic APT repository
        sudo add-apt-repository -y ppa:polychromatic/stable
    }

    add_wezterm_repository() {
        # Add WezTerm APT repository
        curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
        echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
        sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg
    }

    add_mongodb_compass_repository() {
        # Download MongoDB Compass deb package
        wget https://downloads.mongodb.com/compass/mongodb-compass_1.46.10_amd64.deb
    }

    add_docker_repository
    add_nushell_repository
    add_carapace_repository
    add_wine_repository
    add_razor_polychromatic_repositories
    add_wezterm_repository
    add_mongodb_compass_repository
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
        gopls \
        openrazer-meta \
        polychromatic \
        wezterm \
        rofi \
        ./mongodb-compass_1.46.10_amd64.deb

    sudo apt install -y --install-recommends winehq-stable
}

deb_get_install_script() {
    echo "Installing deb-get..."
    # 1. Clean up old failed attempts
    sudo rm -rf /var/cache/deb-get /etc/deb-get
    
    # 2. Install the .deb directly (bypass broken bootstrap)
    local URL=$(curl -s https://api.github.com/repos/wimpysworld/deb-get/releases/latest | grep "browser_download_url.*all.deb" | cut -d '"' -f 4)
    wget -qO /tmp/deb-get.deb "$URL"
    sudo apt install -y /tmp/deb-get.deb
    
    # 3. Update the index, forcing 'noble' as the codename
    sudo UPSTREAM_CODENAME=noble deb-get update
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

azure_cli_install_script() {
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
}

install_scripts(){
    golangci_lint_install_script
    pnpm_install_script
    starship_install_script
    fnm_install_script
    chezmoi_install_script
    azure_cli_install_script
    deb_get_install_script
}

deb_get_packages() {
    # UPSTREAM_CODENAME=noble tells it we are on Ubuntu 24.04
    # DEBGET_ACCEPT_EULA=y automatically accepts the Chrome license
    sudo UPSTREAM_CODENAME=noble DEBGET_ACCEPT_EULA=y deb-get install \
        google-chrome-stable \
        code
}

pnpm_global_packages() {
     # Ensure the path is set even if this function is called alone
    export PNPM_HOME="$HOME/.local/share/pnpm"
    export PATH="$PNPM_HOME:$PATH"

    pnpm add turbo --global
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
set +e
install_base_dependencies
add_apt_repositories
install_apt_packages
install_scripts
deb_get_packages
pnpm_global_packages
flatpack_install_packages

echo "All packages installed!"
