local wezterm = require("wezterm")

-- Maximize on startup
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

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

table.insert(config.keys, {
	mods = "CTRL",
	key = "f",
	action = sessionizer.switch_workspace(),
})

return config
