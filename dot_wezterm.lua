-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Tokyo Night'
config.default_prog = {"C:\\Program Files\\PowerShell\\7\\pwsh.exe"}
config.keys = {
    {
        key = "n",
        mods = "CTRL",
        action = wezterm.action.ActivateTabRelative(1),
    },
    {
        key = "n",
        mods = "CTRL|SHIFT",
        action = wezterm.action.ActivateTabRelative(-1),
    },
    {
        key = "c",
        mods = "CTRL|SHIFT",
        action = wezterm.action.SpawnTab 'CurrentPaneDomain',
    }
}

-- and finally, return the configuration to wezterm
return config