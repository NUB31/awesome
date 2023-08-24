local wibox = require 'wibox'
local container = require 'widgets.container'

function clock()
	return container {
		widget = wibox.widget.textclock
	}
end

return clock
