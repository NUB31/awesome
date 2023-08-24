local awful = require 'awful'
local ruled = require 'ruled'

ruled.client.connect_signal('request::rules', function()
   -- All clients
   ruled.client.append_rule {
      id         = 'global',
      rule       = {},
      properties = {
         focus     = awful.client.focus.filter,
         raise     = true,
         screen    = awful.screen.preferred,
         placement = awful.placement.no_overlap + awful.placement.no_offscreen
      }
   }

   ruled.client.append_rule {
      rule = { class = 'Virt-manager' },
      properties = {
         floating  = true,
         placement = awful.placement.centered,
         width     = 1600,
         height    = 900,
      },
   }

   ruled.client.append_rule {
      rule = { class = 'Gpick' },
      properties = {
         floating  = true,
         placement = awful.placement.centered,
         height    = 720,
         width     = 720,
      },
   }

   ruled.client.append_rule {
      rule = { class = 'Pavucontrol' },
      properties = {
         floating  = true,
         placement = awful.placement.bottom_right,
         height    = 720,
         width     = 550,
      },
   }
end)
