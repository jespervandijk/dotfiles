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

Microsoft Credential Provider (For Nuget Sources)

```bash
wget -qO- https://aka.ms/install-artifacts-credprovider.sh | bash
```

Tjip Nuget Sources

```bash
dotnet nuget add source https://pkgs.dev.azure.com/tjip/AbnAmro/_packaging/Hypotheek-NuGet/nuget/v3/index.json
dotnet nuget add source https://pkgs.dev.azure.com/tjip/_packaging/Tjip-Components/nuget/v3/index.json
```

Restore Project Interactively

```bash
dotnet restore --interactive
```
