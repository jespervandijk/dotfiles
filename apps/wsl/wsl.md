Install ubuntu

```nu
wsl --install -d ubuntu
```

Open ubuntu

```nu
wsl -d ubuntu
```

Install curl

```sh
sudo apt update
sudo apt install -y curl

chezmoi cd
```

Open bash

```sh
bash
```

Install nix

```bash
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
```

Install chezmoi

```bash
nix-env -iA nixpkgs.chezmoi
```

Create SSH key

```bash
ssh-keygen -t rsa -b 4096 -C "your.email@example.com"
cat ~/.ssh/id_rsa.pub
```

Init chezmoi

```bash
chezmoi init "git@github.com:jespervandijk/dotfiles.git"
```

Finalize setup with chezmoi

```bash
chezmoi cd
bash apps/wsl-packages.sh
```
