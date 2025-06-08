local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux
-- TODO: check for existing sessions and put them to the top
-- TODO: create different formatters for other files
-- TODO: Handle zoxide

---@type { paths: string[] }
--TODO: Automatically resolve the path
-- TODO: Add option to set additional args
-- local sessionizer_config = { paths = { "~/repos" } }
-- local defaults = { paths = { wezterm.home_dir } }

local config = {
	paths = { "." },
}

local is_windows = string.find(wezterm.target_triple, "windows") ~= nil

local function run_child_process(cmd)
	local process_args
	if is_windows then
		process_args = {
			"cmd",
			"/c",
			cmd,
		}
	else
		process_args = { os.getenv("SHELL") or "/bin/sh", "-c", cmd }
	end

	local success, stdout, stderr = wezterm.run_child_process(process_args)

	if not success then
		--TODO: panic
		wezterm.log_error(stderr)
	end

	return stdout
end

--- Returns the file descriptor path as a string.
--- @return string fd_path The file descriptor path.
local function get_fd_path()
	local args
	if is_windows then
		args = "dir /s /b %USERPROFILE%\\AppData\\Local\\Microsoft\\WinGet\\Packages\\fd.exe"
	else
		args = "which fd"
	end

	local stdout = run_child_process(args)
	local fd_path
	if is_windows then
		-- On Windows, the output may contain a newline character at the end
		fd_path = string.gsub(stdout, "\r\n", "")
	else
		fd_path = string.gsub(stdout, "\n", "")
	end

	return fd_path
end

---Retrieve the directories found within the base_path table
---@return { id: string, label: string }[]
local function get_directories(paths)
	--- @type { id: string, label: string}[] folders
	local folders = {}

	-- TODO: Add the option to manually set the path
	local fd_path = config.fd_path or get_fd_path()

	local stdout = run_child_process(fd_path .. " . -a --type d --max-depth 1 " .. table.concat(config.paths, " "))

	for _, path in ipairs(wezterm.split_by_newlines(stdout)) do
		local updated_path = string.gsub(path, wezterm.home_dir, "~")
		table.insert(folders, { id = path, label = updated_path })
	end

	return folders
end

local function get_active_workspaces()
	local workspaces = {}

	for _, workspace in ipairs(mux.get_workspace_names()) do
		-- TODO: fix formatting
		local updated_path = string.gsub(workspace, "~", wezterm.home_dir)
		table.insert(workspaces, {
			id = updated_path,
			label = wezterm.format({ { Foreground = { Color = "yellow" } }, { Text = workspace } }),
		})
	end

	return workspaces
end

local M = {}

--- @field workspace_switcher fun(): function
---        Presents an input selector to switch between directories as workspaces.
M.workspace_switcher = function()
	return wezterm.action_callback(function(window, pane)
		local workspaces = get_directories()
		local active_workspaces = get_active_workspaces()
		-- Build a set of active workspace ids for quick lookup
		local active_ids = {}
		for _, ws in ipairs(active_workspaces) do
			active_ids[ws.id] = true
		end

		-- Only add workspaces that are not already active
		for _, ws in ipairs(workspaces) do
			if not active_ids[ws.id] then
				table.insert(active_workspaces, ws)
			end
		end

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
				choices = active_workspaces,
				fuzzy = true,
			}),
			pane
		)
	end)
end

--- @field active_workspaces fun(): table
---        Shows a launcher listing all active workspaces.
M.active_workspaces = function()
	return act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" })
end

M.setup = function(opts)
	if opts.paths == nil then
		return
	end

	for _, v in ipairs(opts.paths) do
		local transformed_path = string.gsub(v, "~", wezterm.home_dir)
		table.insert(config.paths, transformed_path)
	end
end

return M
