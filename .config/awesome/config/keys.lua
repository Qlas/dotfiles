local awful = require('awful')
local hotkeys_popup = require('awful.hotkeys_popup')
local constants = require("constants")
local modkey = constants.mod
local terminal = constants.terminal
local gears = require('gears')
-- General Awesome keys
awful.keyboard.append_global_keybindings({
    awful.key({modkey}, "s", hotkeys_popup.show_help,
              {description = "show help", group = "awesome"}),
    awful.key({modkey, "Control"}, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({modkey, "Shift"}, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    awful.key({modkey}, "x", function()
        awful.prompt.run {
            prompt = "Run Lua code: ",
            textbox = awful.screen.focused().mypromptbox.widget,
            exe_callback = awful.util.eval,
            history_path = awful.util.get_cache_dir() .. "/history_eval"
        }
    end, {description = "lua execute prompt", group = "awesome"}),
    awful.key({modkey}, "Return", function() awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({modkey}, "r",
              function() awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"})
})

-- Tags related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({modkey, "Mod1"}, "Left", awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({modkey, "Mod1"}, "Right", awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({modkey}, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"})
})

-- Focus related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({modkey}, "Right", function() awful.client.focus.byidx(1) end,
              {description = "focus next by index", group = "client"}),
    awful.key({modkey}, "Left", function() awful.client.focus.byidx(-1) end,
              {description = "focus previous by index", group = "client"}),
    awful.key({modkey}, "Tab", function()
        awful.client.focus.history.previous()
        if client.focus then client.focus:raise() end
    end, {description = "go back", group = "client"}),
    awful.key({modkey, "Control"}, "Right",
              function() awful.screen.focus_relative(1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({modkey, "Control"}, "Left",
              function() awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({modkey, "Control"}, "n", function()
        local c = awful.client.restore()
        -- Focus restored client
        if c then c:activate{raise = true, context = "key.unminimize"} end
    end, {description = "restore minimized", group = "client"})
})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({modkey, "Shift"}, "Right",
              function() awful.client.swap.byidx(1) end, {
        description = "swap with next client by index",
        group = "client"
    }), awful.key({modkey, "Shift"}, "Left",
                  function() awful.client.swap.byidx(-1) end, {
        description = "swap with previous client by index",
        group = "client"
    }), awful.key({modkey}, "u", awful.client.urgent.jumpto,
                  {description = "jump to urgent client", group = "client"}),
    awful.key({modkey}, "l", function() awful.tag.incmwfact(0.05) end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({modkey}, "h", function() awful.tag.incmwfact(-0.05) end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({modkey, "Shift"}, "h",
              function() awful.tag.incnmaster(1, nil, true) end, {
        description = "increase the number of master clients",
        group = "layout"
    }), awful.key({modkey, "Shift"}, "l",
                  function() awful.tag.incnmaster(-1, nil, true) end, {
        description = "decrease the number of master clients",
        group = "layout"
    }), awful.key({modkey, "Control"}, "h",
                  function() awful.tag.incncol(1, nil, true) end, {
        description = "increase the number of columns",
        group = "layout"
    }), awful.key({modkey, "Control"}, "l",
                  function() awful.tag.incncol(-1, nil, true) end, {
        description = "decrease the number of columns",
        group = "layout"
    }), awful.key({modkey}, "space", function() awful.layout.inc(1) end,
                  {description = "select next", group = "layout"}),
    awful.key({modkey, "Shift"}, "space", function() awful.layout.inc(-1) end,
              {description = "select previous", group = "layout"})
})

-- @DOC_NUMBER_KEYBINDINGS@

awful.keyboard.append_global_keybindings({
    awful.key {
        modifiers = {modkey},
        keygroup = "numrow",
        description = "only view tag",
        group = "tag",
        on_press = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then tag:view_only() end
        end
    }, awful.key {
        modifiers = {modkey, "Control"},
        keygroup = "numrow",
        description = "toggle tag",
        group = "tag",
        on_press = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then awful.tag.viewtoggle(tag) end
        end
    }, awful.key {
        modifiers = {modkey, "Shift"},
        keygroup = "numrow",
        description = "move focused client to tag",
        group = "tag",
        on_press = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then client.focus:move_to_tag(tag) end
            end
        end
    }, awful.key {
        modifiers = {modkey, "Control", "Shift"},
        keygroup = "numrow",
        description = "toggle focused client on tag",
        group = "tag",
        on_press = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then client.focus:toggle_tag(tag) end
            end
        end
    }, awful.key {
        modifiers = {modkey},
        keygroup = "numpad",
        description = "select layout directly",
        group = "layout",
        on_press = function(index)
            local t = awful.screen.focused().selected_tag
            if t then t.layout = t.layouts[index] or t.layout end
        end
    }
})

-- {{{ Mouse bindings
-- @DOC_ROOT_BUTTONS@
awful.mouse.append_global_mousebindings({
    awful.button({}, 4, awful.tag.viewprev),
    awful.button({}, 5, awful.tag.viewnext)
})
-- }}}

-- {{{ Key bindings
-- @DOC_GLOBAL_KEYBINDINGS@

-- @DOC_CLIENT_BUTTONS@
client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button({}, 1, function(c)
            c:activate{context = "mouse_click"}
        end), awful.button({modkey}, 1, function(c)
            c:activate{context = "mouse_click", action = "mouse_move"}
        end), awful.button({modkey}, 3, function(c)
            c:activate{context = "mouse_click", action = "mouse_resize"}
        end)
    })
end)

-- @DOC_CLIENT_KEYBINDINGS@
client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        awful.key({modkey}, "f", function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end, {description = "toggle fullscreen", group = "client"}),
        awful.key({modkey, "Shift"}, "c", function(c) c:kill() end,
                  {description = "close", group = "client"}),
        awful.key({modkey, "Control"}, "space", awful.client.floating.toggle,
                  {description = "toggle floating", group = "client"}),
        awful.key({modkey, "Control"}, "Return",
                  function(c) c:swap(awful.client.getmaster()) end,
                  {description = "move to master", group = "client"}),
        awful.key({modkey, "Control", "Shift"}, "Right",
                  function(c) c:move_to_screen(c.screen.index + 1) end,
                  {description = "move to screen right", group = "client"}),
        awful.key({modkey, "Control", "Shift"}, "Left",
                  function(c) c:move_to_screen(c.screen.index - 1) end,
                  {description = "move to screen left", group = "client"}),

        awful.key({modkey, "Shift", "Mod1"}, "Left", function()
            local c = client.focus
            if not c then return end
            local t = c.screen.selected_tag
            local tags = c.screen.tags
            local idx = t.index
            local newtag = tags[gears.math.cycle(#tags, idx - 1)]
            c:move_to_tag(newtag)
            newtag:view_only()
        end, {description = "move client to previous tag", group = "tag"}),

        awful.key({modkey, "Shift", "Mod1"}, "Right", function()
            local c = client.focus
            if not c then return end
            local t = c.screen.selected_tag
            local tags = c.screen.tags
            local idx = t.index
            local newtag = tags[gears.math.cycle(#tags, idx + 1)]
            c:move_to_tag(newtag)
            newtag:view_only()
        end, {description = "move client to next tag", group = "tag"}),
        awful.key({modkey}, "t", function(c) c.ontop = not c.ontop end,
                  {description = "toggle keep on top", group = "client"}),
        awful.key({modkey}, "m", function(c)
            c.maximized = not c.maximized
            c:raise()
        end, {description = "(un)maximize", group = "client"}),
        awful.key({modkey, "Control"}, "m", function(c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end, {description = "(un)maximize vertically", group = "client"}),
        awful.key({modkey, "Shift"}, "m", function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end, {description = "(un)maximize horizontally", group = "client"})
    })
end)

-- Custom

awful.keyboard.append_global_keybindings({

    -- rofi
    awful.key({modkey, modkey}, "d",
              function() awful.spawn.with_shell("rofi -show drun") end,
              {description = "show Rofi", group = "launcher"}),

    -- betterlockscreen

    awful.key({modkey, "Control", "Shift"}, "l", function()
        awful.spawn.with_shell("betterlockscreen -l --display 1 --off 10")
    end, {description = "Lock screen", group = "Locking"}), -- volume
    awful.key({modkey}, "Page_Up",
              function() awful.spawn.with_shell("amixer sset Master 5%+") end,
              {description = "Volume Up", group = "volume"}),

    awful.key({modkey}, "Page_Down",
              function() awful.spawn.with_shell("amixer sset Master 5%-") end,
              {description = "Volume Down", group = "volume"}),

    awful.key({modkey}, "End", function()
        awful.spawn.with_shell("amixer sset Master toggle")
    end, {description = "Volume On/Off", group = "volume"})

})
