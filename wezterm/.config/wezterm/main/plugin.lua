local wezterm = require("wezterm")
local act = wezterm.action

--- SessionizerPlugin provides workspace and session management utilities for WezTerm.
--- @class SessionizerPlugin
--- @field workspace_switcher fun(): function
---        Presents an input selector to switch between directories as workspaces.
--- @field active_workspaces fun(): table
---        Shows a launcher listing all active workspaces.
--- @field apply_to_config fun(config: table): nil
---        Applies keybindings for workspace switching and listing to the given config.

---@type SessionizerPlugin
local M = {}
local defaults = {}

---Retrieve the directories found within the base_path table
---@return { id: string, label: string }[]
local get_directories = function()
	local folders = {}
	local success, stdout, stderr = wezterm.run_child_process({
		"fd",
		"--hidden",
		"--type d",
		"--max-depth 1",
		"--exclude .github",
		"repos"
	})

	if not success then
		error(stderr)
	end

	for _, path in ipairs(wezterm.split_by_newlines(stdout)) do
		local updated_path = string.gsub(path, wezterm.home_dir, "~")
		table.insert(folders, { id = path, label = updated_path })
	end

	return folders
end

M.workspace_switcher = function()
	return wezterm.action_callback(function(window, pane)
		local workspaces = get_directories()

		window:perform_action(
			act.InputSelector({
				action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
					if not id and not label then
						-- INFO: Do nothing
					else
						local full_path = string.gsub(label, "^~", wezterm.home_dir)

						if full_path:sub(1, 1) == "/" or full_path:sub(3, 3) == "\\" then
							inner_window:perform_action(
								act.SwitchToWorkspace({
									name = label,
									spawn = {
										label = "Workspace: " .. label,
										cwd = full_path,
									},
								}),
								inner_pane
							)
						else
							inner_window:perform_action(
								act.SwitchToWorkspace({
									name = id,
								}),
								inner_pane
							)
						end
					end
				end),
				title = "Wezterm Sessionizer",
				choices = workspaces,
				fuzzy = true,
			}),
			pane
		)
	end)
end

M.active_workspaces = function()
	return act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" })
end

M.apply_to_config = function(config)
	table.insert(config.keys, {
		key = "f",
		mods = "CTRL",
		action = M.workspace_switcher(),
	})

	table.insert(config.keys, {
		key = "s",
		mods = "CTRL",
		action = M.active_workspaces(),
	})
end

return M
