local awful   = require 'awful'
local wibox   = require 'wibox'

local config  = require 'config'
local widgets = require 'widgets'

screen.connect_signal('request::desktop_decoration', function(s)
   awful.tag(config.vars.tags, s, awful.layout.layouts[1])

   awful.wibar {
      bg = config.colors.dark,
      fg = config.colors.light,
      height = 40,
      screen = s,
      position = 'bottom',
      widget = {
         layout = wibox.container.margin,
         top = 8,
         bottom = 8,
         left = 8,
         right = 8,
         {
            layout = wibox.layout.align.horizontal,
            -- left widgets
            {
               layout = wibox.layout.fixed.horizontal,

               widgets.taglist(s),
               widgets.seperator(8, 8, '|'),
            },
            { -- Middle widget
               layout = wibox.layout.fixed.horizontal,

               widgets.tasklist(s),
            },
            -- right widgets
            {
               layout = wibox.layout.fixed.horizontal,

               widgets.seperator(4, 4, ''),
               widgets.systray(),
               widgets.seperator(8, 8, '|'),
               widgets.clock(),
               widgets.seperator(8, 8, '|'),
               widgets.layoutbox(s),
            }
         }
      }
   }
end)
