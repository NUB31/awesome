local wibox = require "wibox"

function create_seperator(left, right, text)
    return wibox.widget({
        widget = wibox.container.margin,
        left = left,
        right = right,
        {
            widget = wibox.widget.textbox(text)
        }
    })
end

return create_seperator
