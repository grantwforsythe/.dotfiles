local wezterm = require("wezterm")
local func = require("main.plugins.func")

--- SessionizerPlugin provides workspace and session management utilities for WezTerm.
--- @class SessionizerPlugin
--- @field apply_to_config fun(config: table, opts: table): nil
---        Applies keybindings for workspace switching and listing to the given config.

---@type SessionizerPlugin
local M = {
	apply_to_config = function(config, opts)
		if config == nil or config.keys == nil then
			return
		end

		if opts ~= nil then
			func.setup(opts)
		end

		table.insert(config.keys, {
			key = "f",
			mods = "CTRL",
			action = func.workspace_switcher(),
		})

		table.insert(config.keys, {
			key = "s",
			mods = "CTRL",
			action = func.active_workspaces(),
		})
	end,
}

return M
