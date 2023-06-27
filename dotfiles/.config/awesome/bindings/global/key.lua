local awful = require 'awful'
local hotkeys_popup = require 'awful.hotkeys_popup'
require 'awful.hotkeys_popup.keys'
local menubar = require 'menubar'

local apps = require 'config.apps'
local mod = require 'bindings.mod'

menubar.utils.terminal = apps.terminal

-- general awesome keys
awful.keyboard.append_global_keybindings {
   awful.key {
      modifiers   = { mod.super },
      key         = 'F1',
      description = 'show help',
      group       = 'awesome',
      on_press    = hotkeys_popup.show_help,
   },
   awful.key {
      modifiers   = { mod.super, mod.ctrl },
      key         = 'r',
      description = 'reload awesome',
      group       = 'awesome',
      on_press    = awesome.restart,
   },
   awful.key {
      modifiers   = { mod.super },
      key         = 'Return',
      description = 'open a terminal',
      group       = 'launcher',
      on_press    = function() awful.spawn(apps.terminal) end,
   },
   awful.key {
      modifiers   = { mod.super },
      key         = 'r',
      description = 'run prompt',
      group       = 'launcher',
      on_press    = function() awful.spawn(apps.run) end,
   }
}

-- focus related keybindings
awful.keyboard.append_global_keybindings {
   awful.key {
      modifiers   = { mod.alt },
      key         = 'Tab',
      description = 'open window pane',
      group       = 'client',
      on_press    = function() awful.spawn(apps.windows) end,
   }
}

-- layout related keybindings
awful.keyboard.append_global_keybindings {
   awful.key {
      modifiers   = { mod.super },
      key         = '.',
      description = 'increase master width factor',
      group       = 'layout',
      on_press    = function() awful.tag.incmwfact(0.05) end,
   },
   awful.key {
      modifiers   = { mod.super },
      key         = ',',
      description = 'decrease master width factor',
      group       = 'layout',
      on_press    = function() awful.tag.incmwfact(-0.05) end,
   },
   awful.key {
      modifiers   = { mod.super },
      key         = 'space',
      description = 'select next',
      group       = 'layout',
      on_press    = function() awful.layout.inc(1) end,
   },
   awful.key {
      modifiers   = { mod.super, mod.shift },
      key         = 'space',
      description = 'select previous',
      group       = 'layout',
      on_press    = function() awful.layout.inc(-1) end,
   },
}

-- application launchers
awful.keyboard.append_global_keybindings {
   awful.key {
      modifiers   = { mod.super },
      key         = 'e',
      description = 'file browser',
      group       = 'layout',
      on_press    = function() awful.spawn(apps.file_browser) end,
   },
   awful.key {
      modifiers   = { mod.super },
      key         = 'b',
      description = 'web browser',
      group       = 'layout',
      on_press    = function() awful.spawn(apps.web_browser) end,
   },
   awful.key {
      modifiers   = { mod.super },
      key         = 'c',
      description = 'select next',
      group       = 'layout',
      on_press    = function() awful.spawn(apps.code) end,
   },
   awful.key {
      modifiers   = { mod.super, mod.shift },
      key         = 's',
      description = 'screenshot',
      group       = 'layout',
      on_press    = function()
         awful.util.spawn_with_shell(apps.screenshot(os.time(os.date("!*t"))))
      end,
   },
   awful.key {
      modifiers   = { mod.super, mod.shift },
      key         = 'c',
      description = 'screenshot',
      group       = 'layout',
      on_press    = function()
         awful.util.spawn_with_shell(apps.color_picker)
      end,
   },
}

awful.keyboard.append_global_keybindings {
   awful.key {
      modifiers   = { mod.super },
      keygroup    = 'numrow',
      description = 'only view tag',
      group       = 'tag',
      on_press    = function(index)
         local screen = awful.screen.focused()
         local tag = screen.tags[index]
         if tag then
            tag:view_only()
         end
      end
   },
   awful.key {
      modifiers   = { mod.super, mod.ctrl },
      keygroup    = 'numrow',
      description = 'move focused client to tag',
      group       = 'tag',
      on_press    = function(index)
         if client.focus then
            local tag = client.focus.screen.tags[index]
            if tag then
               client.focus:move_to_tag(tag)
            end
         end
      end
   },
   awful.key {
      modifiers   = { mod.super },
      keygroup    = 'numpad',
      description = 'select layout directly',
      group       = 'layout',
      on_press    = function(index)
         local tag = awful.screen.focused().selected_tag
         if tag then
            tag.layout = tag.layouts[index] or tag.layout
         end
      end
   },
}
