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

-----------------------------------------------
--                   Plugins                 --
-----------------------------------------------
local sessionizer = require("main.plugins.sessionizer")
local projects = {
	"~",
	"~/repos",
}

sessionizer.set_projects(projects)
sessionizer.configure(config)

return config
