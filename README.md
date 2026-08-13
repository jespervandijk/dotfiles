##### 1. Chezmoi Toml

Create a ~/.config/chezmoi/chezmoi.toml

Add:

```toml
[data]
    email = "emailToUse@example.com"
    ca_cert_path = "/path/to/ca.cert" (Optional)
    is_wsl = true (Optional)
```

Note: You can leave out CA cert for personal laptop

##### 2. Chezmoi Init

```bash
chezmoi init https://github.com/username/dotfiles.git
```

Note: This uses git, git needs the right CA cert on work laptop
