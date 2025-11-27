-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Tokyo Night'

local nu_path;
if wezterm.target_triple:find("windows") then
    nu_path = os.getenv("LOCALAPPDATA") .. "/Programs/nu/bin/nu.exe"
elseif wezterm.target_triple:find("apple") then
    nu_path = "/opt/homebrew/bin/nu"
elseif wezterm.target_triple:find("linux") then
    nu_path = os.getenv("HOME") .. "/.nix-profile/bin/nu"
end

config.window_decorations = "RESIZE"
config.window_frame = {
    inactive_titlebar_bg = "none",
    active_titlebar_bg = "none",
}

config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.use_fancy_tab_bar = false

config.default_prog = { nu_path }

-- Fixes visual glitches, might remove later
config.front_end = 'WebGpu'
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
}

-- and finally, return the configuration to wezterm
return config