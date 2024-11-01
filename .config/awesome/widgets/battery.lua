local wibox = require("wibox")
local beautiful = require("beautiful")
local awful = require("awful")

local get_icon = function(percent, status)
	if status == "Charging" then
		return "󰂄"
	end

	percent = tonumber(percent)
	if percent > 80 then
		return "󰂁"
	elseif percent > 70 then
		return "󰂀"
	elseif percent > 60 then
		return "󰁿"
	elseif percent > 50 then
		return "󰁾"
	elseif percent > 40 then
		return "󰁽"
	elseif percent > 30 then
		return "󰁼"
	elseif percent > 20 then
		return "󰁻"
	elseif percent > 10 then
		return "󰁺"
	else
		return "󰂃"
	end
end

return function()
	local battery_icon = wibox.widget({
		font = beautiful.font,
		forced_width = beautiful.spacing_lg,
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
	})
	local battery_level = wibox.widget({
		font = beautiful.font,
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
		text = "123",
	})

	local percentage = wibox.container.background(battery_level)
	local battery_widget = wibox.widget({

		battery_icon,
		percentage,
		spacing = beautiful.spacing,
		widget = wibox.layout.fixed.horizontal,
	})

	local battery_t = awful.tooltip({
		objects = { battery_widget },
		align = "bottom",
		preferred_alignments = "middle",
		mode = "outside",
	})

	battery_widget:connect_signal("battery::update", function(_, status, level, timing)
		battery_level.text = level .. "%"
		battery_icon.markup = get_icon(level, status)
		battery_t.text = status .. "\n" .. timing:match("^%s*(.-)%s*$")
	end)

	return battery_widget
end
