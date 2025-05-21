-- This will hold the Muration.
local M = {}

M.apply_to_config = function(config)
	config.keys = {
		-- {
		-- 	key = "1",
		-- 	mods = "CTRL|ALT",
		-- 	action = Wezterm.action.SpawnCommandInNewTab({
		-- 		args = { "pwsh.exe" },
		-- 		domain = { DomainName = "local" },
		-- 	}),
		-- },
		-- {
		-- 	key = "2",
		-- 	mods = "CTRL|ALT",
		-- 	action = Wezterm.action.SpawnCommandInNewTab({
		-- 		args = { "wsl.exe" },
		-- 		domain = { DomainName = "local" },
		-- 	}),
		-- },
		{
			key = "u",
			mods = "ALT",
			action = Modal.activate_mode("UI"),
		},
	}
end

return M
