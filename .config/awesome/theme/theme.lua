require "theme"
local theme_assets  = require "beautiful.theme_assets"
local xresources    = require "beautiful.xresources"
local rnotification = require "ruled.notification"
local dpi           = xresources.apply_dpi

local theme_folder  = script_path()

local theme         = {}



theme.font                     = font.sans

theme.bg_normal                = color.dark
theme.bg_focus                 = color.darker
theme.bg_urgent                = color.accent
theme.bg_systray               = theme.normal

theme.fg_normal                = color.light
theme.fg_focus                 = color.light
theme.fg_urgent                = color.light
theme.fg_minimize              = color.light

theme.useless_gap              = dpi(2)
theme.border_width             = dpi(2)

theme.border_color_normal      = color.darkest
theme.border_color_active      = color.accent

theme.taglist_bg_focus         = color.accent
theme.taglist_bg_urgent        = color.accent
theme.taglist_bg_empty         = color.dark
theme.taglist_bg_occupied      = color.dark
-- theme.taglist_bg_volatile        =

theme.tasklist_bg_focus        = color.darker
theme.tasklist_bg_urgent       = color.accent
-- theme.tasklist_fg_focus          =
-- theme.tasklist_fg_urgent         =

-- theme.titlebar_bg_normal         =
-- theme.titlebar_bg_focus          =
-- theme.titlebar_fg_normal         =
-- theme.titlebar_fg_focus          =

theme.tooltip_font             = font
theme.tooltip_fg_color         = color.light
theme.tooltip_bg_color         = color.dark
theme.tooltip_border_width     = dpi(2)
theme.tooltip_border_color     = color.darkest
-- theme.tooltip_opacity            =

theme.prompt_bg_font           = font.sans
theme.prompt_fg                = color.light
-- theme.prompt_fg_cursor           =
theme.prompt_bg                = color.dark
-- theme.prompt_bg_cursor           =

theme.hotkeys_font             = font.sans
theme.hotkeys_description_font = font.sans
theme.hotkeys_bg               = color.dark
theme.hotkeys_fg               = color.light
theme.hotkeys_border_width     = dpi(2)
theme.hotkeys_border_color     = color.darkest
-- theme.hotkeys_shape              =
-- theme.hotkeys_opacity            =
-- theme.hotkeys_modifiers_fg       =
-- theme.hotkeys_label_bg           =
-- theme.hotkeys_label_fg           =
-- theme.hotkeys_group_margin       =

theme.notification_font        = "Cascadia Code"
theme.notification_bg          = color.dark
-- theme.notification_width         =
-- theme.notification_height        =
-- theme.notification_margin        =
-- theme.notification_border_color  =
-- theme.notification_border_width  =
-- theme.notification_shape         =
-- theme.notification_opacity       =

theme.menu_bg_normal           = color.dark
theme.menu_bg_focus            = color.accent
-- theme.menu_border_color          =
-- theme.menu_border_width          =
theme.menu_submenu_icon        = theme_folder .. "icons/menu-right.png"
theme.menu_height              = dpi(30)
theme.menu_width               = dpi(200)


-- Define the images to load
theme.layout_floating = theme_folder .. "layouts/floatingw.png"
theme.layout_tile     = theme_folder .. "layouts/tilew.png"

-- Generate Awesome icon:
theme.awesome_icon    = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

theme.icon_theme      = nil -- /usr/share/icons


-- Set different colors for urgent notifications.
rnotification.connect_signal('request::rules', function()
    rnotification.append_rule {
        rule       = { urgency = 'critical' },
        properties = { bg = color.accent, fg = color.light }
    }
end)

return theme
