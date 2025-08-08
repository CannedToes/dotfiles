-- Pull in the wezterm API
Wezterm = require("wezterm")

-- This will hold the configuration.
local config = Wezterm.config_builder()

-- Apply on GUI start
Wezterm.on("gui-startup", function(cmd)
	local screen = Wezterm.gui.screens().active
	local ratio = 0.75
	local width, height = screen.width * ratio, screen.height * ratio
	local tab, pane, window = Wezterm.mux.spawn_window({
		position = {
			x = (screen.width - width) / 2,
			y = (screen.height - height) / 2,
			origin = "ActiveScreen",
		},
	})
	-- window:gui_window():maximize()
	window:gui_window():set_inner_size(width, height)
end)

-- This is where you actually apply your config
local appearance = require("lua.appearance")
appearance.apply_to_config(config)

config.default_prog = { "pwsh.exe" }
config.scrollback_lines = 3000
config.status_update_interval = 2000

-- and finally, return the configuration to wezterm
return config
