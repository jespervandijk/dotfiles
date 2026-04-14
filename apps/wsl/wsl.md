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

Create SSH key

```bash
ssh-keygen -t rsa -b 4096 -C "your.email@example.com"
cat ~/.ssh/id_rsa.pub
```
