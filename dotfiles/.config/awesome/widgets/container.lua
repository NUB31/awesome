local wibox = require 'wibox'
local gears = require 'gears'
local config = require 'config'

function container(widget, id)
	return wibox.widget({
		id                 = id,
		widget             = wibox.container.background,
		bg                 = config.colors.darker,

		shape              = gears.shape.rounded_rect,
		shape_border_width = 1,
		shape_border_color = config.colors.darkest,
		{
			widget = wibox.container.margin,
			left = 8,
			right = 8,

			widget
		}
	})
end

return container
