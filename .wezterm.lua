-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config
config.default_prog = { "fish" }
config.color_scheme = "Gruvbox Dark (Gogh)"
config.font = wezterm.font("RobotoMono Nerd Font")
config.font_size = 15
config.line_height = 0.87
config.window_background_opacity = 0.96
config.enable_tab_bar = true
config.window_close_confirmation = "NeverPrompt"
config.use_fancy_tab_bar = true
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500
config.max_fps = 120
config.window_decorations = "RESIZE"

config.window_padding = {
	left = 16,
	right = 0,
	top = 0,
	bottom = 0,
}

-- plugins and all configuration regarding them
local modal = wezterm.plugin.require("https://github.com/MLFlexer/modal.wezterm")
require("wez-pain-control.plugin").apply_to_config(config, {
	pane_resize = 5,
})
require("wez-tmux.plugin").apply_to_config(config, {})

modal.enable_defaults("https://github.com/MLFlexer/modal.wezterm")
-- "ui_mode" can be replaced by any filename from the /defaults directory
local key_table = require("ui_mode").key_table

local icons = {
	left_seperator = wezterm.nerdfonts.ple_left_half_circle_thick,
	key_hint_seperator = " | ",
	mod_seperator = "-",
}
local hint_colors = {
	key_hint_seperator = "Yellow",
	key = "Green",
	hint = "Red",
	bg = "Black",
	left_bg = "Gray",
}
local mode_colors = { bg = "Red", fg = "Black" }
local status_text = require("ui_mode").get_hint_status_text(icons, hint_colors, mode_colors)

modal.add_mode("UI", key_table, status_text)

config.keys = {
	{
		key = "1",
		mods = "CTRL|ALT",
		action = wezterm.action.SpawnCommandInNewTab({
			args = { "pwsh.exe" },
			domain = { DomainName = "local" },
		}),
	},
	{
		key = "2",
		mods = "CTRL|ALT",
		action = wezterm.action.SpawnCommandInNewTab({
			args = { "wsl.exe" },
			domain = { DomainName = "local" },
		}),
	},
	{
		key = "u",
		mods = "ALT",
		action = modal.activate_mode("UI"),
	},
}
config.key_tables = modal.key_tables
-- and finally, return the configuration to wezterm
return config
