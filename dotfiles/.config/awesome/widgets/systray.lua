local wibox = require 'wibox'
local container = require 'widgets.container'

function systray()
    return container {
        widget = wibox.widget.systray
    }
end

return systray
