local wibox = require "wibox"
local gears = require "gears"

function create_clock()
    return wibox.widget({
        widget             = wibox.container.background,
        bg                 = color.darker,

        shape              = gears.shape.rounded_rect,
        shape_border_width = 1,
        shape_border_color = color.darkest,
        {
            widget = wibox.container.margin,
            left = 6,
            right = 6,
            top = 3,
            bottom = 3,

            wibox.widget.systray()
        }
    })
end

return create_clock
