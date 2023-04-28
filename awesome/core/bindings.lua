local capi = Capi
local awful = require("awful")
local aplacement = require("awful.placement")
local beautiful = require("theme.theme")
local helper_client = require("utils.client")
local binding = require("io.binding")
local mod = binding.modifier
local btn = binding.button
local services = require("services")
local main_menu = require("ui.menu.main")
local menu_templates = require("ui.menu.templates")
local mebox = require("widget.mebox")
local config = require("config")

binding.add_global_range {
    binding.new {
        modifiers = { mod.super },
        triggers = "l",
        path = "system",
        description = "lock session",
        on_press = function() services.power.lock_screen() end,
    },

    binding.new {
        modifiers = {},
        triggers = btn.left,
        path = "awesome",
        description = "resize tiled clients",
        on_press = function() helper_client.mouse_resize(true) end,
    },

    binding.new {
        modifiers = {},
        triggers = btn.right,
        path = "awesome",
        description = "show main menu",
        on_press = function() main_menu:toggle(nil, { source = "mouse" }) end,
    },

    binding.new {
        modifiers = { mod.super, mod.shift },
        triggers = "r",
        path = "awesome",
        description = "restart awesome",
        on_press = function() capi.awesome.restart() end,
    },

    binding.new {
        modifiers = { mod.super },
        triggers = "r",
        path = "launcher",
        description = "run prompt",
        on_press = function() awful.spawn(config.actions.show_launcher) end,
    },

    binding.new {
        modifiers = { mod.super },
        triggers = "Return",
        path = "launcher",
        description = "terminal",
        on_press = function() awful.spawn(config.apps.terminal) end,
    },

    binding.new {
        modifiers = { mod.super },
        triggers = "e",
        path = "launcher",
        description = "file manager",
        on_press = function() awful.spawn(config.apps.file_manager) end,
    },

    binding.new {
        modifiers = { mod.super },
        triggers = "b",
        path = "launcher",
        description = "browser",
        on_press = function() awful.spawn(config.apps.browser) end,
    },

    binding.new {
        modifiers = { mod.super, mod.shift },
        triggers = "b",
        path = "launcher",
        description = "browser (private window)",
        on_press = function() awful.spawn(config.apps.private_browser) end,
    },

    binding.new {
        modifiers = { mod.super },
        triggers = "c",
        path = "launcher",
        description = "code editor",
        on_press = function() awful.spawn(config.apps.editor) end,
    },

    binding.new {
        modifiers = { mod.super, mod.shift },
        triggers = "c",
        path = "launcher",
        description = "color picker",
        on_press = function() awful.spawn(config.actions.color_picker) end,
    },

    binding.new {
        modifiers = {},
        triggers = "XF86Calculator",
        path = "launcher",
        description = "calculator",
        on_press = function() awful.spawn(config.apps.calculator) end,
    },

    binding.new {
        modifiers = { mod.super },
        triggers = "space",
        path = "layout",
        description = "select next layout",
        on_press = function() awful.layout.inc(1) end,
    },

    binding.new {
        modifiers = { mod.shift, mod.super },
        triggers = "space",
        path = "layout",
        description = "select previous layout",
        on_press = function() awful.layout.inc(-1) end,
    },

    binding.new {
        modifiers = {},
        triggers = {
            { trigger = "XF86AudioLowerVolume", direction = -1 },
            { trigger = "XF86AudioRaiseVolume", direction = 1 },
        },
        path = "volume",
        description = "change volume",
        on_press = function(trigger) services.volume.change_volume(trigger.direction * 5) end,
    },

    binding.new {
        modifiers = {},
        triggers = "XF86AudioMute",
        path = "volume",
        description = "mute",
        on_press = function() services.volume.toggle_mute() end,
    },

    binding.new {
        modifiers = {},
        triggers = "XF86AudioPlay",
        path = "media",
        description = "play/pause",
        on_press = function() services.media.player:play_pause() end,
    },

    binding.new {
        modifiers = {},
        triggers = "XF86AudioStop",
        path = "media",
        description = "stop",
        on_press = function() services.media.player:stop() end,
    },

    binding.new {
        modifiers = {},
        triggers = {
            { trigger = "XF86AudioPrev", offset = -1 },
            { trigger = "XF86AudioNext", offset = 1 },
        },
        path = "media",
        description = "previous/next track",
        on_press = function(trigger) services.media.player:skip(trigger.offset) end,
    },

    binding.new {
        modifiers = {},
        triggers = {
            { trigger = "XF86AudioRewind",  offset = -5 },
            { trigger = "XF86AudioForward", offset = 5 },
        },
        path = "media",
        description = "rewind/fast forward (5s)",
        on_press = function(trigger) services.media.player:seek(trigger.offset * services.media.player.second) end,
    },

    binding.new {
        modifiers = { mod.super },
        triggers = {
            { trigger = "XF86AudioRewind",  offset = -30 },
            { trigger = "XF86AudioForward", offset = 30 },
        },
        path = "media",
        description = "rewind/fast forward (30s)",
        on_press = function(trigger) services.media.player:seek(trigger.offset * services.media.player.second) end,
    },

    binding.new {
        modifiers = { mod.super },
        triggers = "XF86AudioPlay",
        path = "media",
        description = "pause all",
        on_press = function() services.media.player:pause("%all") end,
    },

    binding.new {
        modifiers = { mod.super },
        triggers = "XF86AudioStop",
        path = "media",
        description = "stop all",
        on_press = function() services.media.player:stop("%all") end,
    },

    binding.new {
        modifiers = { mod.super, mod.shift },
        triggers = "s",
        path = { "screenshot", "save to file" },
        description = "interactive selection",
        on_press = function() services.screenshot.take { mode = "selection", shader = "boxzoom" } end,
    },
}

