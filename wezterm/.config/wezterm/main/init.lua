local wezterm = require("wezterm")

local config = require("main.global.config")

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_prog = { "powershell", "-NoLogo" }
	config.launch_menu = {
		{
			label = "PowerShell",
			args = { "powershell.exe", "-NoLogo" },
		},
	}
end

config.keys = require("main.global.remap")

local sessionizer = wezterm.plugin.require("https://github.com/grantwforsythe/sessionizer.wezterm")
sessionizer.apply_to_config(config, { paths = { "~\\repos" } })

return config
