local wezterm = require("wezterm")

local config = require("main.global.config")
local utils = require("main.global.utils")

if utils.is_windows and os.getenv("USE_WSL") ~= nil then
	config.default_domain = "WSL:Ubuntu"
elseif utils.is_windows then
	config.default_prog = { "powershell", "-NoLogo" }
	config.launch_menu = {
		{
			label = "PowerShell",
			args = { "powershell.exe", "-NoLogo" },
		},
	}
end

config.keys = require("main.global.remap")

-- To update all plugins type CTLR + Shift + L to open debug mode
-- Then run the command `wezterm.plugin.update_all()` to update all plugins
local sessionizer = wezterm.plugin.require "https://github.com/grantwforsythe/sessionizer.wezterm"
sessionizer.apply_to_config(config)

return config
