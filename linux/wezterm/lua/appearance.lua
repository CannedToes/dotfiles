-- This will hold the Muration.
local M = {}

M.apply_to_config = function(config)
  config.color_scheme = 'Gruvbox dark, hard (base16)'
	config.font = Wezterm.font("RobotoMono Nerd Font", { weight = "Medium" })
	config.font_size = 13
	config.window_background_opacity = 0.80
	config.enable_tab_bar = true
	config.use_fancy_tab_bar = true
	config.hide_tab_bar_if_only_one_tab = true
	config.max_fps = 120
	-- config.kde_window_background_blur = true
	config.window_decorations = "NONE"
	config.window_close_confirmation = "NeverPrompt"
	config.default_cursor_style = "BlinkingBar"
end

return M
