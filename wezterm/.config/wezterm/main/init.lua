local wezterm = require("wezterm")

-- Maximize on startup
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

local config = wezterm.config_builder()

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_prog = { "powershell", "-NoLogo" }
	config.launch_menu = {
		{
			label = "PowerShell",
			args = { "powershell.exe", "-NoLogo" },
		},
	}
end

config.hide_tab_bar_if_only_one_tab = true

config.window_padding = {
	left = 5,
	right = 5,
	bottom = 5,
	top = 5,
}

-- TODO: Add key maps to select specific windows

config.font_size = 14.0

config.window_close_confirmation = "NeverPrompt"

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	-- Next tab
	{
		mods = "LEADER",
		key = "n",
		action = wezterm.action.ActivateTabRelative(1),
	},
	-- Previous tab
	{
		mods = "LEADER",
		key = "p",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	-- Create new tab
	{
		mods = "LEADER",
		key = "c",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		mods = "LEADER",
		key = "-",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "=",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "x",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		mods = "LEADER",
		key = "&",
		action = wezterm.action.CloseCurrentTab({ confirm = true }),
	},
	{
		mods = "LEADER",
		key = "m",
		action = wezterm.action.ToggleFullScreen,
	},

	{
		mods = "LEADER",
		key = "t",
		action = wezterm.action.ShowTabNavigator,
	},
}

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
