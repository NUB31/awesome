local widgets = {}

require "theme"
local awful = require 'awful'
local wibox = require 'wibox'


widgets.keyboardlayout   = awful.widget.keyboardlayout()
widgets.textclock        = wibox.widget.textclock()

widgets.create_layoutbox = require "widgets.layoutbox"
widgets.create_taglist   = require "widgets.taglist"
widgets.create_tasklist  = require "widgets.tasklist"

return widgets
