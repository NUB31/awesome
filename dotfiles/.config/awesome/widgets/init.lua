local widgets = {}

require "theme"

widgets.create_layoutbox = require "widgets.layoutbox"
widgets.create_taglist   = require "widgets.taglist"
widgets.create_tasklist  = require "widgets.tasklist"
widgets.create_seperator = require "widgets.seperator"
widgets.create_clock     = require "widgets.clock"
widgets.create_systray   = require "widgets.systray"

return widgets
