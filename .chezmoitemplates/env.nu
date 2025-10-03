# env.nu
#
# Installed by:
# version = "0.104.0"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.

if ($nu.os-info.name == 'macos') {
    $env.PATH ++= (
        [
            ($env.HOME | append '/bin' | str join)
            '/usr/local/bin'
            '/opt/homebrew/bin'
            '/opt/homebrew/opt/python@3.13/libexec/bin'
        ]
    )
}

# Carpace (auto completion for every shell) - https://carapace-sh.github.io/carapace-bin/carapace-bin.html
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

# Mise
let mise_path = $nu.default-config-dir | path join mise.nu
^mise activate nu | save $mise_path --force
