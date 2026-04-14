Install ubuntu

```bash
wsl --install -d ubuntu
```

Open ubuntu

```bash
wsl -d ubuntu
```

Run script

```bash
curl -fsSL https://raw.githubusercontent.com/jespervandijk/dotfiles/refs/heads/master/apps/wsl/ubuntu-wsl.sh | bash
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
