local capi = Capi
local awful = require("awful")
local suit = require("awful.layout.suit")
local tilted = require("layouts.tilted")

local layouts = {
    default = {
        tile = tilted.new("tile"),
        floating = suit.floating,
    },
}

capi.tag.connect_signal("request::default_layouts",
    function()
        awful.layout.append_default_layouts {
            layouts.default.tile,
            layouts.default.floating,
        }
    end
)

return layouts
