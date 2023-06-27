local awful = require "awful"
local wibox = require "wibox"
local gears = require "gears"

function create_tasklist(s)
    local function set_active_client(widget, c)
        if c == client.focus then
            widget:get_children_by_id('background_tag')[1].shape_border_color = color.accent
        else
            widget:get_children_by_id('background_tag')[1].shape_border_color = color.darkest
        end
    end

    return awful.widget.tasklist {
        screen          = s,
        layout          = {
            spacing = 4,
            layout  = wibox.layout.flex.horizontal
        },
        widget_template = {
            id = "background_tag",

            bg = color.darker,

            shape = gears.shape.rounded_rect,
            shape_border_width = 1,
            shape_border_color = color.darkest,

            widget = wibox.container.background,
            {
                widget = wibox.container.margin,
                top = 6,
                bottom = 6,
                left = 10,
                right = 10,
                {
                    layout = wibox.layout.fixed.horizontal,
                    {
                        id     = 'icon_role',
                        widget = wibox.widget.imagebox,
                    },
                    {
                        widget = wibox.container.margin,
                        left = 10,
                        right = 5,
                        {
                            id     = 'text_role',
                            widget = wibox.widget.textbox,
                        },
                    },
                },
            },

            create_callback = function(widget, c)
                set_active_client(widget, c)

                local bg_el = widget:get_children_by_id('background_tag')[1]


                widget:connect_signal('mouse::enter', function()
                    bg_el.bg = color.darkest
                end)

                widget:connect_signal('mouse::leave', function()
                    bg_el.bg = color.darker
                end)
            end,

            update_callback = set_active_client,
        },

        filter          = awful.widget.tasklist.filter.currenttags,
        buttons         = {
            awful.button {
                modifiers = {},
                button    = 1,
                on_press  = function(c)
                    c:activate { context = 'tasklist', action = 'toggle_minimization' }
                end,
            },
            awful.button {
                modifiers = {},
                button    = 3,
                on_press  = function() awful.menu.client_list { theme = { width = 300 } } end
            },
            awful.button {
                modifiers = {},
                button    = 2,
                on_press  = function(c)
                    c:kill()
                end
            },
        }
    }
end

return create_tasklist
