local gears = require("gears")

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local theme_path = gears.filesystem.get_configuration_dir() .. "config/"

local theme = {}

theme.font = "sans 8"

theme.bg_normal = "#222222"
theme.bg_focus = "#535d6c"
theme.bg_urgent = "#ff0000"
theme.bg_minimize = "#444444"
theme.bg_systray = theme.bg_normal

theme.fg_normal = "#aaaaaa"
theme.fg_focus = "#ffffff"
theme.fg_urgent = "#ffffff"
theme.fg_minimize = "#ffffff"

theme.useless_gap = dpi(0)
theme.border_width = dpi(1)
theme.border_normal = "#000000"
theme.border_focus = "#535d6c"
theme.border_marked = "#91231c"

theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

-- Define the image to load
theme.wallpaper = theme_path .. "background.jpg"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height,
                                               theme.bg_focus, theme.fg_focus)

theme.icon_theme = nil

return theme
