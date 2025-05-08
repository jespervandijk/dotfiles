-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Tokyo Night'
config.default_prog = {"C:/Users/j.vandijk/AppData/Local/Programs/nu/bin/nu.exe"}
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
    },
    {
        key = "q",
        mods = "CTRL|SHIFT",
        action = wezterm.action.CloseCurrentTab { confirm = false },
    }
}

-- and finally, return the configuration to wezterm
return config