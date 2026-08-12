##### 1. Chezmoi Toml

Create a ~/.config/chezmoi/chezmoi.toml

Add:

```toml
[data]
    email = "emailToUse@example.com"

[http]
    sslCAInfo = "/path/to/ca.cert"
```

Note: You can leave out CA cert for personal laptop

##### 2. Chezmoi Init

```bash
chezmoi init https://github.com/username/dotfiles.git
```

Note: This uses git, git needs the right CA cert on work laptop
