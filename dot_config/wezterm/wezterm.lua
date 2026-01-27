local wezterm = require("wezterm")
local act = wezterm.action

local config = {}

config.automatically_reload_config = true

config.color_scheme = "Monokai (base16)"

config.font = wezterm.font_with_fallback({
  "SauceCodePro Nerd Font",
  "JetBrains Mono",
  "Noto Color Emoji",
})

config.font_size = 13.0

config.window_padding = {
  left = 8,
  right = 8,
  top = 6,
  bottom = 6,
}

config.initial_cols = 140
config.initial_rows = 38

config.window_background_opacity = 1.0
config.text_background_opacity = 1.0

config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 800
config.cursor_blink_ease_in = "EaseOut"
config.cursor_blink_ease_out = "EaseOut"

config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false

config.scrollback_lines = 10000

config.audible_bell = "Disabled"

config.selection_word_boundary = " \t\n{}[]()\"'`,;:"

config.hyperlink_rules = wezterm.default_hyperlink_rules()

config.window_close_confirmation = "NeverPrompt"

config.animation_fps = 60
config.max_fps = 120
config.front_end = "WebGpu"

return config
