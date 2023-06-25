local awful = require "awful"

function create_layoutbox(s)
    return awful.widget.layoutbox {
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
end

return create_layoutbox
