require 'awful.hotkeys_popup.keys'

local awful = require 'awful'
local hotkeys_popup = require 'awful.hotkeys_popup'
local menubar = require 'menubar'

local config = require 'config'

menubar.utils.terminal = config.apps.terminal

-- general awesome keys
awful.keyboard.append_global_keybindings {
   awful.key {
      modifiers   = { config.keys.super },
      key         = 'F1',
      description = 'show help',
      group       = 'awesome',
      on_press    = hotkeys_popup.show_help,
   },
   awful.key {
      modifiers   = { config.keys.super, config.keys.ctrl },
      key         = 'r',
      description = 'reload awesome',
      group       = 'awesome',
      on_press    = awesome.restart,
   },
   awful.key {
      modifiers   = { config.keys.super, config.keys.ctrl },
      key         = 'l',
      description = 'quit awesome',
      group       = 'awesome',
      on_press    = awesome.quit,
   },
   awful.key {
      modifiers   = { config.keys.super },
      key         = 'Return',
      description = 'open a terminal',
      group       = 'launcher',
      on_press    = function() awful.spawn(config.apps.terminal) end,
   },
   awful.key {
      modifiers   = { config.keys.super },
      key         = 'r',
      description = 'run prompt',
      group       = 'launcher',
      on_press    = function() awful.spawn(config.apps.run) end,
   },
   awful.key {
      modifiers   = { config.keys.super },
      key         = 'l',
      description = 'lock screen',
      group       = 'awesome',
      on_press    = function() awful.util.spawn_with_shell(config.apps.lock_screen) end,
   }
}

-- focus related keybindings
awful.keyboard.append_global_keybindings {
   awful.key {
      modifiers   = { config.keys.alt },
      key         = 'Tab',
      description = 'open window pane',
      group       = 'client',
      on_press    = function() awful.spawn(config.apps.windows) end,
   }
}

-- layout related keybindings
awful.keyboard.append_global_keybindings {
   awful.key {
      modifiers   = { config.keys.super },
      key         = '.',
      description = 'increase master width factor',
      group       = 'layout',
      on_press    = function() awful.tag.incmwfact(0.05) end,
   },
   awful.key {
      modifiers   = { config.keys.super },
      key         = ',',
      description = 'decrease master width factor',
      group       = 'layout',
      on_press    = function() awful.tag.incmwfact(-0.05) end,
   },
   awful.key {
      modifiers   = { config.keys.super },
      key         = 'space',
      description = 'select next',
      group       = 'layout',
      on_press    = function() awful.layout.inc(1) end,
   },
   awful.key {
      modifiers   = { config.keys.super, config.keys.shift },
      key         = 'space',
      description = 'select previous',
      group       = 'layout',
      on_press    = function() awful.layout.inc(-1) end,
   },
}

-- application launchers
awful.keyboard.append_global_keybindings {
   awful.key {
      modifiers   = { config.keys.super },
      key         = 'e',
      description = 'file browser',
      group       = 'applications',
      on_press    = function() awful.spawn(config.apps.file_browser) end,
   },
   awful.key {
      modifiers   = { config.keys.super },
      key         = 'b',
      description = 'web browser',
      group       = 'applications',
      on_press    = function() awful.spawn(config.apps.web_browser) end,
   },
   awful.key {
      modifiers   = { config.keys.super },
      key         = 'c',
      description = 'code editor',
      group       = 'applications',
      on_press    = function() awful.spawn(config.apps.code) end,
   },
   awful.key {
      modifiers   = { config.keys.super, config.keys.shift },
      key         = 's',
      description = 'screenshot',
      group       = 'applications',
      on_press    = function()
         awful.util.spawn_with_shell(config.apps.screenshot(os.time(os.date('!*t'))))
      end,
   },
   awful.key {
      modifiers   = { config.keys.super, config.keys.shift },
      key         = 'c',
      description = 'color picker',
      group       = 'applications',
      on_press    = function()
         awful.util.spawn_with_shell(config.apps.color_picker)
      end,
   },
   awful.key {
      modifiers   = { config.keys.super },
      key         = 'a',
      description = 'volume mixer',
      group       = 'applications',
      on_press    = function()
         awful.util.spawn_with_shell(config.apps.volume_control)
      end,
   },
}

awful.keyboard.append_global_keybindings {
   awful.key {
      modifiers   = { config.keys.super },
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
      modifiers   = { config.keys.super, config.keys.ctrl },
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
      modifiers   = { config.keys.super },
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
