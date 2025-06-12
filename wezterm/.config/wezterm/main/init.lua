local wezterm = require("wezterm")

local config = require("main.global.config")

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    config.default_prog = { "powershell", "-NoLogo" }
    config.launch_menu = {
        {
            label = "PowerShell",
            args = { "powershell.exe", "-NoLogo" },
        },
    }
end

config.keys = require("main.global.remap")

--NOTE: Use file URL, e.g. 'file:///C:/User/...', when developing a plugin locally
local sessionizer = wezterm.plugin.require("https://github.com/grantwforsythe/sessionizer.wezterm")
sessionizer.apply_to_config(config,
    { paths = { "~\\repos" }, add_workspace_to_zoxide = true }
)

return config
