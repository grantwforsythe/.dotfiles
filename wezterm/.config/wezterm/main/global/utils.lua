local wezterm = require("wezterm")

--- @class Utils
--- @field is_darwin boolean Returns true if the current platform is macOS (Darwin)
--- @field is_linux boolean Returns true if the current platform is Linux
--- @field is_windows boolean Returns true if the current platform is Windows
local M = {}

-- https://github.com/wez/wezterm/discussions/4728
M.is_darwin = wezterm.target_triple:find("darwin") ~= nil
M.is_linux = wezterm.target_triple:find("linux") ~= nil
M.is_windows = wezterm.target_triple:find("windows") ~= nil

return M
