local dpi                      = xresources.apply_dpi

local config                   = require 'config'
local script_path              = require 'util.script_path'

local theme_folder             = script_path()

local theme                    = {}

theme.font                     = config.colors.font.sans

-- theme.useless_gap              = dpi(5) -- Breaks mouse resizer
theme.border_width             = dpi(3)

theme.border_color_normal      = config.colors.darkest
theme.border_color_active      = config.colors.accent

theme.bg_systray               = nil
theme.bg_normal                = nil

theme.hotkeys_font             = config.font.sans
theme.hotkeys_description_font = config.font.sans
theme.hotkeys_bg               = config.colors.dark
theme.hotkeys_border_color     = config.colors.darkest

theme.menu_bg_normal           = config.colors.dark
theme.menu_bg_focus            = config.colors.accent
theme.menu_height              = dpi(25)
theme.menu_width               = dpi(250)

-- Define the images to load
theme.layout_floating          = theme_folder .. 'layouts/floatingw.png'
theme.layout_tile              = theme_folder .. 'layouts/tilew.png'

theme.icon_theme               = 'Fluent Dark'

return theme
