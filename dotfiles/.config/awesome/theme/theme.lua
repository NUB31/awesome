require "theme"
local xresources    = require "beautiful.xresources"
local rnotification = require "ruled.notification"
local dpi           = xresources.apply_dpi

local theme_folder  = script_path()

local theme         = {}


theme.font                     = font.sans

-- theme.useless_gap              = dpi(5) -- Breaks mouse resizer
theme.border_width             = dpi(3)

theme.border_color_normal      = color.darkest
theme.border_color_active      = color.accent

theme.hotkeys_font             = font.sans
theme.hotkeys_description_font = font.sans
theme.hotkeys_bg               = color.dark
theme.hotkeys_border_color     = color.darkest

theme.menu_bg_normal           = color.dark
theme.menu_bg_focus            = color.accent
theme.menu_height              = dpi(25)
theme.menu_width               = dpi(250)


-- Define the images to load
theme.layout_floating = theme_folder .. "layouts/floatingw.png"
theme.layout_tile     = theme_folder .. "layouts/tilew.png"

theme.icon_theme      = "Adwaita"

-- Set different colors for urgent notifications.
rnotification.connect_signal('request::rules', function()
    rnotification.append_rule {
        rule       = { urgency = 'critical' },
        properties = { bg = color.accent, fg = color.light }
    }
end)

return theme
