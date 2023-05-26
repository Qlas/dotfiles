local wibox = require("wibox")

return function()
    local clock_local = wibox.widget.textclock("%H:%M")
    local clock_utc = wibox.widget.textclock(" " .. "%H:%M %Z", nil, "UTC")
    clock_utc.visible = false

    local clock = wibox.widget({
        {widget = clock_local, id = "text_role"},
        {widget = clock_utc, id = "text_role"},
        widget = wibox.layout.fixed.horizontal
    })
    clock:connect_signal("button::press", function(_, _, _, button)
        if button == 1 then
            clock_local.visible = not clock_local.visible
            clock_utc.visible = not clock_utc.visible
        end
    end)
    return clock
end
