-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Catppuccin Mocha'

local font_family = 'JetBrainsMono Nerd Font'
local font_size = 14
config.font = wezterm.font({
  family = font_family,
  weight = 'Medium',
})
config.font_size = font_size

-- and finally, return the configuration to wezterm
return config

