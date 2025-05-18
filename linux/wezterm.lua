-- Pull in the wezterm API
Wezterm = require("wezterm")

-- This will hold the configuration.
local config = Wezterm.config_builder()

-- This is where you actually apply your config
local appearance = require("lua.appearance")
appearance.apply_to_config(config)
local plugins = require("lua.plugins")
plugins.apply_to_config(config)
local keymap = require("lua.keymap")
keymap.apply_to_config(config)

config.default_prog = { "fish" }
config.scrollback_lines = 3000
config.status_update_interval = 2000
config.initial_rows = 30
config.initial_cols = 135

-- and finally, return the configuration to wezterm
return config
