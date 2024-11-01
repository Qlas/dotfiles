local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local widgets = require("widgets")
local date = wibox.widget.textclock("%a %b %d %Y")
local utils = require("utils")

local volume_widget = widgets.volume()
local volume_watcher = utils.volume(volume_widget)

local function read_file(path)
	local file = io.open(path, "r")
	if not file then
		return nil
	end
	local content = file:read("*l")
	file:close()
	return content
end

local get_battery_icon = function(percent, status)
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

local wrap_bg = function(widgets_)
	return wibox.widget({
		{
			widgets_,
			left = beautiful.spacing_lg,
			right = beautiful.spacing_lg,
			top = beautiful.spacing,
			bottom = beautiful.spacing,
			widget = wibox.container.margin,
		},
		shape = function(cr, width, height)
			gears.shape.rounded_rect(cr, width, height, 20)
		end,
		bg = beautiful.bg_normal,
		widget = wibox.container.background,
	})
end

local ip = wibox.widget({
	font = beautiful.font,
	align = "center",
	valign = "center",
	widget = wibox.widget.textbox,
	text = "",
})

local set_ip = function(stdout)
	ip.text = stdout
end

awful.spawn.easy_async_with_shell("hostname -i | awk '{print $1}'", set_ip)

local battery = wibox.widget({
	font = beautiful.font,
	align = "center",
	valign = "center",
	widget = wibox.widget.textbox,
	text = "",
})

local battery_t = awful.tooltip({
	objects = { battery },
	align = "bottom",
	preferred_alignments = "middle",
	mode = "outside",
})

battery:connect_signal("mouse::enter", function(_, _, _, _)
	battery_t.text = read_file("/sys/class/power_supply/BAT1/status")
end)

gears.timer({
	timeout = 5,
	call_now = true,
	autostart = true,
	callback = function()
		local capacity = read_file("/sys/class/power_supply/BAT1/capacity")
		local status = read_file("/sys/class/power_supply/BAT1/status")

		battery.text = get_battery_icon(capacity, status) .. " " .. capacity .. "%"
	end,
})
-- @DOC_FOR_EACH_SCREEN@
screen.connect_signal("request::desktop_decoration", function(s)
	-- Each screen has its own tag table.
	awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist({
		screen = s,
		buttons = taglist_buttons,
		filter = awful.widget.taglist.filter.all,
		layout = {
			layout = wibox.layout.fixed.horizontal,
			spacing = beautiful.spacing,
		},
		style = { shape = gears.shape.circle },
		widget_template = {
			{
				{
					{ id = "text_role", widget = wibox.widget.textbox },
					layout = wibox.layout.fixed.horizontal,
				},
				left = beautiful.spacing,
				right = beautiful.spacing,
				widget = wibox.container.margin,
			},
			id = "background_role",
			widget = wibox.container.background,
		},
	})

	-- @DOC_WIBAR@
	-- Create the wibox
	s.mywibox = awful.wibar({
		height = beautiful.bar_height,
		type = "dock",
		bg = "#00000000",
		position = "top",
		screen = s,
		widget = {
			{
				layout = wibox.layout.stack,
				{
					layout = wibox.layout.align.horizontal,
					{ -- Left
						layout = wibox.layout.fixed.horizontal,
						wrap_bg(s.mytaglist),
					},

					nil,
					{ -- Right
						layout = wibox.layout.fixed.horizontal,
						spacing = beautiful.spacing,
						wrap_bg(battery),
						wrap_bg(ip),
						wrap_bg(volume_widget),
						wrap_bg(date),
					},
				},
				{
					wrap_bg(widgets.clock()),
					valign = "center",
					halign = "center",
					layout = wibox.container.place,
					visible = visible,
				},
			},
			left = beautiful.useless_gap * 2,
			right = beautiful.useless_gap * 2,
			top = beautiful.useless_gap,
			widget = wibox.container.margin,
		},
	})
end)
