local wezterm = require("wezterm")
local act = wezterm.action

local keys = {
	-- Next tab
	{
		mods = "LEADER",
		key = "n",
		action = act.ActivateTabRelative(1),
	},
	-- Previous tab
	{
		mods = "LEADER",
		key = "p",
		action = act.ActivateTabRelative(-1),
	},
	-- Create new tab
	{
		mods = "LEADER",
		key = "c",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		mods = "LEADER",
		key = "-",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "=",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	-- Pane navigation with vim commands
	{
		mods = "LEADER",
		key = "h",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		mods = "LEADER",
		key = "j",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		mods = "LEADER",
		key = "k",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		mods = "LEADER",
		key = "l",
		action = act.ActivatePaneDirection("Right"),
	},
	-- Close current pane
	{
		mods = "LEADER",
		key = "x",
		action = act.CloseCurrentPane({ confirm = true }),
	},
	-- Close current tab
	{
		mods = "LEADER",
		key = "X",
		action = act.CloseCurrentTab({ confirm = true }),
	},
	-- Toggle fullscreen
	{
		mods = "LEADER",
		key = "f",
		action = act.ToggleFullScreen,
	},
	-- Show all tabs in workspace
	{
		mods = "LEADER",
		key = "t",
		action = act.ShowTabNavigator,
	},
	-- Rename tab
	{
		mods = "LEADER",
		key = "r",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	{
		mods = "LEADER",
		key = "m",
		action = act.TogglePaneZoomState,
	},
}

for i = 1, 9 do
	table.insert(keys, {
		mods = "LEADER",
		key = tostring(i),
		action = act.ActivateTab(i - 1),
	})
end

return keys
