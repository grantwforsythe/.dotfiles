local wezterm = require("wezterm")
local act = wezterm.action

wezterm.on("augment-command-palette", function(window, pane)
	return {
		{
			brief = "Plugin: Update All Plugins",
			icon = "cod_github_inverted",
			doc = "Attempt to fast-forward each of the repos in the plugin directory.",
			action = wezterm.action_callback(function(_window, _pane)
				wezterm.plugin.update_all()
				-- Reload the configuration to reflect any changes
				wezterm.reload_configuration()
			end),
		},
		{
			brief = "Rename current tab",
			doc = "Rename the current tab",
			action = act.PromptInputLine({
				description = "Enter new name for tab",
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},
	}
end)

local config = wezterm.config_builder()

config.color_scheme = "Gruvbox dark, medium (base16)"

config.hide_tab_bar_if_only_one_tab = true

config.use_fancy_tab_bar = true

config.window_padding = {
	left = 0,
	right = 0,
	bottom = 0,
	top = 0,
}

config.font_size = 14.0

config.window_close_confirmation = "NeverPrompt"

config.set_environment_variables = {
	LANG = "en_US.UTF-8",
	PATH = wezterm.executable_dir .. ";" .. os.getenv("PATH"),
}

config.colors = {
	tab_bar = {
		new_tab = { bg_color = "#121212", fg_color = "#FCE8C3", intensity = "Bold" },
		new_tab_hover = { bg_color = "#121212", fg_color = "#FBB829", intensity = "Bold" },
		active_tab = { bg_color = "#121212", fg_color = "#FCE8C3" },
	},
}

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }

return config
