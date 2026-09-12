-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Tokyo Night'

config.wsl_domains = {
  {
    name = "WSL:Ubuntu",
    distribution = "Ubuntu",
    default_cwd = "~",
    default_prog = { "bash", "-ic", "exec nu" }, 
  },
}

if wezterm.target_triple:find("windows") then
    -- Works as long as nushell is in PATH
    config.default_domain = "WSL:Ubuntu" 
end

config.window_decorations = "RESIZE"
config.window_frame = {
    inactive_titlebar_bg = "none",
    active_titlebar_bg = "none",
}

config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.use_fancy_tab_bar = false

-- Fixes visual glitches, might remove later
config.front_end = 'WebGpu'
config.keys = {
    {
        key = "l",
        mods = "CTRL",
        action = wezterm.action.ActivateTabRelative(1),
    },
    {
        key = "h",
        mods = "CTRL",
        action = wezterm.action.ActivateTabRelative(-1),
    },
    {
        key = "n",
        mods = "CTRL",
        action = wezterm.action.SpawnTab 'CurrentPaneDomain',
    },
    {
        key = 'f',
        mods = 'CTRL',
        action = wezterm.action.ToggleFullScreen,
    },
}

-- and finally, return the configuration to wezterm
return config