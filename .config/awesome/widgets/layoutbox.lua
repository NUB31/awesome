local awful = require "awful"
local wibox = require "wibox"
local gears = require "gears"

function create_layoutbox(s)
    return wibox.widget({
        widget             = wibox.container.background,
        bg                 = color.darker,

        shape              = gears.shape.rounded_rect,
        shape_border_width = 1,
        shape_border_color = color.darkest,
        {
            widget = wibox.container.margin,
            left = 7,
            right = 7,
            top = 5,
            bottom = 5,

            awful.widget.layoutbox {
                screen = s,

                buttons = {
                    awful.button {
                        modifiers = {},
                        button    = 1,
                        on_press  = function() awful.layout.inc(1) end,
                    },
                    awful.button {
                        modifiers = {},
                        button    = 3,
                        on_press  = function() awful.layout.inc(-1) end,
                    },
                }
            }
        }
    })
end

return create_layoutbox
