local awful = require("awful")

local update_battery = function(widget, status)
	local status, level, timing = string.match(status, ".+: ([%a%s]+), (%d?%d?%d)%%,?(.*)")

	widget:emit_signal("battery::update", status, level, timing)
end

return function(widget)
	return awful.widget.watch("acpi", 1, update_battery, widget)
end
