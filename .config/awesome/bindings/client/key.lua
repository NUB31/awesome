local awful = require 'awful'
local mod = require 'bindings.mod'

client.connect_signal('request::default_keybindings', function()
   awful.keyboard.append_client_keybindings({
      awful.key {
         modifiers   = { mod.super },
         key         = 'f',
         description = 'fullscreen',
         group       = 'layout',
         on_press    = function(c)
            c.fullscreen = not c.fullscreen; c:raise()
         end,
      },
      awful.key {
         modifiers   = { mod.super },
         key         = 'q',
         description = 'quit application',
         group       = 'layout',
         on_press    = function(c) c:kill() end,
      },
      awful.key {
         modifiers   = { mod.alt },
         key         = 'F4',
         description = 'quit application',
         group       = 'layout',
         on_press    = function(c) c:kill() end,
      },
      awful.key {
         modifiers   = { mod.super },
         key         = 'w',
         description = 'float window',
         group       = 'layout',
         on_press    = function() awful.client.floating.toggle() end,
      },
      awful.key {
         modifiers   = { mod.super },
         key         = 's',
         description = 'move to next screen',
         group       = 'layout',
         on_press    = function(c) c:move_to_screen() end,
      },
      awful.key {
         modifiers   = { mod.super },
         key         = 't',
         description = 'keep on top',
         group       = 'layout',
         on_press    = function(c) c.ontop = not c.ontop end,
      },
      awful.key {
         modifiers   = { mod.super },
         key         = 'Down',
         description = 'minimize',
         group       = 'layout',
         on_press    = function(c) c.minimized = true end,
      },
   })
end)
