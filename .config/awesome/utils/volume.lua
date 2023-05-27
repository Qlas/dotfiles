local awful = require("awful")
local naughty = require("naughty")

local update_volume = function(widget, status)

    level, status = string.match(status, "%[(%d+)%%%] %[(%a+)%]")
    widget:emit_signal("volume::update", level, status)
end

return function(widget)
    return awful.widget.watch("amixer sget Master", 1, update_volume, widget)
end
