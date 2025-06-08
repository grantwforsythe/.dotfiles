local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

config.color_scheme = "Gruvbox dark, medium (base16)"

config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = true

config.window_padding = {
	left = 0,
	right = 0,
	bottom = 0,
	top = 0,
}

config.font_size = 14.0

config.window_close_confirmation = "NeverPrompt"

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }

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
	}
end)

return config
