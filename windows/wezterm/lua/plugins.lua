-- This will hold the Muration.
local M = {}

M.apply_to_config = function(config)
  -- presentation plugin
  Wezterm.plugin.require("https://gitlab.com/xarvex/presentation.wez").apply_to_config(config)

	-- tmux plugin
	require("plugins/wez-tmux.plugin").apply_to_config(config, {})

	-- pain control plugin
	require("plugins/wez-pain-control.plugin").apply_to_config(config, {
		pane_resize = 5,
	})

	-- wezterm config plugin (https://github.com/winter-again/wezterm-config.nvim)
	local wezterm_config_nvim = Wezterm.plugin.require("https://github.com/winter-again/wezterm-config.nvim")
	Wezterm.on("user-var-changed", function(window, pane, name, value)
		local overrides = window:get_config_overrides() or {}
		overrides = wezterm_config_nvim.override_user_var(overrides, name, value)
		window:set_config_overrides(overrides)
	end)

	-- modal plugin (https://github.com/MLFlexer/modal.wezterm)
  Modal = Wezterm.plugin.require("https://github.com/MLFlexer/modal.wezterm")
  Modal.enable_defaults("https://github.com/MLFlexer/modal.wezterm")
  local key_table = require("ui_mode").key_table

  local icons = {
    left_seperator = Wezterm.nerdfonts.ple_left_half_circle_thick,
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

  Modal.add_mode("UI", key_table, status_text)
  config.key_tables = Modal.key_tables
end

return M
