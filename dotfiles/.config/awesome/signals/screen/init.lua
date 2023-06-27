local awful   = require 'awful'
local wibox   = require 'wibox'

local vars    = require 'config.vars'
local widgets = require 'widgets'

screen.connect_signal('request::desktop_decoration', function(s)
   awful.tag(vars.tags, s, awful.layout.layouts[1])

   awful.wibar {
      bg = color.dark,
      fg = color.light,
      height = 35,
      screen = s,
      position = 'top',
      widget = {
         layout = wibox.container.margin,
         top = 4,
         bottom = 4,
         left = 8,
         right = 8,
         {
            layout = wibox.layout.align.horizontal,
            -- left widgets
            {
               layout = wibox.layout.fixed.horizontal,

               widgets.create_taglist(s),
               widgets.create_seperator(8, 8, "|"),
            },
            { -- Middle widget
               layout = wibox.layout.fixed.horizontal,

               widgets.create_tasklist(s),
            },
            -- right widgets
            {
               layout = wibox.layout.fixed.horizontal,

               widgets.create_seperator(4, 4, ""),
               widgets.create_systray(),
               widgets.create_seperator(8, 8, "|"),
               widgets.create_clock(),
               widgets.create_seperator(8, 8, "|"),
               widgets.create_layoutbox(s),
            }
         }
      }
   }
end)
