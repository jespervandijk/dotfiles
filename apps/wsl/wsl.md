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

Create a ~/.config/chezmoi/chezmoi.toml

```toml
[data]
    email = "j.vandijk@tjip.com"
```

Chezmoi Apply

```bash
chezmoi apply
```

Git Credential Manager

```bash
git config --global credential.helper '/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager.exe'
```

```bash
git config --global credential.https://dev.azure.com.useHttpPath true
```
