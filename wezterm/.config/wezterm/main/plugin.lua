local wezterm = require("wezterm")
local act = wezterm.action

---@type { paths: string[] }
--TODO: Automatically resolve the path
-- TODO: Add option to set additional args
local sessionizer_config = { paths = { "." } }
-- local defaults = { paths = { wezterm.home_dir } }

local is_windows = string.find(wezterm.target_triple, "windows") ~= nil

---Retrieve the directories found within the base_path table
---@return { id: string, label: string }[]
local get_directories = function()
	local folders = {}

	-- TODO: rewrite
	local process_args = { os.getenv("SHELL"), "-c", cmd }
	if is_windows then
		process_args = { "cmd", "/c", cmd }
	end
	-- TODO: Add check if on windows
	-- TODO: Handle zoxide
	local success, stdout, stderr = wezterm.run_child_process({
		"cmd",
		"/c",
		"fd",
		".",
		"-a",
		"--type",
		"d",
		"--max-depth",
		"1",
		table.concat(sessionizerConfig.paths, " "),
	})

	if not success then
		wezterm.log_error(stderr)
	end

	for _, path in ipairs(wezterm.split_by_newlines(stdout)) do
		local updated_path = string.gsub(path, wezterm.home_dir, "~")
		table.insert(folders, { id = path, label = updated_path })
	end

	return folders
end

--- @field workspace_switcher fun(): function
---        Presents an input selector to switch between directories as workspaces.
local workspace_switcher = function()
	return wezterm.action_callback(function(window, pane)
		local workspaces = get_directories()

		window:perform_action(
			act.InputSelector({
				action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
					if not id and not label then
						-- INFO: Do nothing
					else
						local full_path = string.gsub(label, "^~", wezterm.home_dir)
						wezterm.log_info("Switching to workspace: " .. full_path)

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

--- @field active_workspaces fun(): table
---        Shows a launcher listing all active workspaces.
local active_workspaces = function()
	return act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" })
end

--- SessionizerPlugin provides workspace and session management utilities for WezTerm.
--- @class SessionizerPlugin
--- @field apply_to_config fun(config: table): nil
---        Applies keybindings for workspace switching and listing to the given config.

---@type SessionizerPlugin
local M = {}

M.apply_to_config = function(config, opts)
	if config == nil or config.keys == nil then
		return
	end

	table.insert(config.keys, {
		key = "f",
		mods = "CTRL",
		action = workspace_switcher(),
	})

	table.insert(config.keys, {
		key = "s",
		mods = "CTRL",
		action = active_workspaces(),
	})
end

return M
