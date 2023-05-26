local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gears = require("gears")
local naughty = require("naughty")
local constants = require("constants")

local theme_path = gears.filesystem.get_configuration_dir() .. "config/"

local theme = {}

theme.transparent = "#00000000"
theme.font = "JetBrains Mono Nerd Font Bold 10"

theme.black = "#16161D"
theme.red = "#E46876"
theme.yellow = "#F2D98C"
theme.orange = "#FFA066"
theme.green = "#A8C98F"
theme.white = "#D3D3D3"

-- bg
theme.bg_normal = theme.black
theme.bg_focus = theme.red
theme.bg_urgent = theme.red
theme.bg_systray = theme.bg_normal

-- fg
theme.fg_normal = theme.white
theme.fg_focus = theme.yellow
theme.fg_urgent = theme.white

-- spacing
theme.spacing = dpi(5)
theme.spacing_md = dpi(12)
theme.spacing_lg = dpi(16)
theme.spacing_xl = dpi(20)

-- border
theme.useless_gap = dpi(5)
theme.border_width = dpi(1)
theme.border_radius = dpi(10)
theme.border_focus = theme.bg_focus
theme.border_normal = theme.bg_normal

-- taglist
theme.taglist_bg = theme.bg_normal
theme.taglist_bg_focus = theme.green
theme.taglist_bg_urgent = theme.red
theme.taglist_fg_focus = theme.bg_normal
theme.taglist_fg_occupied = theme.green

-- wallpaper
theme.wallpaper = theme_path .. "background.jpg"

-- bar
theme.bar_height = dpi(40)

-- system tray
theme.systray_icon_spacing = theme.spacing
theme.systray_max_rows = 7

return theme