binding.add_client_range {
    binding.new {
        modifiers = { mod.super },
        triggers = "q",
        path = "client",
        description = "quit",
        order = 0,
        on_press = function(_, client)
            if client.minimize_on_close then
                client.minimized = true
            else
                client:kill()
            end
        end,
    },

    binding.new {
        modifiers = { mod.alt },
        triggers = "F4",
        path = "client",
        description = "quit",
        order = 0,
        on_press = function(_, client)
            if client.minimize_on_close then
                client.minimized = true
            else
                client:kill()
            end
        end,
    },

    binding.new {
        modifiers = {},
        triggers = btn.left,
        on_press = function(_, client)
            client:activate { context = "mouse_click" }
        end,
    },

    binding.new {
        modifiers = { mod.super },
        triggers = btn.left,
        path = "client",
        description = "move",
        on_press = function(_, client)
            client:activate { context = "mouse_click" }
            helper_client.mouse_move(client)
        end,
    },

    binding.new {
        modifiers = { mod.super },
        triggers = btn.right,
        path = "client",
        description = "resize",
        on_press = function(_, client)
            client:activate { context = "mouse_click" }
            helper_client.mouse_resize(client)
        end,
    },

    binding.new {
        modifiers = { mod.super },
        triggers = "w",
        path = "client",
        description = "show client menu",
        on_press = function(_, client)
            mebox(menu_templates.client.main.shared):show({
                client = client,
                placement = function(menu)
                    aplacement.centered(menu, { parent = client })
                    aplacement.no_offscreen(menu, {
                        honor_workarea = true,
                        honor_padding = false,
                        margins = beautiful.popup.margins,
                    })
                end,
            }, { source = "keyboard" })
        end,
    },

    binding.new {
        modifiers = { mod.super },
        triggers = "f",
        path = { "client", "state" },
        description = "fullscreen",
        on_press = function(_, client)
            client.fullscreen = not client.fullscreen
            client:raise()
        end,
    },

    binding.new {
        modifiers = { mod.super },
        triggers = binding.group.arrows_vertical[1].trigger,
        path = { "client", "state" },
        description = "maximize",
        on_press = function(_, client)
            if client.minimized then
                client.minimized = false
            else
                client.maximized = true
            end
        end,
    },

    binding.new {
        modifiers = { mod.super },
        triggers = binding.group.arrows_vertical[2].trigger,
        path = { "client", "state" },
        description = "minimize",
        on_press = function(_, client)
            if client.maximized then
                client.maximized = false
            else
                client.minimized = true
            end
        end,
    },
}
