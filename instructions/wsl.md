```sh
sudo apt update
sudo apt install -y curl
bash
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
nix-env -iA nixpkgs.chezmoi
chezmoi cd
```
