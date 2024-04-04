local awful = require 'awful'

local apps = {
   terminal       = 'alacritty',
   editor         = 'nano',
   file_browser   = 'nemo',
   web_browser    = 'firefox',
   code           = 'code',
   run            = 'rofi options -theme Monokai -show drun',
   windows        = 'rofi options -theme Monokai -show window',
   color_picker   = 'gpick --pick',
   volume_control = 'pavucontrol',
   lock_screen    = 'import -window root screenshot.png; ffmpeg -i /tmp/screenshot.png -y -vf "boxblur=50" -c:a copy /tmp/screenshotblur.png; i3lock -i /tmp/screenshotblur.png',
}

apps.editor_cmd = apps.terminal .. ' -e ' .. apps.editor
apps.manual_cmd = apps.terminal .. ' -e man awesome'

apps.screenshot = function(name)
   os.execute('mkdir -p ' .. '~/Screenshots')
   return 'import ~/Screenshots/' .. name .. '.png'
end

local vars = {
   layouts = {
      awful.layout.suit.tile,
      awful.layout.suit.floating,
   },
   tags = { '1', '2', '3' },

}

local colors = {
   light = '#ffffff',
   darkest = '#131520',
   darker = '#1d202f',
   dark = '#24283b',
   accent = '#7aa2f7'
}

local fonts = {
   mono = 'JetBrainsMono Nerd Font',
   sans = 'JetBrainsMono Nerd Font'
}

local keys = {
   alt   = 'Mod1',
   super = 'Mod4',
   shift = 'Shift',
   ctrl  = 'Control',
}

return {
   apps = apps,
   vars = vars,
   colors = colors,
   fonts = fonts,
   keys = keys,
}
