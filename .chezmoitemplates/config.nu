# config.nu
#
# Installed by:
# version = "0.104.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

$env.config.show_banner = false

# This line fixes the wezterm scrolling issue, maybe it can be rmoved in the future
$env.config.shell_integration.osc133 = false

if ($nu.os-info.name == 'windows') {
    $env.PATH = ($env.PATH | prepend 'C:\Tools')
}

# Starship - https://starship.rs/
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# Carpace (auto completion for every shell) - https://carapace-sh.github.io/carapace-bin/carapace-bin.html
source ~/.cache/carapace/init.nu