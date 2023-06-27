local awful = require "awful"
local wibox = require "wibox"
local gears = require "gears"
local mod   = require 'bindings.mod'

function create_taglist(s)
    local function set_active_tag(widget, tag)
        local circle = widget:get_children_by_id('circle_tag')[1]

        if tag == s.selected_tag then
            circle.bg = color.accent
        else
            circle.bg = color.darker
        end
    end

    return awful.widget.taglist {
        screen          = s,
        layout          = {
            spacing = 3,

            layout = wibox.layout.flex.horizontal
        },
        widget_template = {
            {
                layout = wibox.layout.fixed.horizontal,
                {

                    id     = 'circle_tag',
                    widget = wibox.container.background,
                    bg     = color.darker,


                    shape              = gears.shape.rounded_rect,
                    shape_border_width = 1,
                    shape_border_color = color.darkest,
                    {
                        {
                            id     = 'index_tag',
                            widget = wibox.widget.textbox,
                        },
                        margins = 6,
                        widget  = wibox.container.margin,
                    },
                },
                {
                    widget = wibox.widget.imagebox,
                },
            },
            widget          = wibox.container.background,

            create_callback = function(widget, tag, index)
                widget:get_children_by_id('index_tag')[1].markup = '<b> ' .. index .. ' </b>'

                set_active_tag(widget, tag)

                local circle = widget:get_children_by_id('circle_tag')[1]
                widget:connect_signal('mouse::enter', function()
                    circle.bg = color.darkest
                end)

                widget:connect_signal('mouse::leave', function()
                    if tag == s.selected_tag then
                        circle.bg = color.accent
                    else
                        circle.bg = color.darker
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
                modifiers = { mod.super },
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

return create_taglist
