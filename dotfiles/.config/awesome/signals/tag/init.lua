local awful = require 'awful'

local config = require 'config'

tag.connect_signal('request::default_layouts', function()
   awful.layout.append_default_layouts(config.vars.layouts)
end)
