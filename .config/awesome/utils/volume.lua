local awful = require("awful")

local update_volume = function(widget, status)

    local level, volume_status = string.match(status, "%[(%d+)%%%] %[(%a+)%]")
    widget:emit_signal("volume::update", level, volume_status)
end

return function(widget)
    return awful.widget.watch("amixer sget Master", 1, update_volume, widget)
end
