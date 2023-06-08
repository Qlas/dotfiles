pcall(require, "luarocks.loader")

local gears = require("gears")
require("awful.autofocus")
local beautiful = require("beautiful")
local naughty = require("naughty")
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title = "Oops, an error happened" ..
            (startup and " during startup!" or "!"),
        message = message
    }
end)
-- }}}

beautiful.init(gears.filesystem.get_configuration_dir() .. "config/theme.lua")

-- imports
require("config.keys")
require("config.layout")
require("config.rules")
require("config.wibar")
require("config.wallpaper")
require("config.notifications")
require("config.signals")
