local wezterm = require("wezterm")
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

return config
