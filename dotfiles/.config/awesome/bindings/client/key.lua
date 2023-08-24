local awful = require 'awful'
local config = require 'config'

client.connect_signal('request::default_keybindings', function()
   awful.keyboard.append_client_keybindings({
      awful.key {
         modifiers   = { config.keys.super },
         key         = 'f',
         description = 'fullscreen',
         group       = 'layout',
         on_press    = function(c)
            c.fullscreen = not c.fullscreen; c:raise()
         end,
      },
      awful.key {
         modifiers   = { config.keys.super },
         key         = 'q',
         description = 'quit application',
         group       = 'layout',
         on_press    = function(c)
            c:kill()
            awful.client.focus.byidx(1)
         end,
      },
      awful.key {
         modifiers   = { config.keys.alt },
         key         = 'F4',
         description = 'quit application',
         group       = 'layout',
         on_press    = function(c)
            c:kill()
            awful.client.focus.byidx(1)
         end,
      },
      awful.key {
         modifiers   = { config.keys.super },
         key         = 'w',
         description = 'float window',
         group       = 'layout',
         on_press    = function() awful.client.floating.toggle() end,
      },
      awful.key {
         modifiers   = { config.keys.super },
         key         = 's',
         description = 'move to next screen',
         group       = 'layout',
         on_press    = function(c) c:move_to_screen() end,
      },
      awful.key {
         modifiers   = { config.keys.super },
         key         = 't',
         description = 'keep on top',
         group       = 'layout',
         on_press    = function(c) c.ontop = not c.ontop end,
      },
      awful.key {
         modifiers   = { config.keys.super },
         key         = 'Down',
         description = 'minimize',
         group       = 'layout',
         on_press    = function(c) c.minimized = true end,
      },
      awful.key({
         modifiers   = { config.keys.super },
         key         = 'm',
         description = 'minimize',
         group       = 'layout',
         on_press    = function(c)
            c.maximized = not c.maximized
         end,
      })
   })
end)
