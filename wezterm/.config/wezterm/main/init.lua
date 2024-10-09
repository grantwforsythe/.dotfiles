local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.window_padding = {
	left = 5,
	right = 5,
	bottom = 5,
	top = 5,
}

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
}

-----------------------------------------------
--                   Plugins                 --
-----------------------------------------------
local sessionizer = wezterm.plugin.require("https://github.com/ElCapitanSponge/sessionizer.wezterm")
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
