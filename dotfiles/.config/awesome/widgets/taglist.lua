local awful  = require 'awful'
local wibox  = require 'wibox'
local gears  = require 'gears'

local config = require 'config'

function taglist(s)
    local function set_active_tag(widget, tag)
        local circle = widget:get_children_by_id('circle_tag')[1]

        if tag == s.selected_tag then
            circle.bg = config.colors.accent
        else
            circle.bg = config.colors.darker
        end
    end

    return awful.widget.taglist {
        screen          = s,
        layout          = {
            spacing = 3,

            layout = wibox.layout.flex.horizontal
        },
        widget_template = {
            layout = wibox.layout.fixed.horizontal,
            {
                id                 = 'circle_tag',
                widget             = wibox.container.background,
                bg                 = config.colors.darker,

                shape              = gears.shape.rounded_rect,
                shape_border_width = 1,
                shape_border_color = config.colors.darkest,
                {
                    widget = wibox.container.margin,
                    left = 6,
                    right = 6,
                    {
                        id     = 'index_tag',
                        widget = wibox.widget.textbox,
                    }
                },

            },

            create_callback = function(widget, tag, index)
                widget:get_children_by_id('index_tag')[1].markup = '<b> ' .. index .. ' </b>'

                set_active_tag(widget, tag)

                local circle = widget:get_children_by_id('circle_tag')[1]
                widget:connect_signal('mouse::enter', function()
                    circle.bg = config.colors.darkest
                end)

                widget:connect_signal('mouse::leave', function()
                    if tag == s.selected_tag then
                        circle.bg = config.colors.accent
                    else
                        circle.bg = config.colors.darker
                    end
                end)
            end,

            update_callback = set_active_tag
        },
        filter          = awful.widget.taglist.filter.all,
        buttons         = {
            awful.button {
                modifiers = {},
                button    = 1,
                on_press  = function(t) t:view_only() end,
            },
            awful.button {
                modifiers = { config.keys.super },
                button    = 1,
                on_press  = function(t)
                    if client.focus then
                        client.focus:move_to_tag(t)
                        t:view_only()
                    end
                end,
            },
        }
    }
end

return taglist
