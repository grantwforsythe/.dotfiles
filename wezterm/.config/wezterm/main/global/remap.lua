local wezterm = require("wezterm")
local action = wezterm.action

return {
	-- Next tab
	{
		mods = "LEADER",
		key = "n",
		action = action.ActivateTabRelative(1),
	},
	-- Previous tab
	{
		mods = "LEADER",
		key = "p",
		action = action.ActivateTabRelative(-1),
	},
	-- Create new tab
	{
		mods = "LEADER",
		key = "c",
		action = action.SpawnTab("CurrentPaneDomain"),
	},
	{
		mods = "LEADER",
		key = "-",
		action = action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "=",
		action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	-- Pane navigation with vim commands
	{
		mods = "LEADER",
		key = "h",
		action = action.ActivatePaneDirection("Left"),
	},
	{
		mods = "LEADER",
		key = "j",
		action = action.ActivatePaneDirection("Down"),
	},
	{
		mods = "LEADER",
		key = "k",
		action = action.ActivatePaneDirection("Up"),
	},
	{
		mods = "LEADER",
		key = "l",
		action = action.ActivatePaneDirection("Right"),
	},
	{
		mods = "LEADER",
		key = "x",
		action = action.CloseCurrentPane({ confirm = true }),
	},
	{
		mods = "LEADER",
		key = "X",
		action = action.CloseCurrentTab({ confirm = true }),
	},
	{
		mods = "LEADER",
		key = "f",
		action = action.ToggleFullScreen,
	},

	{
		mods = "LEADER",
		key = "t",
		action = action.ShowTabNavigator,
	},
}
