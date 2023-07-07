local awful = require 'awful'
local ruled = require 'ruled'

ruled.client.connect_signal('request::rules', function()
   -- All clients will match this rule.
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
      rule = { class = "Virt-manager" },
      properties = {
         floating  = true,
         placement = awful.placement.centered,
         width     = 1600,
         height    = 900,
      },
   }

   ruled.client.append_rule {
      rule = { class = "Gpick" },
      properties = {
         floating  = true,
         placement = awful.placement.centered,
         height    = 720,
         width     = 720,
      },
   }

   -- Floating clients.
   ruled.client.append_rule {
      id = 'floating',
      rule_any = {
         role = {
            'AlarmWindow',
            'ConfigManager',
         }
      },
      properties = { floating = true }
   }

   -- Add titlebars to normal clients and dialogs
   ruled.client.append_rule {
      id         = 'titlebars',
      rule_any   = { type = { 'normal', 'dialog' } },
      properties = { titlebars_enabled = true },
   }
end)
