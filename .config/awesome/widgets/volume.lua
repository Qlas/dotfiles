local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")

local get_icon = function(level, status)
    if status == "off" then return "󰸈" end
    level = tonumber(level)
    if level >= 75 then
        return "󰕾"
    elseif level >= 40 then
        return "󰸈"
    elseif level >= 10 then
        return "󰸈"
    end
end

return function()
    local volume_icon = wibox.widget({
        font = beautiful.font,
        forced_width = beautiful.spacing_lg,
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox
    })
    local volume_level = wibox.widget({
        font = beautiful.font,
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox
    })
    local percentage = wibox.container.background(volume_level)
    local volume_widget = wibox.widget({

        volume_icon,
        percentage,
        spacing = beautiful.spacing,
        widget = wibox.layout.fixed.horizontal
    })
    volume_widget:connect_signal("volume::update", function(_, level, status)
        volume_level.text = level .. "%"
        volume_icon.markup = get_icon(level, status)
    end)

    return volume_widget
end
